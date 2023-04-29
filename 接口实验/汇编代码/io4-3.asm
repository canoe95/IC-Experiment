DATA SEGMENT
in0 equ 298h
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
    MOV AX,CS
    MOV DS,AX
    MOV DX,OFFSET INT3
    MOV AX,250BH
    INT 21H
    IN AL,21H
    AND AL,0F7H
    OUT 21H,AL
    MOV dx,in0
    out dx,al
    
LL: JMP LL
INT3: 
    MOV AX,DATA
    MOV DS,AX
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
    mov dx,in0
    out dx,al
        MOV AL,20H
        OUT 20H,AL
        IRET
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

CODE ENDS
END START
