```
 .d8888b.  888                       888                   888      
d88P  Y88b 888                       888                   888      
Y88b.      888                       888                   888      
 "Y888b.   88888b.   .d88b.  888d888 888  .d88b.   .d8888b 888  888 
    "Y88b. 888 "88b d8P  Y8b 888P"   888 d88""88b d88P"    888 .88P 
      "888 888  888 88888888 888     888 888  888 888      888888K  
Y88b  d88P 888  888 Y8b.     888     888 Y88..88P Y88b.    888 "88b 
 "Y8888P"  888  888  "Y8888  888     888  "Y88P"   "Y8888P 888  888 

```

# Google Dork Cheatsheet

This repository compiles various search filters, operators, and advanced Google dorks to help refine your online research. These techniques are intended for **educational and investigative purposes only**—for example, to identify potentially fraudulent companies, read product reviews, or learn more about a website's reputation. Use this information responsibly and ethically.

> **Disclaimer:**  
> The techniques and queries provided here are for legitimate research and investigative purposes only. They are not intended to facilitate any unauthorized or illegal activity. The repository owner assumes no responsibility for any misuse of this information.

---

## 1. Search Filters

| Filter                                 | Description                                                    | Example                                                      |
|----------------------------------------|----------------------------------------------------------------|--------------------------------------------------------------|
| `allintext:"..."`                      | All specified words must appear in the page text.              | `allintext:"customer review"`                                |
| `intext:"..."`                         | Searches for the words in the text, regardless of order.         | `intext:"quality feedback"`                                  |
| `inurl:"..."`                          | The specified word appears in the URL.                           | `inurl:"about-us"`                                           |
| `allinurl:"..."`                       | All specified words appear in the URL.                           | `allinurl:"shop product"`                                    |
| `intitle:"..."`                        | The specified word appears in the page title.                    | `intitle:"review"`                                           |
| `allintitle:"..."`                     | All specified words appear in the page title.                    | `allintitle:"customer review"`                               |
| `site:"..."`                           | Searches within a specific site or domain.                       | `site:amazon.com`                                            |
| `filetype:"..."`                       | Searches for a particular file type.                             | `filetype:pdf`                                               |
| `link:"..."`                           | Searches for pages linking to a specified URL.                    | `link:example.com`                                           |
| `numrange:...`                         | Searches for numbers within a specific range.                     | `numrange:100-200`                                           |
| `before:YYYY-MM-DD` / `after:YYYY-MM-DD` | Limits search to a specific date range.                           | `filetype:pdf before:2020-01-01 after:2019-01-01`              |
| `inanchor:"..."`                       | Searches for keywords in the anchor text of links.                | `inanchor:"buy now"`                                         |
| `related:"..."`                        | Finds pages similar to the specified URL.                         | `related:example.com`                                        |
| `cache:"..."`                          | Displays the cached version of a page.                             | `cache:example.com`                                          |

---

## 2. Advanced Google Dorks for Investigative Research

These advanced queries are designed for legitimate research purposes. They can help you gather information on businesses, product reviews, or website reputation—useful, for example, when trying to identify fraudulent companies or assess public feedback on products.

### 2.1 Business Investigations

| Dork | Description | Example |
|------|-------------|---------|
| `site:trustpilot.com "fraud" "company name"` | Searches Trustpilot for reviews mentioning fraud for a specific company. | `site:trustpilot.com "fraud" "Acme Corp"` |
| `intext:"complaint" inurl:"reviews" "company name"` | Looks for customer complaints on review sites for a given company. | `intext:"complaint" inurl:"reviews" "Acme Corp"` |
| `intext:"scam" "company name"` | Finds pages where a company is potentially labeled as a scam. | `intext:"scam" "Acme Corp"` |

### 2.2 Product Reviews & Consumer Feedback

