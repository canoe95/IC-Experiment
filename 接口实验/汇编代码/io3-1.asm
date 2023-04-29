data segment
ioa equ 288h
iob equ 289h
ioc equ 28ah
iok equ 28bh
data ends
code segment
assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    mov dx,iok
    mov al,89h
    out dx,al
    s:
    mov dx,ioc
    in al,dx
    mov dx,ioa
    out dx,al
    mov ah,1
    int 16h
    jz s
    mov ah,4ch
    int 21h
code ends
end start