#!/usr/bin/env python3
import time
import tkinter as tk
from tkinter import filedialog
from googlesearch import search


ASCII_BANNER = r"""
 .d8888b.  888                       888                   888      
d88P  Y88b 888                       888                   888      
Y88b.      888                       888                   888      
 "Y888b.   88888b.   .d88b.  888d888 888  .d88b.   .d8888b 888  888 
    "Y88b. 888 "88b d8P  Y8b 888P"   888 d88""88b d88P"    888 .88P 
      "888 888  888 88888888 888     888 888  888 888      888888K  
Y88b  d88P 888  888 Y8b.     888     888 Y88..88P Y88b.    888 "88b 
 "Y8888P"  888  888  "Y8888  888     888  "Y88P"   "Y8888P 888  888 
                                                                    
                                                                    
"""

def search_query(query, num_results=5):
    """Performs a Google search for the given query.
    In case of an error (e.g., err. 429), a concise message is displayed and an empty list is returned."""
    try:
        results = list(search(query, num_results=num_results))
        return results
    except Exception as e:
        err_str = str(e)
        if "429" in err_str:
            print(f"Too many requests (err. 429) - search aborted for query: {query}")
        else:
            print(f"Error encountered for query '{query}': {e} - search aborted")
        return []

def main():
    print(ASCII_BANNER)

    company = input("Please enter the company name: ").strip()
    
    # Define search queries for legal investigation
    queries = [
        f'"{company}" scam',
        f'"{company}" fraud',
        f'"{company}" complaint',
        f'"{company}" review',
        f'site:trustpilot.com "{company}"'
    ]
    
    found_urls = set()
    
    print(f"\nSearching for public information on: {company}")
    for query in queries:
        print(f"\nQuery: {query}")
        results = search_query(query, num_results=5)
        for url in results:
            if url not in found_urls:
                found_urls.add(url)
                print(f"  {url}")
        # Minimal delay between queries
        time.sleep(0.5)
    
    # Prepare investigation report as text
    report_text = f"Investigation Report for: {company}\n{'='*50}\n\nFound URLs:\n"
    for url in sorted(found_urls):
        report_text += f" - {url}\n"
    
    print("\nSearch completed.")
    print("\nFound URLs:")
    for url in sorted(found_urls):
        print(f" - {url}")
    
    # Ask if the user wants to save the report to a text file
    choice_save = input("\nDo you want to save the report to a text file? (y/n): ").strip().lower()
    if choice_save == "y":
        root = tk.Tk()
        root.withdraw()  # Hide the main window
        file_path = filedialog.asksaveasfilename(
            title="Save report",
            defaultextension=".txt",
            filetypes=[("Text files", "*.txt")]
        )
        if file_path:
            try:
                with open(file_path, "w", encoding="utf-8") as f:
                    f.write(report_text)
                print(f"Report saved to {file_path}")
            except Exception as e:
                print(f"Error saving file: {e}")
        else:
            print("No file selected. Report not saved.")
    else:
        print("Report not saved.")

if __name__ == "__main__":
    main()
