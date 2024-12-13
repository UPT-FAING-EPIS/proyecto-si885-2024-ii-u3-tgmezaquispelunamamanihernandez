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

variable "lambda_runtime" {
  description = "Runtime para las funciones Lambda"
  default     = "python3.9"
}

# Bucket S3 para datos originales y procesados
resource "aws_s3_bucket" "csv_bucket" {
  bucket = "${replace(lower(var.project_name), "_", "-")}-csv-bucket"
  tags = {
    Project = var.project_name
  }

  lifecycle {
    prevent_destroy = true
  }
}

# Bucket S3 para resultados de predicciones
resource "aws_s3_bucket" "predictions_bucket" {
  bucket = "${replace(lower(var.project_name), "_", "-")}-predictions-bucket"
  tags = {
    Project = var.project_name
  }

  lifecycle {
    prevent_destroy = true
  }
}

# Rol IAM para Lambda
resource "aws_iam_role" "lambda_role" {
  name               = "${var.project_name}_lambda_role"
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

# Política IAM para Lambda
resource "aws_iam_policy" "lambda_policy" {
  name   = "${var.project_name}_lambda_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Permisos para S3
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:PutObject"]
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.csv_bucket.bucket}/*",
          "arn:aws:s3:::${aws_s3_bucket.predictions_bucket.bucket}/*"
        ]
      },
      # Permisos para logs
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

# Adjuntar la política al rol IAM
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Lambda para procesamiento inicial
resource "aws_lambda_function" "csv_processor" {
  function_name = "csv_processor"
  runtime       = var.lambda_runtime
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda.lambda_handler"
  filename      = "./csv_processor.zip"
  source_code_hash = filebase64sha256("./csv_processor.zip")

  environment {
    variables = {
      INPUT_BUCKET  = aws_s3_bucket.csv_bucket.bucket
      OUTPUT_BUCKET = aws_s3_bucket.csv_bucket.bucket
      OUTPUT_PATH   = "/processed/"
    }
  }
}

# Lambda para SafeMake (análisis de predicción)
resource "aws_lambda_function" "safemake_analyzer" {
  function_name = "safemake_analyzer"
  runtime       = var.lambda_runtime
  role          = aws_iam_role.lambda_role.arn
  handler       = "safemake.lambda_handler"
  filename      = "./safemake_analyzer.zip"
  source_code_hash = filebase64sha256("./safemake_analyzer.zip")

  environment {
    variables = {
      INPUT_BUCKET  = aws_s3_bucket.csv_bucket.bucket
      OUTPUT_BUCKET = aws_s3_bucket.predictions_bucket.bucket
      INPUT_PATH    = "/processed/"
      OUTPUT_PATH   = "/predictions/"
    }
  }
}

# Integración con QuickSight (Gráfico para dashboards)
resource "aws_quicksight_dataset" "quicq_dashboard" {
  data_set_id    = "csv_analysis_dashboard"
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
          },
          {
            name = "prediction"
            type = "STRING"
          }
        ]
        data_source_arn = aws_s3_bucket.predictions_bucket.arn
        upload_settings = {
          format          = "CSV"
          contains_header = true
        }
      }
    }
  }
}

# Outputs de los recursos
output "s3_csv_bucket" {
  description = "Bucket para los datos CSV originales"
  value       = aws_s3_bucket.csv_bucket.bucket
}

output "s3_predictions_bucket" {
  description = "Bucket para los resultados de predicciones"
  value       = aws_s3_bucket.predictions_bucket.bucket
}

output "quicksight_dashboard_id" {
  description = "ID del Dashboard en QuickSight"
  value       = aws_quicksight_dataset.quicq_dashboard.data_set_id
}
