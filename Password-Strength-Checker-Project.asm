.MODEL SMALL
.STACK 100H
.DATA
string1 db "Enter Password: $"
string2 db "Weak Password$"
string3 db "Moderate Password$"
string4 db "Strong Password$"
name1 DB 9 DUP(?)
.CODE
    MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    ;Prompting A Password
    LEA dx,string1
    mov ah,9
    int 21h
   
    LEA SI, name1
MOV AH,1
MOV CX,9

input_loop:
   INT 21H
   MOV [SI],AL
   INC SI
LOOP input_loop
MOV AH, 2
MOV DL, 0AH
INT 21H
MOV DL, 0DH
INT 21H

 
MOV AH,0
MOV AL,0
MOV BH,0
MOV BL,0
MOV CX,9
MOV SI,0

;here we will check conditions like caps, symbols, small letters, numbers


    MAIN ENDP
END MAIN



