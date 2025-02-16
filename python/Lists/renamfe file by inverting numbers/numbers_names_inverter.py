import os
import re
import sys

def get_numbered_files(directory):
    pattern = re.compile(r'^(\d+)(\s?)(.*)$')  # Capture the number + optional space + name
    files = []
    for filename in os.listdir(directory):
        match = pattern.match(filename)
        if match:
            num, space, name = match.groups()
            files.append((int(num), num, space, name, filename))  # Store the number as int and str
    return sorted(files, key=lambda x: x[0])  # Sort by number

def rename_files(directory):
    files = get_numbered_files(directory)
    if not files:
        print("No files found with the expected numbering format.")
        return
    
    total_files = len(files)
    max_digits = len(files[-1][1])  # Number of digits of the largest number
    
    temp_renames = []  # Store temporary names to avoid conflicts
    
    reversed_files = list(reversed(files))
    for i, (orig_num, orig_str, space, name, old_filename) in enumerate(reversed_files, start=1):
        new_num = str(i).zfill(len(orig_str))  # Ensure the same numbering format
        new_filename = f"{new_num}{space}{name}"
        temp_renames.append((old_filename, new_filename))
    
    # Rename files with temporary names to avoid conflicts
    for old_filename, temp_filename in temp_renames:
        os.rename(os.path.join(directory, old_filename), os.path.join(directory, "temp_" + temp_filename))
    
    # Apply final names
    for _, temp_filename in temp_renames:
        final_filename = temp_filename.replace("temp_", "", 1)
        os.rename(os.path.join(directory, "temp_" + temp_filename), os.path.join(directory, final_filename))
    
    print("Renaming completed successfully.")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        directory = sys.argv[1].strip()
    else:
        directory = input("Enter the directory path: ").strip()
    rename_files(directory)