| Dork | Description | Example |
|------|-------------|---------|
| `intext:"review" "product name"` | Searches for pages that contain reviews of a specific product. | `intext:"review" "SuperWidget"` |
| `site:amazon.com intext:"customer review" "product name"` | Finds customer reviews on Amazon for a given product. | `site:amazon.com intext:"customer review" "SuperWidget"` |
| `intext:"feedback" "product name"` | Looks for general feedback or testimonials regarding a product. | `intext:"feedback" "SuperWidget"` |

### 2.3 Website Reputation and Data

| Dork | Description | Example |
|------|-------------|---------|
| `site:whois.domaintools.com "company name"` | Searches for WHOIS information about a company's website. | `site:whois.domaintools.com "Acme Corp"` |
| `intext:"About Us" "company name"` | Finds "About Us" pages for a company to learn more about its background. | `intext:"About Us" "Acme Corp"` |
| `intext:"review" "website name"` | Searches for reviews or discussions about a specific website. | `intext:"review" "example.com"` |

---

## 3. Usage Examples

Here are some combined queries to illustrate the use of these techniques:

```bash
# Find customer reviews and potential complaints about a company
intext:"complaint" inurl:"reviews" "Acme Corp"

# Search Trustpilot for mentions of fraud related to a company
site:trustpilot.com "fraud" "Acme Corp"

# Look for product reviews on Amazon
site:amazon.com intext:"customer review" "SuperWidget"

# Find WHOIS information about a company's website
site:whois.domaintools.com "Acme Corp"
```

---

## 4. Search Operators

- **Exact Phrase**  
  Use quotes to search for an exact phrase.  
  ```bash
  "Customer Reviews"
  ```

- **OR**  
  Use the `|` symbol to search for alternatives.  
  ```bash
  site:amazon.com | site:bestbuy.com
  ```

- **AND**  
  Combine multiple terms with `&` or simply by separating them with spaces.  
  ```bash
  intext:"scam" "Acme Corp"
  ```

- **Exclusion**  
  Use `-` to exclude terms or sites.  
  ```bash
  site:amazon.com -site:amazon.co.uk
  ```

- **Synonyms**  
  Prefix a word with `~` to include its synonyms.  
  ```bash
  ~review
  ```

- **Wildcard (Glob)**  
  Use `*` as a placeholder for an unknown term.  
  ```bash
  site:*.com
  ```


## Example Script: sherlock.py

The `sherlock.py` script is provided as an example to demonstrate how to use the information contained in the Google Dork Cheatsheet described above. This script shows how to automatically build and execute Google search queries (dorks) to retrieve publicly available information based on a person's or company's name.

### Functionality

- **User Input:**  
  The script prompts the user to enter a first name and a last name.

- **Query Generation:**  
  Using the provided name, it constructs a series of Google search queries—for example, searching for the terms in the page text (`intext:"..."`) and in the page title (`intitle:"..."`).

- **Results Display:**  
  The script displays the top results for each query directly in the console. In case an error occurs (e.g., too many requests triggering an error 429), a concise error message is shown and the search for that specific query is aborted.

### How to Run the Script

#### Prerequisites

- **Python 3** must be installed.
- Required Python module: `googlesearch-python`  
  Install it using:
  ```bash
  pip install googlesearch-python
  ```

#### Execution

Run the script directly from the command line:

```bash
python sherlock.py <FirstName> <LastName>
```

For example:

```bash
python sherlock.py John Doe
```

#### Running with Batch (Windows)

Create a batch file (e.g., `run_sherlock.bat`) with the following content:
```batch
@echo off
python C:\path\to\sherlock.py John Doe
pause
```
Replace `C:\path\to\sherlock.py` with the actual path to your script.

#### Running with Bash (Linux/macOS)

Create a shell script (e.g., `run_sherlock.sh`) with the following content:
```bash
#!/bin/bash
python3 /path/to/sherlock.py John Doe
```
Replace `/path/to/sherlock.py` with the actual path to your script. Then make the script executable:
```bash
chmod +x run_sherlock.sh
```

### Disclaimer

This example script is provided for educational and legitimate investigative purposes only. It is intended to demonstrate how to use the Google Dorks presented in the cheatsheet to search for publicly available information. Use this script responsibly and in accordance with applicable laws.

---
