
```
███╗   ██╗██╗   ██╗███╗   ███╗██████╗ ███████╗██████╗ ███████╗    ██╗███╗   ██╗██╗   ██╗███████╗██████╗ ████████╗███████╗██████╗ 
████╗  ██║██║   ██║████╗ ████║██╔══██╗██╔════╝██╔══██╗██╔════╝    ██║████╗  ██║██║   ██║██╔════╝██╔══██╗╚══██╔══╝██╔════╝██╔══██╗
██╔██╗ ██║██║   ██║██╔████╔██║██████╔╝█████╗  ██████╔╝███████╗    ██║██╔██╗ ██║██║   ██║█████╗  ██████╔╝   ██║   █████╗  ██████╔╝
██║╚██╗██║██║   ██║██║╚██╔╝██║██╔══██╗██╔══╝  ██╔══██╗╚════██║    ██║██║╚██╗██║╚██╗ ██╔╝██╔══╝  ██╔══██╗   ██║   ██╔══╝  ██╔══██╗
██║ ╚████║╚██████╔╝██║ ╚═╝ ██║██████╔╝███████╗██║  ██║███████║    ██║██║ ╚████║ ╚████╔╝ ███████╗██║  ██║   ██║   ███████╗██║  ██║
╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚══════╝    ╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝
```
[![Python](https://img.shields.io/badge/Python-3.10.13-blue.svg)](https://www.python.org/downloads/release/python-31013/)
![Batch Script](https://img.shields.io/badge/script-batch-DDFF00)
![Bash Script](https://img.shields.io/badge/script-bash-green)
![STABLE](https://img.shields.io/badge/VERSION-1.0.0-green)
![WINDOWS](https://img.shields.io/badge/WINDOWS-blue)
![LINUX](https://img.shields.io/badge/Linux-orange)

# 🔄 File Renamer Utility

A simple script that renames files by reversing their numerical order while maintaining their original name format.

---
---
---

## 📋 Table of Contents

- [🔄 File Renamer Utility](#-file-renamer-utility)
  - [📋 Table of Contents](#-table-of-contents)
  - [🌟 Features](#-features)
  - [🔍 Prerequisites](#-prerequisites)
  - [🛠️ TODO](#️-todo)
  - [📌 Usage](#-usage)
    - [Windows (Batch)](#windows-batch)
    - [Linux (Bash)](#linux-bash)
  - [📜 License](#-license)
  - [❓ Support \& Questions](#-support--questions)
  - [💎 Recommendations](#-recommendations)

## 🌟 Features

- Automatically detects numerical prefixes in file names.
- Renumbers files in reverse order while keeping the original name structure.
- Works on both Windows (Batch) and Linux (Bash).
- Prevents overwriting by using a temporary renaming process.

## 🔍 Prerequisites

Before you begin, ensure you have the following installed:

- Python 3.10 or newer
- Windows Command Prompt (for batch script) or Linux Terminal (for bash script)

## 🛠️ TODO

1. Improve logging for better debugging.
2. Add support for additional file formats.
3. Implement an option to preview renaming before execution.

## 📌 Usage

### Windows (Batch)

1. Run `rename_script.bat`
2. Enter the directory path when prompted.

### Linux (Bash)

1. Run `./rename_script.sh`
2. Enter the directory path when prompted.

Alternatively, pass the directory as an argument:

```bash
./rename_script.sh /path/to/files
```

## 📜 License

This repository is released under the [MIT License](LICENSE). Please see the `LICENSE` file for more information.

## ❓ Support & Questions

If you have any questions or need support, please feel free to open an issue or start a discussion.

## 💎 Recommendations  

Looking for more useful scripts? Check out:

- [Tiny Scripts](https://github.com/SECRET-GUEST/tiny-scripts): A collection of lightweight utilities.
- [File Organizer](https://github.com/SECRET-GUEST/file_organizer): A tool to sort and organize files efficiently.

---


```
     _ ._  _ , _ ._            _ ._  _ , _ ._    _ ._  _ , _ ._      _ ._  _ , _ .__  _ , _ ._   ._  _ , _ ._   _ , _ ._   .---.  _ ._   _ , _ .__  _ , _ ._   ._  _ , _ ._      _ ._  _ , _ .__  _ , _ . .---<__. \ _
   (_ ' ( `  )_  .__)        (_ ' ( `  )_  .__ (_ ' ( `  )_  .__)  (_ '    ___   ._( `  )_  .__)  ( `  )_  .__)   )_  .__)/     \(_ ' (    )_  ._( `  )_  .__)  ( `  )_  .__)  (_ ' ( `  )_  ._( `` )_  . `---._  \ \ \
 ( (  (    )   `)  ) _)    ( (  (    )   `)  ) (  (    )   `)  ) _ (  (   (o o) )     )   `)  ) _    )   `)  ) _    `)  ) \.@-@./(  (    )   `)     )   `)  ) _    )   `)  ) _ (  (    )   `)         `) ` ),----`- `.))  
(__ (_   (_ . _) _) ,__)  (__ (_   (_ . _) _) _ (_   (_ . _) _) ,__ (_   (  V  ) _) (_ . _) _) ,_  (_ . _) _) ,_ . _) _) ,/`\_/`\ (_   (  . _) _) (_ . _) _) ,_  (_ . _) _) ,__ (_   (_ . _) _) (__. _) _)/ ,--.   )  |
    `~~`\ ' . /`~~`           `~~`\ ' . /`~~`   `~~`\ ' . /`~~`     `~~`/--m-m- ~~`\ ' . /`~~`   `\ ' . /`~~`  `\ ' . /  //  _  \\ ``\ '  . /`~~`\ ' . /`~~`   `\ ' . /`~~`     `~~`\ ' . /`~~`\ ' . /`~~/_/    >     |
         ;   ;                     ;   ;             ;   ;               ;   ;      ;   ;          ;   ;         ;   ;  | \     )|_   ;    ;      ;   ;          ;   ;               ;   ;      ;   ;    |,\__-'      |
         /   \                     /   \             /   \               /   \      /   \          /   \         /   \ /`\_`>  <_/ \  /    \      /   \          /   \               /   \      /   \     \__         \
________/_ __ \___________________/_ __ \___________/_ __ \______ __ ___/_ __ \____/_ __ \________/_ __ \_______/_ __ \\__/'---'\__/_/_  __ \____/_ __ \________/_ __ \_____ _______/_ __ \____/_ __ \____ __\___      )
```
