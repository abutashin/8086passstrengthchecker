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

    ;code here
    LEA dx,string1 ; Enter Password:
    mov ah,9
    int 21h

    LEA SI, name1 ;initialising name1 array for storing password
    MOV AH,1
    MOV CX,9

;input segment
input_loop: 
    INT 21H
    MOV [SI],AL   ;
    INC SI
    LOOP input_loop ;this loop will take input of a password of length 9 characters
    MOV AH, 2
    MOV DL, 0AH ;Output carriage
    INT 21H
    MOV DL, 0DH ;output return
    INT 21H

 
MOV AH,0 ;storing default values
MOV AL,0
MOV BH,0
MOV BL,0
MOV CX,9
MOV SI,0

;algorithm segment
output_loop:

    MOV DL, name1[SI]
    CMP DL, 61h
    Jl cap ;possible caps 
    CMP DL, 7Ah
    JG spe ;special character confirmed
    mov ah,1 ;small letter confirmed
    JMP Exit
    cap:
      CMP DL, 41h
      JL  num ;either number or special character
      CMP DL, 5Ah
      JG spe ;special character confirmed
      mov al,1 ;Caps letter confirmed
      JMP EXIT
    num:
      CMP DL, 30h
      JL spe ;special character confirmed
      CMP DL, 39h
      JG spe ;special character confirmed
      mov bh,1 ;number confirmed
      JMP EXIT
    spe:
      mov bl,1 ;special character

    Exit:
      INC SI
      LOOP output_loop ;loop until 9 characters are filled. else, exit loop
      
      
      
      
      
      
;output segment

ADD BL,AH
ADD BL,AL
ADD BL,BH
CMP BL,3 ;check if we have caps, small, num, and special characters
JL weak ;weak password
JG strong ;strong password


LEA DX,string3
    MOV AH,9
    INT 21H
    JMP print
    weak:
       LEA DX,string2
       MOV AH,9
       INT 21H
       JMP print
    strong:
       LEA DX,string4
       MOV AH,9
       INT 21H
       JMP print

    print:


    MAIN ENDP
END MAIN
