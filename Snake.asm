[org 0x0100]

; Constants for directions
; right = 1
; left  = 254
; up    = 2 
; down  = 253

jmp start

; Snake properties
snakeLen: dw 0 ; Length of the snake

; Head properties
headRow: db 0 ; Row position of the head
headCol: db 0 ; Column position of the head
headDir: db 0 ; Direction of the head

headRowIncr: db 0  ; Row increment for the head
headColIncr: db 0  ; Column increment for the head

; Tail properties
tailRow: db 0 ; Row position of the tail
tailCol: db 0 ; Column position of the tail
tailDir: db 0 ; Direction of the tail

tailRowIncr: db 0  ; Row increment for the tail
tailColIncr: db 0  ; Column increment for the tail

; Arrays for snake movement
distanceArray: resw 200  ; Array to store distances
directionArray: resb 200 ; Array to store directions

distancePtr: dw 0  ; Pointer for distance array
directionPtr: dw 0 ; Pointer for direction array

setDistancePtr: dw 0
setDirectionPtr: dw 0

undefinedVar: dw 0
undefinedFlag: db 0

headUpSprite: dw 0
headDownSprite: dw 0
headRightSprite: dw 0
headLeftSprite: dw 0
bodySprite: dw 0

tailSprite: dw 0

;---------------------------------------------------------------------------------------------------------------------------

bgSprite: dw 0x0fdb
tickCount: db 0

oldTimeIsr: dw 0, 0
oldKeybIsr:dw 0, 0

tempWord: dw 0

directionInput: db 0
headDirOpposite: db 0

;---------------------------------------------------------------------------------------------------------------------------

seed: dw 0
growFlag: db 0
spawnRow: db 0
spawnCol: db 0
fruitSprite: dw 0

;---------------------------------------------------------------------------------------------------------------------------

stringGrowth: db 'GROWTH: 0', 0
stringPortal: db '1. Portal Mode', 0
stringWall: db '2. Wall Mode  ', 0
stringControls: db 'Controls: IJKL', 0
stringEscape: db 'Exit: Esc in-game', 0
snakePlaceHolder: db 0x04, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x3E, 0
collisionFlag: db 0
wallMode: db 0

;---------------------------------------------------------------------------------------------------------------------------

rowCoordsW: db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 14, 14, 14, 14, 14, 14, 14, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 23 
colCoordsW: db 0, 1, 2, 3, 4, 71, 72, 73, 74, 75, 76, 77, 78, 79, 0, 1, 2, 3, 4, 5, 32, 38, 46, 71, 72, 73, 74, 75, 76, 77, 79, 1, 2, 3, 4, 5, 32, 38, 42, 45, 49, 72, 73, 74, 75, 78, 79, 1, 2, 3, 4, 5, 33, 38, 42, 45, 49, 51, 72, 73, 74, 77, 78, 79, 3, 4, 5, 33, 38, 41, 45, 49, 51, 75, 76, 77, 78, 79, 0, 1, 2, 33, 35, 36, 37, 38, 41, 45, 46, 47, 50, 74, 75, 76, 77, 78, 79, 0, 1, 2, 3, 4, 5, 33, 35, 41, 43, 47, 48, 50, 74, 75, 76, 77, 78, 79, 0, 1, 2, 3, 4, 5, 33, 34, 35, 41, 42, 43, 45, 48, 50, 75, 76, 77, 78, 79, 0, 1, 2, 3, 4, 5, 35, 36, 37, 38, 39, 43, 44, 45, 48, 49, 50, 76, 77, 78, 79, 0, 1, 2, 3, 4, 31, 36, 39, 43, 48, 77, 78, 79, 0, 1, 2, 3, 4, 31, 36, 39, 43, 44, 45, 48, 51, 78, 79, 0, 1, 2, 3, 4, 31, 32, 33, 34, 36, 37, 38, 39, 45, 48, 51, 0, 1, 2, 3, 34, 39, 42, 45, 48, 50, 0, 1, 2, 3, 15, 16, 17, 18, 19, 20, 35, 36, 37, 39, 40, 41, 42, 45, 46, 47, 48, 50, 1, 2, 3, 15, 37, 42, 45, 50, 53, 1, 2, 3, 15, 37, 38, 39, 40, 42, 45, 47, 48, 49, 53, 2, 3, 15, 22, 23, 24, 25, 26, 29, 30, 31, 32, 33, 40, 41, 42, 45, 46, 47, 53, 57, 0, 1, 15, 16, 17, 18, 19, 20, 22, 26, 33, 42, 43, 44, 45, 53, 57, 60, 61, 62, 63, 64, 0, 1, 2, 20, 22, 26, 29, 30, 31, 32, 33, 42, 53, 54, 55, 56, 57, 60, 64, 0, 1, 20, 22, 26, 29, 33, 42, 46, 53, 55, 60, 61, 62, 63, 64, 0, 1, 20, 22, 26, 29, 33, 42, 53, 55, 56, 57, 60, 0, 15, 16, 17, 18, 19, 20, 22, 26, 29, 30, 31, 32, 33, 42, 53, 56, 57, 60, 61, 62, 63, 64, 15, 16, 17, 18, 19, 20, 22, 26, 29, 30, 31, 32, 33, 42, 53, 56, 57, 60, 61, 62, 63, 64, 42 
whiteSize: dw 393
whiteSprite: dw 0x0f0C ;0x0fdb 0c

