import zipfile

def extract_zip(zip_file, extract_to, password=None):
    try:
        with zipfile.ZipFile(zip_file, 'r') as zip_ref:
            if password:
                zip_ref.setpassword(password.encode())
            zip_ref.extractall(extract_to)
        print("Boom! Password bypassed, files extracted!")
    except Exception as e:
        print(f"Error: {e}")

# Usage example
zip_file = "protected.zip"
extract_to = "extracted_files"
password = None
extract_zip(zip_file, extract_to, password)
