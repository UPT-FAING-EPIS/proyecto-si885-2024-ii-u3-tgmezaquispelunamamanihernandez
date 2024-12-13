import tkinter as tk
from tkinter import filedialog, messagebox
import boto3
from botocore.exceptions import NoCredentialsError, PartialCredentialsError

# Crear un cliente S3 usando el perfil 'cristian'
session = boto3.Session(profile_name='cristian')
s3 = session.client('s3')

# Función para seleccionar el archivo CSV
def seleccionar_archivo():
    archivo = filedialog.askopenfilename(filetypes=[("Archivos CSV", "*.csv")])
    if archivo:
        # Mostrar la ruta del archivo en el campo de texto
        entry_archivo.delete(0, tk.END)
        entry_archivo.insert(0, archivo)

# Función para subir el archivo CSV a S3
def subir_archivo():
    archivo_local = entry_archivo.get()
    if not archivo_local:
        messagebox.showerror("Error", "Por favor, selecciona un archivo CSV.")
        return
    
    # Nombre del bucket de S3 y el nombre del archivo en S3
    bucket_name = 'mi-bucket-csv'  # Cambia esto por tu bucket
    s3_file_name = archivo_local.split("/")[-1]  # Obtiene el nombre del archivo
    
    try:
        # Subir el archivo al bucket de S3
        s3.upload_file(archivo_local, bucket_name, s3_file_name)
        messagebox.showinfo("Éxito", f"Archivo {s3_file_name} subido correctamente a S3.")
    except FileNotFoundError:
        messagebox.showerror("Error", "El archivo no se encontró.")
    except NoCredentialsError:
        messagebox.showerror("Error", "No se encontraron las credenciales de AWS.")
    except PartialCredentialsError:
        messagebox.showerror("Error", "Credenciales incompletas, revisa tu configuración.")
    except Exception as e:
        messagebox.showerror("Error", f"Ocurrió un error: {e}")

# Crear la ventana principal
ventana = tk.Tk()
ventana.title("Subir archivo CSV a S3")
ventana.geometry("400x200")

# Etiqueta
etiqueta = tk.Label(ventana, text="Selecciona un archivo CSV para subir a S3:")
etiqueta.pack(pady=10)

# Campo de texto para mostrar la ruta del archivo seleccionado
entry_archivo = tk.Entry(ventana, width=40)
entry_archivo.pack(pady=10)

# Botón para seleccionar el archivo CSV
boton_seleccionar = tk.Button(ventana, text="Seleccionar archivo", command=seleccionar_archivo)
boton_seleccionar.pack(pady=5)

# Botón para subir el archivo a S3
boton_subir = tk.Button(ventana, text="Subir a S3", command=subir_archivo)
boton_subir.pack(pady=10)

# Ejecutar la interfaz
ventana.mainloop()