rowCoordsG: db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 24, 24, 24, 24, 24, 24
colCoordsG: db 5, 6, 7, 8, 9, 10, 62, 63, 64, 65, 66, 67, 68, 69, 70, 6, 7, 8, 9, 10, 62, 63, 64, 65, 66, 67, 68, 69, 70, 6, 7, 8, 9, 10, 33, 39, 63, 64, 65, 66, 67, 68, 69, 70, 71, 6, 7, 8, 9, 10, 39, 44, 48, 63, 64, 65, 66, 67, 68, 69, 70, 71, 6, 7, 8, 34, 39, 44, 48, 50, 64, 65, 66, 67, 68, 69, 70, 71, 72, 10, 34, 39, 42, 44, 49, 64, 65, 66, 67, 68, 69, 70, 6, 7, 8, 9, 10, 34, 36, 37, 38, 39, 42, 45, 46, 49, 65, 66, 67, 72, 73, 6, 7, 8, 9, 10, 36, 47, 49, 69, 70, 71, 72, 73, 74, 6, 7, 8, 9, 10, 34, 47, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 5, 6, 7, 8, 9, 10, 37, 38, 40, 44, 47, 49, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 5, 6, 7, 8, 9, 10, 32, 37, 40, 47, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 5, 6, 7, 8, 9, 40, 44, 47, 50, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 4, 5, 6, 7, 8, 9, 32, 33, 35, 37, 38, 40, 44, 47, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 4, 5, 6, 7, 8, 9, 44, 49, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 4, 5, 6, 7, 8, 16, 17, 18, 19, 20, 21, 36, 38, 40, 41, 44, 46, 47, 49, 71, 72, 73, 74, 75, 76, 77, 78, 79, 4, 5, 6, 7, 8, 16, 41, 44, 52, 72, 73, 74, 75, 76, 77, 78, 4, 5, 6, 7, 8, 16, 38, 39, 44, 48, 52, 73, 74, 75, 76, 77, 78, 23, 24, 25, 27, 30, 31, 32, 34, 41, 46, 52, 56, 74, 75, 76, 79, 3, 4, 5, 6, 7, 16, 17, 18, 19, 21, 23, 27, 34, 43, 44, 52, 59, 61, 62, 63, 78, 79, 2, 3, 4, 5, 6, 7, 19, 21, 23, 27, 30, 31, 32, 34, 52, 54, 56, 59, 76, 77, 78, 79, 2, 3, 4, 5, 6, 7, 19, 21, 23, 27, 32, 34, 52, 54, 59, 61, 62, 63, 77, 78, 79, 1, 2, 3, 4, 5, 6, 21, 23, 27, 34, 52, 54, 55, 59, 0, 1, 2, 3, 4, 5, 6, 21, 23, 27, 34, 52, 55, 59, 0, 1, 2, 3, 4, 5, 16, 17, 18, 19, 20, 21, 23, 27, 30, 31, 32, 33, 34, 52, 55, 56, 59, 60, 61, 62, 63, 0, 1, 2, 3, 4, 5
greySize: dw 450
greySprite: dw 0x073b ;0x7720 2a 1a 2c 2d [2f] 3b a9 ab ac [[b3]] [c4] [c5] [cd] [f0] [f1] [f4] f6 [f9] [fa]

blueSprite: dw 0x8BE0 ;0x0be0

;---------------------------------------------------------------------------------------------------------------------------

escFlag: db 0

;---------------------------------------------------------------------------------------------------------------------------

clrscr:             ;clears the screen vro
                    pusha
                    mov ax, 0xb800
                    mov es, ax
                    mov ax, 0x0720
                    mov di, 0
                    mov cx, 2000
                    clrscrLoop:     mov [es:di], ax
                                    add di, 2
                                    loop clrscrLoop
                    popa
                    ret
                    
;---------------------------------------------------------------------------------------------------------------------------

printWhite:         ;prints white 
                    pusha
                    push es
                    mov ax, 0xb800
                    mov es, ax
                    
                    mov cx, [whiteSize]
                    mov si, 0
                    printWLoop: ;prints white in a loop
                                mov ah, 0
                                mov al, [rowCoordsW + si]
                                push ax
                                mov al, [colCoordsW + si]
                                push ax
                                call calcCoords
                                mov ax, [whiteSprite]
                                mov [es:di], ax
                                add si, 1
                                loop printWLoop
                    pop es
                    popa
                    ret
;---------------------------------------------------------------------------------------------------------------------------              
                
