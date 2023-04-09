data segment
    info db 'NEUQ 2023!if Winter comes,can Spring be far behind?', 0ah, 0ah, '$'
data ends
code segment
assume cs:code, ds:data
start:
    mov ax,cs
    mov ds,ax
    mov dx,offset int3
    mov ah,25h
    mov al,0bh
    int 21h
    in al,21h
    and al,0f7h
    out 21h,al
here:jmp here
int3 proc
    push ax
    push ds
    push dx
    sti
    mov ax,data
    mov ds,ax
    mov dx,offset info
    mov ah,9
    int 21h
    mov al,20h
    out 20h,al
    cli
    pop dx
    pop ds
    pop ax
    iret
int3 endp
code ends
end start