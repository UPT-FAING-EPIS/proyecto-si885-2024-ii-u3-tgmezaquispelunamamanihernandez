# Proveedor AWS
provider "aws" {
  region = var.region
}

# Definición de variables
variable "region" {
  description = "Región de AWS para los recursos"
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nombre del proyecto"
  default     = "data_analysis_project"
}

variable "lambda_function_name" {
  description = "Nombre de la función Lambda"
  default     = "csv_processor"
}

variable "lambda_runtime" {
  description = "Runtime para la función Lambda"
  default     = "python3.9"
}

# Bucket S3 para almacenar archivos CSV procesados
resource "aws_s3_bucket" "csv_bucket" {
  bucket = "${replace(lower(var.project_name), "_", "-")}-csv-bucket"
  
  tags = {
    Project = var.project_name
  }

  lifecycle {
    prevent_destroy = true  # Asegura que el bucket no sea destruido accidentalmente
  }
}

# Rol IAM para Lambda con permisos adecuados
resource "aws_iam_role" "lambda_role" {
  name               = "${var.lambda_function_name}_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Política IAM para Lambda (Permiso de acceso a S3, Athena y Glue)
resource "aws_iam_policy" "lambda_s3_athena_glue_policy" {
  name   = "${var.project_name}_lambda_s3_athena_glue_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Permisos para acceder a objetos en S3
      {
        Effect   = "Allow"
        Action   = "s3:PutObject"
        Resource = "arn:aws:s3:::${aws_s3_bucket.csv_bucket.bucket}/*"
      },
      {
        Effect   = "Allow"
        Action   = "s3:GetObject"
        Resource = "arn:aws:s3:::${aws_s3_bucket.csv_bucket.bucket}/*"
      },
      # Permisos para ejecutar consultas en Athena
      {
        Effect   = "Allow"
        Action   = [
          "athena:StartQueryExecution",
          "athena:GetQueryResults",
          "athena:ListTableMetadata"
        ]
        Resource = "*"
      },
      # Permisos para interactuar con Glue
      {
        Effect   = "Allow"
        Action   = [
          "glue:GetTable",
          "glue:GetDatabase",
          "glue:BatchGetTable"
        ]
        Resource = "*"
      },
      # Permiso para asumir el rol
      {
        Effect   = "Allow"
        Action   = "iam:PassRole"
        Resource = aws_iam_role.lambda_role.arn
      }
    ]
  })
}

# Adjuntar la política de S3, Athena y Glue al rol de Lambda
resource "aws_iam_role_policy_attachment" "lambda_s3_athena_glue_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_s3_athena_glue_policy.arn
}

# Función Lambda que procesará el archivo CSV
resource "aws_lambda_function" "csv_processor_lambda" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda.lambda_handler"
  runtime       = var.lambda_runtime

  # Ruta del archivo ZIP que contiene el código de la función Lambda
  filename      = "./lambda_code.zip"  # Asegúrate de que el archivo ZIP se haya generado previamente
  source_code_hash = filebase64sha256("./lambda_code.zip")

  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.csv_bucket.bucket  # Configuración del nombre del bucket S3
    }
  }

  tags = {
    Project = var.project_name
  }
}

# AWS Glue: Crea un catálogo de base de datos para los archivos CSV
resource "aws_glue_catalog_database" "csv_database" {
  name = "${var.project_name}_csv_database"
}

# AWS Glue: Crea una tabla para los archivos CSV en el catálogo de Glue
resource "aws_glue_catalog_table" "csv_table" {
  name          = "csv_data"
  database_name = aws_glue_catalog_database.csv_database.name

  table_type = "EXTERNAL_TABLE"
  storage_descriptor {
    location      = "s3://${aws_s3_bucket.csv_bucket.bucket}/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
    columns {
      name = "column1"
      type = "string"
    }
    columns {
      name = "column2"
      type = "string"
    }
  }
}

# AWS Glue: Crea un Crawler para procesar los archivos CSV en el bucket S3
resource "aws_glue_crawler" "csv_crawler" {
  name          = "csv-crawler"
  role          = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.csv_database.name
  s3_target {
    path = "s3://${aws_s3_bucket.csv_bucket.bucket}/"
  }

  classifiers = []  # Glue detecta el tipo de archivo automáticamente sin necesidad de clasificadores

  table_prefix = "csv_"  # Prefijo para las tablas que se crean
}

# AWS Athena: Crear una base de datos en Athena (usando Glue como origen de datos)
resource "aws_athena_database" "csv_athena_database" {
  name   = "${var.project_name}_athena_db"
  bucket = aws_s3_bucket.csv_bucket.bucket
}

# Salidas (outputs) de la configuración de recursos
output "s3_bucket_name" {
  description = "Nombre del bucket S3"
  value       = aws_s3_bucket.csv_bucket.bucket
}

output "lambda_function_name" {
  description = "Nombre de la función Lambda"
  value       = aws_lambda_function.csv_processor_lambda.function_name
}

output "athena_database_name" {
  description = "Nombre de la base de datos de Athena"
  value       = aws_athena_database.csv_athena_database.name
}

output "athena_table_name" {
  description = "Nombre de la tabla de Athena"
  value       = aws_glue_catalog_table.csv_table.name
}

# Grupo de logs de CloudWatch para Lambda
resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 14
}

# Política IAM para logs de CloudWatch
resource "aws_iam_policy" "lambda_logging_policy" {
  name   = "${var.project_name}_lambda_logging_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "logs:CreateLogGroup"
        Resource = "arn:aws:logs:${var.region}:*:*"
      },
      {
        Effect   = "Allow"
        Action   = "logs:CreateLogStream"
        Resource = "arn:aws:logs:${var.region}:*:*"
      },
      {
        Effect   = "Allow"
        Action   = "logs:PutLogEvents"
        Resource = "arn:aws:logs:${var.region}:*:*"
      }
    ]
  })
}

# Adjuntar la política de logs al rol de Lambda
resource "aws_iam_role_policy_attachment" "lambda_logging_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_logging_policy.arn
}