printGrey:          ;prints grey
                    pusha
                    push es
                    mov ax, 0xb800
                    mov es, ax
                    
                    mov cx, [greySize]
                    mov si, 0
                    printGLoop:     ;prints grey in a loop
                                    mov ah, 0
                                    mov al, [rowCoordsG + si]
                                    push ax
                                    mov al, [colCoordsG + si]
                                    push ax
                                    call calcCoords
                                    mov ax, [greySprite]
                                    mov [es:di], ax
                                    add si, 1
                                    loop printGLoop
                    pop es
                    popa
                    ret
;---------------------------------------------------------------------------------------------------------------------------

printBlue:          ;prints the blue fruit 19, 46
                    pusha
                    push es
                    
                    mov ax, 0xb800
                    mov es, ax
                    mov ax, [blueSprite]
                    mov [es:3132], ax ;19, 46
                    mov ax, 0x0720
                    mov [es:3850], ax
                    mov ax, [greySprite]
                    mov [es:3516], ax
                    mov [es:3518], ax
                    mov [es:3678], ax
                    
                    pop es
                    popa
                    ret
;---------------------------------------------------------------------------------------------------------------------------

titleScr:           ;prints the title screen, exits on enter
                    push ax
                    call clrscr
                    call printWhite
                    call printGrey
                    call printBlue
                    titleScrLp:     ;loops until enter
                                    in al, 0x60
                                    cmp al, 0x39
                                    je exitTitle
                                    jmp titleScrLp
                    
                    exitTitle:          pop ax
                                        ret
                    
;---------------------------------------------------------------------------------------------------------------------------

selectMode:         ;1 for portals, 2 for walls
                    pusha
                    push es
                    
                    call clrscr
                    
                    mov ax, 0x0Fdb
                    mov cx, 80
                    mov di, 0
                    mov si, 3840
                    borderRowM:     mov [es:di], ax                        
                                    mov [es:si], ax
                                    add di, 2
                                    add si, 2
                                    loop borderRowM
                    
                    mov cx, 25
                    mov di, 0
                    mov si, 158
                    borderColM:     mov [es:di], ax
                                    mov [es:si], ax
                                    add di, 160
                                    add si, 160
                                    loop borderColM
                                
                    push 0
                    push 34
                    push stringGrowth
                    push 0x0070
                    call printStr
                    
                    push 1
                    push 1
                    push snakePlaceHolder
                    push 0x0070
                    call printStr
                    
                    mov ax, 11
                    mov bx, 33
                    mov cx, 0x000F
                    
                    push ax
                    push bx
                    push stringPortal
                    push cx
                    call printStr
                    
                    add ax, 1
                    push ax
                    push bx
                    push stringWall
                    push cx
                    call printStr
                    
                    add ax, 1
                    push ax ;11
                    push bx
                    push stringControls
                    push cx
                    call printStr
                    
                    add ax, 1
                    push ax ;11
                    push bx
                    push stringEscape
                    push cx
                    call printStr
                    
                    mov ax, 0xb800
                    mov es, ax
                    mov ax, [blueSprite]
                    mov [es:3132], ax ;19, 46
                    
                    selectMdLp:     ;loops until either 1 or 2 is pressed
                                    in al, 0x60
                                    cmp al, 0x82
                                    jz mode1
                                    cmp al, 0x83
                                    jz mode2
                                    jmp selectMdLp
                    
                    mode1:          mov byte [wallMode], 0
                                    jmp startGame
                                    
                    mode2:          mov byte [wallMode], 1
                                    
                    startGame:      popa
                                    pop es
                                    ret

;---------------------------------------------------------------------------------------------------------------------------

calcCoords:         ;row -> col -> ret -> [bp] -> registers (stores in di)
                    push bp
                    mov bp, sp
                    ;(80y + x)*2
                    push ax
                    
                    mov ax, 80
                    mov di, [bp + 6]
                    mul di
                    add ax, [bp + 4]
                    shl ax, 1
                    mov di, ax
                    
                    pop ax
                    pop bp
                    ret 4

;---------------------------------------------------------------------------------------------------------------------------

printNum:           ;row -> col -> num -> ret -> [bp] -> registers
                    push bp
                    mov bp, sp
                    push es
                    push ax
                    push bx
                    push cx
                    push dx
                    push di
                    
                    mov ax, 0xb800
                    mov es, ax
                    mov ax, [bp + 4]
                    mov bx, 10
                    mov cx, 0
                    
                    nextDigit:      mov dx, 0
                                    div bx
                                    add dl, 0x30
                                    push dx
                                    inc cx
                                    cmp ax, 0
                                    jnz nextDigit
                                    
                    push word [bp + 8]
                    push word [bp + 6]
                    call calcCoords
                    
                    nextPos:        pop dx
                                    mov dh, 0x0F
                                    mov [es:di], dx
                                    add di, 2
                                    loop nextPos
                                    
                    pop di
                    pop dx                    
                    pop cx
                    pop bx
                    pop ax
                    pop es
                    pop bp
                    ret 6

