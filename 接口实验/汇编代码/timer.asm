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
    mov al,14h
    out dx,al
    mov dx,io0
    mov al,9
    out dx,al
    r1:mov dx,io0
    in al,dx
    call dis
    mov ah,1
    int 16h
    jz r1
    mov ah,4ch
    int 21h
dis proc
    push ax
    push dx
    add al,30h
    mov dl,al
    mov ah,2
    int 21h
    pop dx
    pop ax
    ret
dis endp
here:jmp here
code ends
end start    
