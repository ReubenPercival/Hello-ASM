;
; Hello World in x86-64 Linux Assembly (NASM)
;
; Syscall convention for Linux x86-64:
;   rax = syscall number
;   rdi = 1st arg
;   rsi = 2nd arg
;   rdx = 3rd arg
;   then invoke 'syscall'
;

section .data
    ; .data section: stores initialized data
    hello db 'Hello, World!', 0xa
    ; db = "define bytes" — writes literal bytes into memory
    ; 0xa is the newline character (\n)
    len equ $ - hello
    ; equ = "equate" — assigns a constant value
    ; $ = current address, so $ - hello = byte length of the string

section .text
    ; .text section: stores executable code
    global _start
    ; Export _start so the linker knows where execution begins

_start:
    ; syscall: write(1, hello, len)
    mov rax, 1      ; syscall number 1 = sys_write
    mov rdi, 1      ; 1st arg: fd = stdout
    mov rsi, hello  ; 2nd arg: buffer = address of our string
    mov rdx, len    ; 3rd arg: count = string length
    syscall         ; hand control to the kernel

    ; syscall: exit(0)
    mov rax, 60     ; syscall number 60 = sys_exit
    xor rdi, rdi    ; 1st arg: exit code = 0 (xor reg,reg is a fast zero)
    syscall         ; hand control to the kernel