;---------------------------------------------------------------------------------------------------------------------------

printLen:           ;prints the score or something
                    push ax
                    
                    push 0
                    push 42
                    mov ax, [snakeLen]
                    sub ax, 10
                    push ax
                    
                    call printNum
                    
                    pop ax
                    
                    ret 
                    
;---------------------------------------------------------------------------------------------------------------------------

printStr:           ;row -> col -> str -> attribute byte -> ret -> [bp] -> registers
                    push bp
                    mov bp, sp
                    push ax
                    push bx
                    push di
                    push si
                    push es
                    
                    mov ax, 0xB800
                    mov es, ax
                    
                    mov bx, [bp + 6]
                    mov ax, [bp + 4]
                    mov ah, al
                    mov si, 0
                    push word [bp + 10]
                    push word [bp + 8]
                    call calcCoords
                    
                    prntLoop:       ;prints the string 
                                    mov al, [bx + si]
                                    cmp al, 0
                                    jz exitPrnt
                                    mov [es:di], ax
                                    add si, 1
                                    add di, 2
                                    jmp prntLoop
                                    
                    exitPrnt:       pop es
                                    pop si
                                    pop di
                                    pop bx
                                    pop ax
                                    pop bp
                                    ret 8
                    

;---------------------------------------------------------------------------------------------------------------------------

background:         ;clears the screen vro
                    pusha
                    mov ax, 0xb800
                    mov es, ax
                    mov ax, 0x0fdb
                    mov di, 0
                    mov cx, 2000
                    clearLoop:      mov [es:di], ax
                                    add di, 2
                                    loop clearLoop
                                
                    mov ax, 0x00db
                    mov cx, 80
                    mov di, 0
                    mov si, 3840
                    borderRow:      mov [es:di], ax                        
                                    mov [es:si], ax
                                    add di, 2
                                    add si, 2
                                    loop borderRow
                    
                    mov cx, 25
                    mov di, 0
                    mov si, 158
                    borderCol:      mov [es:di], ax
                                    mov [es:si], ax
                                    add di, 160
                                    add si, 160
                                    loop borderCol
                                
                    push 0
                    push 34
                    push stringGrowth
                    push 0x000F
                    call printStr
                    
                    popa
                    ret

;---------------------------------------------------------------------------------------------------------------------------

initVars:           ;initializes all snake variables and draws the snake on its initial position
                    pusha
                    push es
                    
                    mov word [snakeLen], 10
                    
                    mov byte [headRow], 1
                    mov byte [headCol], 10
                    mov byte [headDir], 1
                    
                    mov byte [headRowIncr], 0
                    mov byte [headColIncr], 1
                    
                    mov byte [tailRow], 1
                    mov byte [tailCol], 1
                    mov byte [tailDir], 1
                    
                    mov byte [tailRowIncr], 0
                    mov byte [tailColIncr], 1
                    
                    mov cx, 200
                    mov di, 0
                    mov si, 0
                    
                    fillArrays:     ;fills distance array with -1
                                    mov word [distanceArray + di], -1
                                    mov byte [directionArray + si], -1
                                    add di, 2
                                    add si, 1
                                    loop fillArrays
                                    
                    mov word [distancePtr], 0
                    mov word [directionPtr], 0
                    
                    mov word [setDistancePtr], 0
                    mov word [setDirectionPtr], 0
                    
                    mov word [undefinedVar], 0
                    mov byte [undefinedFlag], 0
                    
                    mov word [headUpSprite], 0x0F41            ;0x7041
                    mov word [headDownSprite], 0x0f56          ;0x7056
                    mov word [headRightSprite], 0x0f3E         ;0x703E
                    mov word [headLeftSprite], 0X0f3C          ;0x703C
                    mov word [bodySprite], 0x0f0C              ;0x700C
                    
                    mov word [tailSprite], 0x0f04              ;0x7004
                    
                    mov word [seed], 0
                    mov byte [growFlag], 0
                    mov byte [spawnRow], 0
                    mov byte [spawnCol], 0
                    mov word [fruitSprite], 0x0BE0                ;0x7C03
                    
                    mov cx, 1
                    mov ax, 0xB800
                    mov es, ax
                    drawSnake:      ;draws snake on its initial position
                                    mov ax, [bodySprite]
                                    push 1     ;push row
                                    push cx    ;push column
                                    call calcCoords    ;stores answer in di
                                    mov [es:di], ax
                                    add cx, 1
                                    cmp cx, 10
                                    jnz drawSnake
                                    
                    mov ax, [headRightSprite]
                    push 1
                    push cx
                    call calcCoords
                    mov [es:di], ax
                    
                    mov al, [headDir]
                    mov [directionInput], al
                    mov [headDirOpposite], al
                    xor byte [headDirOpposite], 0xFF
                    
                    push 19
                    push 46
                    call calcCoords
                    mov ax, [fruitSprite]
                    mov [es:di], ax
                    
                    mov byte [collisionFlag], 0
                    mov byte [escFlag], 0
                    
                    pop es
                    popa
                    ret

