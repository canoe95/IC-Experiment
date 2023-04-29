data segment
in0 equ 298h
data ends
code segment
assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    s1:
    mov dx,in0
    out dx,al
    mov cx,0ffh
    s:loop s
    mov dx,in0
    in al,dx
    mov bl,al
    mov cl,4
    shr bl,cl
    call disp
    and al,0fh
    mov bl,al
    call disp
    mov dl,20h
    mov ah,2
    int 21h
    mov ah,1
    int 16h
    jz s1
    mov ah,4ch
    int 21h
    
disp proc
    push bx
    push ax
    push dx
    mov dl,bl
    cmp dl,9
    jbe t
    add dl,7
    t:add dl,30h
    mov ah,2
    int 21h
    pop dx
    pop ax
    pop bx
    ret
disp endp
    
code ends
end start







