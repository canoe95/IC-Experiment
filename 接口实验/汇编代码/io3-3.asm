data segment
ioa equ 288h
iob equ 289h
ioc equ 28ah
iok equ 28bh
t1 db 1,2,4,8,16,32,64,128
data ends
code segment
assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    mov dx,iok
    mov al,0afh
    out dx,al
    mov al,4
    out dx,al
    readb:
    mov dx,ioc
    in al,dx
    test al,00000010b
    jz readb
    mov dx,iob
    in al,dx
    and al,00000111b
    mov bx,offset t1
    xlat
    mov dx,ioa
    out dx,al
    mov ah,1
    int 16h
    jz readb
    mov ah,4ch
    int 21h
code ends
end start