;---------------------------------------------------------------------------------------------------------------------------

wrapSnakeH:         ;wraps snake around video memory
                    push ax
                    mov al, [wallMode]
                    rowUpLimH:      cmp byte [headRow], 23
                                    jbe rowLowLimH
                                    mov byte [headRow], 1
                                    add [collisionFlag], al
                                    jmp noHeadWrap
                                    
                    rowLowLimH:     cmp byte [headRow], 1
                                    jge colUpLimH
                                    mov byte [headRow], 23
                                    add [collisionFlag], al
                                    jmp noHeadWrap
                    
                    colUpLimH:          cmp byte [headCol], 78
                                    jbe colLowLimH
                                    mov byte [headCol], 1
                                    add [collisionFlag], al
                                    jmp noHeadWrap
                    
                    colLowLimH:     cmp byte [headCol], 1
                                    jge noHeadWrap
                                    mov byte [headCol], 78
                                    add [collisionFlag], al
                                    jmp noHeadWrap
                                    
                    noHeadWrap:     pop ax
                                    ret                    

;---------------------------------------------------------------------------------------------------------------------------                                        
                    
wrapSnakeT:         ;wraps snake around video memory
                    
                    rowUpLimT:      cmp byte [tailRow], 23
                                    jbe rowLowLimT
                                    mov byte [tailRow], 1
                                    jmp noTailWrap
                                    
                    rowLowLimT:     cmp byte [tailRow], 1
                                    jge colUpLimT
                                    mov byte [tailRow], 23
                                    jmp noTailWrap
                    
                    colUpLimT:          cmp byte [tailCol], 78
                                    jbe colLowLimT
                                    mov byte [tailCol], 1
                                    jmp noTailWrap
                    
                    colLowLimT:     cmp byte [tailCol], 1
                                    jge noTailWrap
                                    mov byte [tailCol], 78
                                    jmp noTailWrap
                                    
                    
                    noTailWrap:     ret                    

;---------------------------------------------------------------------------------------------------------------------------

steerTail:          ;updates tail increments based on tailDir
                    tCheckDown:     ;253
                                    cmp byte [tailDir], 253
                                    jne tCheckUp
                                    mov byte [tailRowIncr], 1
                                    mov byte [tailColIncr], 0
                                    jmp steerTlFin
                    
                    tCheckUp:       ;2
                                    cmp byte [tailDir], 2
                                    jne tCheckLeft
                                    mov byte [tailRowIncr], -1
                                    mov byte [tailColIncr], 0
                                    jmp steerTlFin
                    
                    tCheckLeft:     ;254
                                    cmp byte [tailDir], 254
                                    jne tCheckRight
                                    mov byte [tailRowIncr], 0
                                    mov byte [tailColIncr], -1
                                    jmp steerTlFin
                    
                    tCheckRight:    ;1
                                    cmp byte [tailDir], 1
                                    jne steerTlFin
                                    mov byte [tailRowIncr], 0
                                    mov byte [tailColIncr], 1
                                    
                    steerTlFin:     ret
;---------------------------------------------------------------------------------------------------------------------------

steerHead:          ;updates tail increments based on tailDir
                    hCheckDown:     ;253
                                    cmp byte [headDir], 253
                                    jne hCheckUp
                                    mov byte [headRowIncr], 1
                                    mov byte [headColIncr], 0
                                    jmp steerHdFin
                    
                    hCheckUp:       ;2
                                    cmp byte [headDir], 2
                                    jne hCheckLeft
                                    mov byte [headRowIncr], -1
                                    mov byte [headColIncr], 0
                                    jmp steerHdFin
                    
                    hCheckLeft:     ;254
                                    cmp byte [headDir], 254
                                    jne hCheckRight
                                    mov byte [headRowIncr], 0
                                    mov byte [headColIncr], -1
                                    jmp steerHdFin
                    
                    hCheckRight:    ;1
                                    cmp byte [headDir], 1
                                    jne steerHdFin
                                    mov byte [headRowIncr], 0
                                    mov byte [headColIncr], 1
                                    
                    steerHdFin:     ret


;---------------------------------------------------------------------------------------------------------------------------

decTailDis:         ;decrements the current distance value in the tail distance array and updates tail direction if needed
                    push ax
                    push bx
                    
                    mov bx, [distancePtr]
                    cmp word [distanceArray + bx], -1
                    je decNdefVar
                    
                    sub  word [distanceArray + bx], 1
                    cmp word [distanceArray + bx], 0
                    jne decNdefVar
                    
                    mov word [distanceArray + bx], -1
                    mov bx, [directionPtr]
                    mov al, [directionArray + bx]
                    mov [tailDir], al
                    
                    add word [distancePtr], 2
                    add byte [directionPtr], 1
                    
                    cmp word [distancePtr], 400
                    jb skipDisPtr
                    mov word [distancePtr], 0
                    skipDisPtr:
                    
                    cmp byte [directionPtr], 100
                    jb skipDirPtr
                    mov byte [directionPtr], 0
                    skipDirPtr:
                    
                    call steerTail
                    
                    decNdefVar:     cmp word [undefinedVar], 0
                                    je exitDecTail
                                    sub word [undefinedVar], 1
                                    jz undefFlag0
                                    jmp exitDecTail
                                    
                    undefFlag0:     mov byte [undefinedFlag], 1                            
                    
                    exitDecTail:        pop bx
                                        pop ax
                                        ret

