# Proveedor AWS
provider "aws" {
  region = var.region
}

# Variables necesarias
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

# Crear un bucket S3
resource "aws_s3_bucket" "csv_bucket" {
  bucket = "${replace(lower(var.project_name), "_", "-")}-csv-bucket"
  tags = {
    Project = var.project_name
  }

  lifecycle {
    prevent_destroy = true
  }
}

# Rol IAM para Lambda
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

# Política IAM con permisos para S3, Athena, Glue y CloudWatch
resource "aws_iam_policy" "lambda_policy" {
  name   = "${var.project_name}_lambda_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Permisos para S3
      {
        Effect   = "Allow"
        Action   = [
          "s3:PutObject",
          "s3:GetObject"
        ]
        Resource = "arn:aws:s3:::${aws_s3_bucket.csv_bucket.bucket}/*"
      },
      # Permisos para Athena y Glue
      {
        Effect   = "Allow"
        Action   = [
          "athena:StartQueryExecution",
          "athena:GetQueryResults",
          "glue:GetTable",
          "glue:GetDatabase"
        ]
        Resource = "*"
      },
      # Permisos para CloudWatch
      {
        Effect   = "Allow"
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

# Adjuntar la política al rol Lambda
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Crear una función Lambda para procesamiento inicial
resource "aws_lambda_function" "csv_processor" {
  function_name = var.lambda_function_name
  runtime       = var.lambda_runtime
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda.lambda_handler"
  filename      = "./lambda_code.zip"
  source_code_hash = filebase64sha256("./lambda_code.zip")

  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.csv_bucket.bucket
      OUTPUT_PATH = "/processed/"
    }
  }
}

# Función Lambda para análisis con SafeMake
resource "aws_lambda_function" "safemake_analyzer" {
  function_name = "safemake_analyzer"
  runtime       = var.lambda_runtime
  role          = aws_iam_role.lambda_role.arn
  handler       = "safemake.lambda_handler"
  filename      = "./safemake_code.zip"
  source_code_hash = filebase64sha256("./safemake_code.zip")

  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.csv_bucket.bucket
      INPUT_PATH  = "/processed/"
      OUTPUT_PATH = "/predictions/"
    }
  }
}

# Integrar con Quicq (Dashboard Generation)
resource "aws_quicksight_dataset" "quicq_dashboard" {
  data_set_id = "csv_analysis_dashboard"
  aws_account_id = "your-account-id"

  import_mode = "SPICE"

  physical_table_map = {
    "csvTable" = {
      s3_source = {
        input_columns = [
          {
            name = "column1"
            type = "STRING"
          },
          {
            name = "column2"
            type = "STRING"
          }
        ]
        data_source_arn = aws_s3_bucket.csv_bucket.arn
        upload_settings = {
          format          = "CSV"
          contains_header = true
        }
      }
    }
  }
}

# Crear outputs
output "s3_bucket_name" {
  description = "Nombre del bucket S3"
  value       = aws_s3_bucket.csv_bucket.bucket
}

output "lambda_processor" {
  description = "Lambda inicial para procesamiento"
  value       = aws_lambda_function.csv_processor.function_name
}

output "safemake_analyzer" {
  description = "Lambda para análisis con SafeMake"
  value       = aws_lambda_function.safemake_analyzer.function_name
}

output "quicq_dashboard_id" {
  description = "ID del Dashboard en Quicq"
  value       = aws_quicksight_dataset.quicq_dashboard.data_set_id
}
