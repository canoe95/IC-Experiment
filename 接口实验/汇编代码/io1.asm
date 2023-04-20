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
    mov dx,offset int3
    mov ax,250bh
    int 21h
    in al,21h
    and al,0f7h
    out 21h,al
    mov dx,iok
    mov al,0b0h
    out dx,al
    mov al,9
    out dx,al
ll: jmp ll
int3:   push ax
        push dx
        push ds
        mov ax,data
        mov ds,ax
        mov dx,ioa
        in al,dx
        mov dl,al
        mov ah,2
        int 21h
        mov al,20h
        out 20h,al
        pop ds
        pop dx
        pop ax
        
        iret
code ends
end start

















