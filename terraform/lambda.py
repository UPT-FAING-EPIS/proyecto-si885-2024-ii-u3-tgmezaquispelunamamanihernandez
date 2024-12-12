import json
import boto3
import csv
import os

# Inicializamos el cliente de S3
s3_client = boto3.client('s3')

def lambda_handler(event, context):
    try:
        # El nombre del bucket de S3 desde las variables de entorno
        bucket_name = os.environ['BUCKET_NAME']
        
        # Aquí creamos algunos datos de ejemplo que queremos escribir en el CSV
        # Si el archivo CSV es generado de alguna otra forma, puedes ajustar esta parte
        data_to_write = [
            ['Column1', 'Column2'],  # Encabezado del CSV
            ['Value1', 'Value2'],
            ['Value3', 'Value4']
        ]

        # Especificamos la clave (nombre) del archivo CSV que será subido a S3
        csv_file_key = 'generated_data.csv'  # Nombre del archivo CSV en S3

        # Ruta temporal en Lambda para guardar el archivo CSV
        local_file_path = '/tmp/' + csv_file_key

        # Escribimos los datos en un archivo CSV en el sistema de archivos temporal de Lambda
        with open(local_file_path, mode='w', newline='') as file:
            csv_writer = csv.writer(file)
            csv_writer.writerows(data_to_write)

        # Subimos el archivo CSV generado a S3
        s3_client.upload_file(local_file_path, bucket_name, csv_file_key)

        return {
            'statusCode': 200,
            'body': json.dumps(f"Archivo CSV generado y subido a S3 como {csv_file_key}")
        }

    except Exception as e:
        # Si ocurre un error, lo reportamos
        print(f"Error: {str(e)}")
        return {
            'statusCode': 500,
            'body': json.dumps(f"Error al generar o subir el archivo CSV: {str(e)}")
        }