;---------------------------------------------------------------------------------------------------------------------------

moveSnake:          ;moves snake forward
                    pusha
                    push es
                    ;----------------------------------------------------
                    ;point es to  video mem
                    mov ax, 0xB800
                    mov es, ax
                    ;----------------------------------------------------
                    ;get offset for head sprite
                    mov ah, 0
                    mov al, [headRow]
                    push ax
                    mov al, [headCol]
                    push ax
                    call calcCoords
                    ;----------------------------------------------------
                    ;store head sprite
                    mov ax, [es:di]
                    mov [tempWord], ax
                    ;----------------------------------------------------
                    ;move body sprite to where head was
                    mov ax, [bodySprite]
                    mov [es:di], ax
                    ;----------------------------------------------------
                    ;update head coords
                    mov al, [headRowIncr]
                    add [headRow], al
                    mov al, [headColIncr]
                    add [headCol], al
                    call wrapSnakeH
                    ;----------------------------------------------------
                    ;draw head sprite at new location
                    mov ah, 0
                    mov al, [headRow]
                    push ax
                    mov al, [headCol]
                    push ax
                    call calcCoords
                    
                    mov ax, [es:di]             ;mov sprite at new location into ax
                    cmp ax, [fruitSprite]       ;check if a fruit was eaten
                    jnz skipFlagSt
                    mov byte [growFlag], 1
                    skipFlagSt:
                    
                    cmp ax, [bodySprite]
                    jnz skipFlagCol1
                    mov byte [collisionFlag], 1
                    skipFlagCol1:
                    
                    cmp ax, [tailSprite]
                    jnz skipFlagCol2
                    mov byte [collisionFlag], 1
                    skipFlagCol2:
                    
                    mov ax, [tempWord]
                    mov [es:di], ax
                    ;----------------------------------------------------
                    ;drawing bgsprite on current tail tile
                    mov ah, 0
                    mov al, [tailRow]
                    push ax
                    mov al, [tailCol]
                    push ax
                    call calcCoords
                    mov ax, [bgSprite]
                    mov [es:di], ax
                    ;----------------------------------------------------
                    ;moving tail forward by 1 in tail direction
                    mov al, [tailRowIncr]
                    add [tailRow], al
                    mov al, [tailColIncr]
                    add [tailCol], al
                    call wrapSnakeT
                    ;----------------------------------------------------
                    ;debug draw tail
                    mov ah, 0
                    mov al, [tailRow]
                    push ax
                    mov al, [tailCol]
                    push ax
                    call calcCoords
                    mov ax, [tailSprite]
                    mov [es:di], ax
                    ;----------------------------------------------------
                    mov byte [undefinedFlag], 0
                    call decTailDis
                    ;----------------------------------------------------
                    pop es
                    popa
                    ret
                    
;---------------------------------------------------------------------------------------------------------------------------

changeHead:         ;changes head sprite based on direction
                    push ax
                    push di
                    push es
                    
                    mov ah, 0
                    mov al, [headRow]
                    push ax
                    mov al, [headCol]
                    push ax
                    call calcCoords
                    
                    mov ax, 0xb800
                    mov es, ax
                    
                    chngHdUp:       ;2
                                    cmp byte [headDir], 2
                                    jnz chngHdDown
                                    mov ax, [headUpSprite]
                                    mov [es:di], ax
                                    jmp chngHdFin
                    
                    chngHdDown:     ;253
                                    cmp byte [headDir], 253
                                    jnz chngHdLeft
                                    mov ax, [headDownSprite]
                                    mov [es:di], ax
                                    jmp chngHdFin
                    
                    chngHdLeft:     ;254
                                    cmp byte [headDir], 254
                                    jnz chngHdRight
                                    mov ax, [headLeftSprite]
                                    mov [es:di], ax
                                    jmp chngHdFin
                    
                    chngHdRight:        ;1
                                    cmp byte [headDir], 1
                                    jnz chngHdFin
                                    mov ax, [headRightSprite]
                                    mov [es:di], ax
                                    jmp chngHdFin
                    
                    chngHdFin:      pop es
                                    pop di
                                    pop ax
                    
;---------------------------------------------------------------------------------------------------------------------------

