data segment
io0 equ 280h
io1 equ 281h
io2 equ 282h
iok equ 283h
data ends
code segment
assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    mov dx,iok
    mov al,36h
    out dx,al
    mov dx,io0
    mov ax,1000
    out dx,al
    mov al,ah
    out dx,al
    mov dx,iok
    mov al,76h
    out dx,al
    mov dx,io1
    mov ax,1000
    out dx,al
    mov al,ah
    out dx,al
here:jmp here
code ends
end start    
