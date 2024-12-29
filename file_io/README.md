# Assembly File I/O Example

## Overview
This program demonstrates basic file I/O operations in assembly using Linux system calls. It performs the following steps:
1. Creates (or opens) a file named `output.txt`.
2. Writes a predefined message to the file.
3. Reads the file's contents back into memory.
4. Displays the contents of the file on the terminal.
5. Outputs a success message indicating the operation completed successfully.

## Features
- **File Creation and Permissions**: The file is created with read/write permissions for the owner and read-only permissions for others (`rw-r--r--`).
- **Write to File**: A message is written to the file.
- **Read from File**: The file's contents are read into a buffer.
- **Display Output**: The file's contents and a success message are displayed on the terminal.

---

## How It Works

### Sections in the Code

### `.data`
- Contains static data like strings for the file name, messages, and the newline character.
  - `filename`: Name of the file to be created or opened (`output.txt`).
  - `message`: Message to be written to the file.
  - `success_msg`: Message displayed after file I/O operations succeed.
  - `newline`: A newline character for formatting.

### `.bss`
- Allocates a buffer (`buffer`) for reading file content.

### `.text`
- The program's logic:
  - **File Creation**:
    - The `open` system call creates the file if it doesn't exist or opens it for writing.
  - **Write Operation**:
    - The `write` system call writes the predefined message to the file.
  - **Close Operation**:
    - The `close` system call closes the file descriptor to free system resources.
  - **Read Operation**:
    - The `read` system call reads the file's contents into the `buffer`.
  - **Display Output**:
    - The `write` system call outputs the file's content and a success message to the terminal.

---

## System Calls Used
| **Syscall** | **rax Value** | **Description**                    |
|-------------|---------------|------------------------------------|
| `open`      | `2`           | Opens a file for reading or writing. |
| `write`     | `1`           | Writes data to a file or stdout.    |
| `read`      | `0`           | Reads data from a file.            |
| `close`     | `3`           | Closes an open file descriptor.    |
| `exit`      | `60`          | Exits the program gracefully.      |

---

## Assembly Instructions
### File Flags and Permissions
- **File Flags**:
  - `0x41` (O_CREAT | O_WRONLY): Create the file if it doesn’t exist and open it for writing.
  - `0` (O_RDONLY): Open the file for reading only.
- **Permissions**:
  - `0o644`: Owner has read/write permissions; others have read-only access.

---

## Running the Program

### Prerequisites
1. Install the **NASM assembler** and **ld linker** on your Linux system.
2. Ensure the program is saved as `file_io.asm`.

### Steps
1. Assemble the program:
   ```bash
   nasm -f elf64 file_io.asm -o file_io.o