turn_oALgo:         ;turns o algo
                    cli
                    pusha
                    push es
                    ;----------------------------------------------------
                    ;checks if new direction = current direction or reverse direction and exits if yes to either
                    mov al, [directionInput]
                    cmp [headDir], al
                    jz stopTurn
                    cmp [headDirOpposite], al
                    jz stopTurn
                    ;----------------------------------------------------
                    mov [headDir], al
                    call steerHead
                    mov [headDirOpposite], al
                    xor byte [headDirOpposite], 0xff
                    ;----------------------------------------------------
                    ;adds new values to arrays 
                    mov bx, [setDirectionPtr]
                    mov [directionArray + bx], al
                    
                    mov ax, [snakeLen]
                    sub ax, 1
                    sub ax, [undefinedVar]
                    add [undefinedVar], ax
                    
                    mov bx, [setDistancePtr]
                    mov [distanceArray + bx], ax
                    ;----------------------------------------------------
                    add word [setDistancePtr], 2
                    add byte [setDirectionPtr], 1
                    
                    cmp word [setDistancePtr], 400
                    jb skipSDisPtr
                    mov word [setDistancePtr], 0
                    skipSDisPtr:
                    
                    cmp byte [setDirectionPtr], 100
                    jb skipSDirPtr
                    mov byte [setDirectionPtr], 0
                    skipSDirPtr:
                    ;----------------------------------------------------
                    call changeHead
                    ;----------------------------------------------------
                    stopTurn:       pop es
                                    popa
                                    sti
                                    ret
                    
;---------------------------------------------------------------------------------------------------------------------------

newSpwnRow:         ;initializes new value of spawn row based on seed
                    push ax
                    push dx
                    push bx
                    
                    mov dx, 0
                    mov ax, [seed]
                    mov bx, 23
                    
                    div bx
                    add dx, 1
                    
                    mov [spawnRow], dl
                    
                    pop bx
                    pop dx
                    pop ax
                    
                    ret
                    
newSpwnCol:         ;initializes new value of spawn col based on seed
                    push ax
                    push dx
                    push bx
                    
                    mov dx, 0
                    mov ax, [seed]
                    mov bx, 78
                    
                    div bx
                    add dx, 1
                    
                    mov [spawnCol], dl
                    
                    pop bx
                    pop dx
                    pop ax
                    
                    ret                    

;---------------------------------------------------------------------------------------------------------------------------
grow_oAlgo:         ;grows the snake if food if the growFlag is on
                    pusha
                    push es
                    ;----------------------------------------------------
                    mov ax, 0xb800
                    mov es, ax
                    ;----------------------------------------------------
                    ;check if growFlag is set or not
                    cmp byte [growFlag], 1
                    jnz doNotGrow
                    ;----------------------------------------------------
                    ;increment current [distanceArray + distancePtr]
                    mov bx, [distancePtr]
                    cmp word [distanceArray + bx], -1
                    jz skipDisRev
                    add word [distanceArray + bx], 1
                    skipDisRev:
                    ;----------------------------------------------------
                    ;undefinedFlag shenanigans
                    cmp word [undefinedVar], 0
                    jz skipUVInc1
                    add word [undefinedVar], 1
                    skipUVInc1:     ;skips first unconditional increment if undef var is zero
                                    cmp byte [undefinedFlag], 0
                                    jz skipUVInc2
                                    add word [undefinedVar], 1
                                    skipUVInc2:
                    ;----------------------------------------------------
                    ;move body sprite to current tail coords
                    mov ah, 0
                    mov al, [tailRow]
                    push ax
                    mov al, [tailCol]
                    push ax 
                    call calcCoords
                    mov ax, [bodySprite]
                    mov [es:di], ax
                    ;----------------------------------------------------
                    ;subtract tail increments from the tail coords to get new tail coords
                    mov al, [tailRowIncr]
                    sub [tailRow], al
                    mov al, [tailColIncr]
                    sub [tailCol], al
                    cmp byte [wallMode], 1
                    jz skipWallWr
                    call wrapSnakeT
                    skipWallWr:
                    ;----------------------------------------------------
                    ;move tail sprite to tail coords 
                    mov ah, 0
                    mov al, [tailRow]
                    push ax
                    mov al, [tailCol]
                    push ax 
                    call calcCoords
                    mov ax, [tailSprite]
                    mov [es:di], ax
                    ;----------------------------------------------------
                    ;increment snake length
                    add word [snakeLen], 1
                    call printLen
                    ;----------------------------------------------------
                    ;get new spawn coordinates
                    call newSpwnRow
                    call newSpwnCol
                    ;----------------------------------------------------
                    ;check if new spawn coords are empty
                    mov ah, 0
                    mov al, [spawnRow]
                    push ax
                    mov al, [spawnCol]
                    push ax
                    call calcCoords
                    
                    mov ax, [bgSprite]
                    cmp ax, [es:di]
                    jz cellFound
                    ;----------------------------------------------------
                    ;manually find new cell
                    cld
                    mov di, 0
                    mov cx, 2000
                    repne scasw
                    ;----------------------------------------------------
                    cellFound:          mov ax, [fruitSprite]
                                        mov [es:di], ax
                                        mov byte [growFlag], 0
                    ;----------------------------------------------------
                    doNotGrow:      pop es
                                    popa
                                    ret

