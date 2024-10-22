ORG 100h
; Prompt for the first single-digit number
mov dx, offset msg_input1
mov ah, 09h
int 21h
; Get first digit
mov ah, 01h
int 21h
mov bl, al ; Store first digit in BL
cmp al, '0' ; Check if it's a valid digit
jl NotDigit
cmp al, '9'
jg NotDigit
; Display the first digit
mov dx, offset msg_output1
mov ah, 09h
int 21h
mov dl, bl
mov ah, 02h
int 21h
; Prompt for the second single-digit number
mov dx, offset msg_input2
mov ah, 09h
int 21h
; Get second digit
mov ah, 01h
int 21h
mov cl, al ; Store second digit in CL
cmp al, '0' ; Check if it's a valid digit
jl NotDigit
cmp al, '9'
jg NotDigit
; Display the second digit
mov dx, offset msg_output2
mov ah, 09h
int 21h
mov dl, cl
mov ah, 02h
int 21h
; Perform addition of the two digits
mov dx, offset msg_add
mov ah, 09h
int 21h
sub bl, '0' ; Convert first digit from ASCII to numeric value
sub cl, '0' ; Convert second digit from ASCII to numeric value
add bl, cl ; Add the two digits
; Check if the result is a two-digit number (>= 10)
cmp bl, 10
jl SingleDigit ; If less than 10, it's a single-digit result
; Handle two-digit result
mov dl, 1 ; Tens place is 1 for numbers between 10-18
add dl, '0' ; Convert tens place to ASCII
mov ah, 02h
int 21h
sub bl, 10 ; Adjust result for ones place (subtract 10)
add bl, '0' ; Convert ones place to ASCII
mov dl, bl
mov ah, 02h
int 21h
jmp endprogram
SingleDigit:
; Handle single-digit result
add bl, '0' ; Convert the result to ASCII
mov dl, bl
mov ah, 02h
int 21h
jmp endprogram
; Handle invalid input
NotDigit:
mov dx, offset msg_error
mov ah, 09h
int 21h
; End the program
endprogram:
mov ah, 4Ch
int 21h
; Data section
msg_input1 DB "Enter first digit: $"
msg_output1 DB 0Dh, 0Ah, "The first digit is: $"
msg_input2 DB 0Dh, 0Ah, "Enter second digit: $"
msg_output2 DB 0Dh, 0Ah, "The second digit is: $"
msg_add DB 0Dh, 0Ah, "The addition of the two digits is: $"
msg_error DB 0Dh, 0Ah, "Error: Not a digit!$"