;---------------------------------------------------------------------------------------------------------------------------

ouroborous:         ;checks for collision with self
                    pusha
                    push es
                    
                    cmp byte [collisionFlag], 1
                    jnz noSelfColl
                    
                    mov di, 0
                    mov ax, 0xb800
                    mov es, ax
                    mov ax, 0x7F00
                    mov cx, 2000
                    
                    invertScr:      xor [es:di], ax
                                    add di, 2
                                    loop invertScr
                                    
                    call collDelay                    
                    
                    
                    noSelfColl:     popa
                                    pop es
                                    ret

;---------------------------------------------------------------------------------------------------------------------------

collDelay:          ;collision second delay
                    mov byte [tickCount], 0
                    delayLoopC:     ;delays
                                    cmp byte [tickCount], 18
                                    jb delayLoopC
                    ret                    

;---------------------------------------------------------------------------------------------------------------------------

nSecDelay:          ;n second delay
                    mov byte [tickCount], 0
                    delayLoop:      ;delays
                                    cmp byte [tickCount], 1
                                    jb delayLoop
                    ret

;---------------------------------------------------------------------------------------------------------------------------

INT_8:              ;hooks into IRQ 0, the timer interrupt
                    add byte [tickCount], 1
                    add word [seed], 1
                    ;call moveSnake
                    jmp far [cs:oldTimeIsr]

;---------------------------------------------------------------------------------------------------------------------------

INT_9:              ;hooks into IRQ 1, the keyboard interrupt
                    push ax
                    
                    in al, 0x60
                    
                    checkEsc:           ;checks if escape was pressed
                                        cmp al, 0x01
                                        jnz checkI
                                        mov byte [escFlag], 1
                                        jmp exitINT9
                    
                    checkI:         ;checks if input = I
                                    cmp al, 0x17
                                    jnz checkJ
                                    mov byte [directionInput], 2
                                    jmp exitINT9
                    
                    checkJ:         ;checks if input = J
                                    cmp al, 0x24
                                    jnz checkK
                                    mov byte [directionInput], 254
                                    jmp exitINT9
                                    
                    checkK:         ;checks if input = K
                                    cmp al, 0x25
                                    jnz checkL
                                    mov byte [directionInput], 253
                                    jmp exitINT9
                                    
                    checkL:         ;checks if input = L
                                    cmp al, 0x26
                                    jnz exitINT9
                                    mov byte [directionInput], 1
                                    
                    exitINT9:           mov al, 0x20
                                        out 0x20, al
                                        
                                        pop ax
                                        iret

;---------------------------------------------------------------------------------------------------------------------------

start:              ;starts
                    ;----------------------------------------------------
                    call background
                    call initVars
                    ;call titleScr
                    ;call selectMode
                    ;----------------------------------------------------
                    ;hooking to IRQ 0
                    mov ax, 0
                    mov es, ax
                    mov ax, [es:8*4]
                    mov [oldTimeIsr], ax        ;offset
                    mov ax, [es:8*4+2]
                    mov [oldTimeIsr+2], ax      ;segment
                    
                    cli
                    mov word [es:8*4], INT_8
                    mov word [es:8*4+2], cs
                    sti    
                    
                    ;---------------------------------------------------- 
                    ;hooking into IRQ 1
                    mov ax, 0
                    mov es, ax
                    mov ax, [es:9*4]
                    mov [oldKeybIsr], ax
                    mov ax, [es:9*4+2]
                    mov [oldKeybIsr+2], ax
                    
                    cli
                    mov word [es:9*4], INT_9
                    mov word [es:9*4+2], cs
                    sti
                    
                    ;----------------------------------------------------
                    titleTheme:     ;initializes the title screen
                                    call titleScr
                                    call selectMode
                    ;----------------------------------------------------
                    initEnv:            ;initialize environment
                                    call background
                                    call initVars
                    ;----------------------------------------------------
                    gameLoop:       ;game loop test
                                    cmp byte [escFlag], 1
                                    jz consumed
                                    call moveSnake
                                    call ouroborous
                                    cmp byte [collisionFlag], 1
                                    jz initEnv
                                    call turn_oALgo             ;i THINK it should turn before growing to get rid of that ultra rare tail glitch
                                    call grow_oAlgo
                                    call nSecDelay
                                    ;call turn_oALgo
                                    jmp gameLoop
                    ;----------------------------------------------------
                    consumed:       ;unhooks and exits
                                    call clrscr
                                    cli
                                    mov ax, 0
                                    mov es, ax
                                    mov ax, [oldTimeIsr]
                                    mov word [es:8*4], ax
                                    mov ax, [oldTimeIsr+2]
                                    mov word [es:8*4+2], ax
                                    mov ax, [oldKeybIsr]
                                    mov word [es:9*4], ax
                                    mov ax, [oldKeybIsr+2]
                                    mov word [es:9*4+2], ax
                                    sti
                                    
                    ;----------------------------------------------------
                    mov ax, 0x4c00
                    int 0x21