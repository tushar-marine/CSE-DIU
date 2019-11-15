; coading by tushar
org 100h

.data
    msg1 db "***TIC TAC TOE GAME***", 10, 13, "$"
    msg2 db "Please select your spot(1-9): $"
    msg3 db 10, 13, "Wrong Choice !!!", 10, 13, "$"
    msg4 db "Player 1's turn:", 10, 13, "$"
    msg5 db "Player 2's turn:", 10, 13, "$"
    msg6 db "1. Player vs Player.", 10, 13, "2. Player vs Computer.",10,13,"$"
    msg7 db "Please select your game mode: $"
    msg8 db "Invalid choice!!!", 10, 13, "$" 
    msg9 db "Computer is thinking....", 10, 13, "$" 
    msg10 db "Your turn:", 10, 13, "$"  
    msg11 db 10, 13, "Select first move:", 10, 13, "$"
    msg12 db "1. Computer play first", 10, 13, "2. You play first.",10,13,"$"
    winer1 db "Congratulation !!! Player 1 wins...$"
    winer2 db "Congratulation !!! Player 2 wins...$"
    winer3 db "Congratulation !!! You won...$"
    winer4 db "Computer won !!! You lost...$"
    msgdraw db "Match draw. Nobody wins...$"
    msgend db "*** Game Over ***$"    
    line1 db 49,'|',50,'|',51
    line2 db 52,'|',53,'|',54
    line3 db 55,'|',56,'|',57
    nline db 10, 13, "$"
    mline db "-*-*-", 10, 13, "$"
    
    r1 db 0,0,0
    r2 db 0,0,0
    r3 db 0,0,0
    counter db 1
    player db ?
    num db 0
    choice db ?
    mode db ?  

.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 9
    lea dx, msg1
    int 21h
   
    gamemode:
        lea dx, nline
        int 21h
        lea dx, msg6
        int 21h 
        lea dx, msg7
        int 21h
        
        mov ah, 1
        int 21h
        mov choice, al
        
        
        cmp choice, '1'
        je vsplayer
        
        cmp choice, '2'
        je vscomputer
        
        mov ah, 9
        lea dx, msg8
        jmp gamemode
    
    vsplayer:
    
         print:
        
            mov ah, 9
            lea dx, nline
            int 21h
            cmp counter, 1
            je next
            lea dx, msg5
            int 21h
            jmp cont
            next:
                lea dx, msg4
                int 21h
            cont:    
            mov ah, 2
            mov cx, 5
            mov si, offset line1
            loop1:
                mov dl, [si]
                int 21h
                add si, 1
                loop loop1 
            mov ah, 9
            lea dx, nline
            int 21h
            lea dx, mline
            int 21h 
            
            mov ah, 2
            mov cx, 5
            mov si, offset line2
            loop2:    
                mov dl, [si]
                int 21h
                add si, 1
                loop loop2 
            mov ah, 9
            lea dx, nline
            int 21h
            lea dx, mline
            int 21h
            
            mov ah, 2
            mov cx, 5
            mov si, offset line3
            loop3:
                mov dl, [si]
                int 21h
                add si, 1
                loop loop3 
                    
            input:
                mov ah, 9
                lea dx, nline
                int 21h
                lea dx, msg2
                int 21h
    
                mov ah, 1
                int 21h 
                mov bl, al
                cmp bl, 49
                jl error
                je one
                cmp bl, 50
                je two
                cmp bl, 51
                je three
                cmp bl, 52
                je four
                cmp bl, 53
                je five
                cmp bl, 54
                je six
                cmp bl, 55
                je seven
                cmp bl, 56
                je eight
                cmp bl, 57
                je nine
                jg error
                
                
                one:
                    mov di, offset r1
                    cmp [di], 78
                    jg error
                    cmp counter, 1
                    je subpart
                    mov [di], 88
                    mov counter, 1
                    jmp check
                        subpart:
                            mov [di], 79
                            mov counter, 0
                            jmp check 
                two:
                    mov si, offset r1
                    add si, 1
                    cmp [si], 78
                    jg error                 
                    cmp counter, 1
                    je subpart2
                    mov [si], 88
                    mov counter, 1
                    jmp check
                        subpart2:
                            mov [si], 79
                            mov counter, 0
                            jmp check                
                three:
                    mov si, offset r1
                    add si, 2
                    cmp [si], 78
                    jg error                
                    cmp counter, 1
                    je subpart3
                    mov [si], 88
                    mov counter, 1
                    jmp check
                        subpart3:
                            mov [si], 79
                            mov counter, 0
                            jmp check                  
                four:
                    mov si, offset r2
                    cmp [si], 78
                    jg error
                    cmp counter, 1
                    je subpart4
                    mov [si], 88
                    mov counter, 1
                    jmp check
                        subpart4:
                            mov [si], 79
                            mov counter, 0
                            jmp check 
                              
                five:
                    mov si, offset r2
                    add si, 1
                    cmp [si], 78
                    jg error                
                    cmp counter, 1
                    je subpart5
                    mov [si], 88
                    mov counter, 1
                    jmp check
                        subpart5:
                            mov [si], 79
                            mov counter, 0
                            jmp check 
                               
                six:
                    mov si, offset r2
                    add si, 2
                    cmp [si], 78
                    jg error                
                    cmp counter, 1
                    je subpart6
                    mov [si], 88
                    mov counter, 1
                    jmp check
                        subpart6:
                            mov [si], 79
                            mov counter, 0
                            jmp check 
                                
                seven:
                    mov si, offset r3
                    cmp [si], 78
                    jg error
                    cmp counter, 1
                    je subpart7
                    mov [si], 88
                    mov counter, 1
                    jmp check
                        subpart7:
                            mov [si], 79
                            mov counter, 0
                            jmp check 
                           
                eight:
                    mov si, offset r3
                    add si, 1
                    cmp [si], 78
                    jg error                
                    cmp counter, 1
                    je subpart8
                    mov [si], 88 
                    mov counter, 1
                    jmp check
                        subpart8:
                            mov [si], 79
                            mov counter, 0
                            jmp check 
                                
                nine:
                    mov si, offset r3
                    add si, 2
                    cmp [si], 78
                    jg error                
                    cmp counter, 1
                    je subpart9
                    mov [si], 88
                    mov counter, 1
                    jmp check
                        subpart9:
                            mov [si], 79
                            mov counter, 0
                            jmp check 
                    
                
                error:
                    mov ah, 9
                    lea dx, msg3
                    int 21h
                    jmp input
                
                check:
                    mov si, offset r1
                    mov di, offset line1                
                    mov cx, 3
                    loop4:
                        cmp [si], 78
                        jl pass
                        mov dl, [si]
                        mov [di], dl 
                        pass:
                            add si, 1
                            add di, 2
                        loop loop4
                    
                    mov si, offset r2
                    mov di, offset line2                
                    mov cx, 3
                    loop5:
                        cmp [si], 78
                        jl pass2            
                        mov dl, [si]
                        mov [di], dl
                        pass2: 
                            add si, 1
                            add di, 2
                        loop loop5
                    
                    mov si, offset r3
                    mov di, offset line3                
                    mov cx, 3
                    loop6:
                        cmp [si], 78
                        jl pass3
                        mov dl, [si]
                        mov [di], dl 
                        pass3:
                            add si, 1
                            add di, 2
                        loop loop6
                    add num, 1
                    cmp num, 5
                    jl print
    
                    mov si, offset r1
                    mov dl, [si]                
                    add si, 1
                    cmp dl, [si]
                    jne c2               
                    add si, 1
                    cmp dl, [si]
                    jne c2
                    cmp dl, 0
                    je c2
                    mov player, dl
                    jmp win
                    
                    c2:       
                        mov si, offset r2
                        mov dl, [si]                
                        add si, 1
                        cmp dl, [si]
                        jne c3
                        add si, 1
                        cmp dl, [si]
                        jne c3
                        cmp dl, 0
                        je c3
                        mov player, dl
                        jmp win 
                                       
                    c3:    
                        mov si, offset r3                
                        mov dl, [si]                
                        add si, 1
                        cmp dl, [si]
                        jne c4
                        add si, 1
                        cmp dl, [si]
                        jne c4
                        cmp dl, 0
                        je c4
                        mov player, dl
                        jmp win
                    
                    c4:    
                        mov bx, offset r1
                        mov si, offset r2
                        mov di, offset r3
                        mov cx, 3
                        loop7:                                    
                            mov dl, [bx]
                            cmp dl, [si]
                            jne skip1                        
                            cmp dl, [di]
                            jne skip1
                            cmp dl, 0
                            je skip1
                            mov player, dl
                            jmp win
                            skip1:                      
                                add bx, 1
                                add si, 1
                                add di, 1
                            loop loop7                
                        
                    mov bx, offset r1
                    mov si, offset r2
                    mov di, offset r3
                    mov cl, [bx]
                    add si, 1
                    add di, 2
                    cmp cl, [si]
                    jne c5                
                    cmp cl, [di]
                    jne c5
                    cmp cl, 0
                    je c5
                    mov player, cl
                    jmp win
                    
                    c5:
                        mov bx, offset r1
                        mov si, offset r2
                        mov di, offset r3
                        add bx, 2
                        mov cl, [bx]
                        add si, 1
                        cmp cl, [si]
                        jne drawcheck                         
                        cmp cl, [di]
                        jne drawcheck
                        cmp cl, 0
                        je drawcheck
                        mov player, cl
                        jmp win
                        
                    drawcheck:
                        cmp num, 9
                        jge draw
                                                            
        goprint:                                    
            jmp print                        
        draw:
            mov ah, 9
            lea dx, nline
            int 21h
            lea dx, nline
            int 21h
            lea dx, msgdraw
            int 21h
            jmp result
     
        win:
            mov ah, 9
            lea dx, nline
            int 21h
            lea dx, nline
            int 21h
            cmp player, 79
            je player1
            cmp player, 88
            je player2
    
            player1:
                mov ah, 9
                lea dx, winer1
                int 21h
                lea dx, nline
                int 21h
                jmp result
                 
            player2:
                mov ah, 9
                lea dx, winer2
                int 21h
                lea dx, nline
                int 21h        
        
        result:
            mov ah, 9
            lea dx, nline
            int 21h
                
            mov ah, 2
            mov cx, 5
            mov si, offset line1
            loop8:
                mov dl, [si]
                int 21h
                add si, 1
                loop loop8 
            mov ah, 9
            lea dx, nline
            int 21h
            lea dx, mline
            int 21h 
            
            mov ah, 2
            mov cx, 5
            mov si, offset line2
            loop9:    
                mov dl, [si]
                int 21h
                add si, 1
                loop loop9 
            mov ah, 9
            lea dx, nline
            int 21h
            lea dx, mline
            int 21h
            
            mov ah, 2
            mov cx, 5
            mov si, offset line3
            loop10:
                mov dl, [si]
                int 21h
                add si, 1
                loop loop10 
            mov ah, 9
            lea dx, nline
            int 21h
            lea dx, msgend
            int 21h
            jmp finishing
    
    vscomputer:
        selectmove:
            mov ah, 9
            lea dx, msg11
            int 21h
            lea dx, msg12
            int 21h
            
            mov ah, 1
            int 21h
            mov mode, al
            
            cmp mode, 49
            je print2
            cmp mode, 50
            je playersmove
            mov ah, 9
            lea dx, nline
            int 21h
            lea dx, msg8
            int 21h
            jmp selectmove
            
            playersmove:
                mov counter, 0             
        
             print2:
            
                mov ah, 9
                lea dx, nline
                int 21h
                cmp counter, 1
                je next2
                lea dx, msg10
                int 21h
                jmp cont2
                next2: 
                    lea dx, msg9
                    int 21h
                    jmp computerpart  ; jump to computer AI
                cont2:    
                mov ah, 2
                mov cx, 5
                mov si, offset line1
                round1:
                    mov dl, [si]
                    int 21h
                    add si, 1
                    loop round1 
                mov ah, 9
                lea dx, nline
                int 21h
                lea dx, mline
                int 21h 
                
                mov ah, 2
                mov cx, 5
                mov si, offset line2
                round2:    
                    mov dl, [si]
                    int 21h
                    add si, 1
                    loop round2 
                mov ah, 9
                lea dx, nline
                int 21h
                lea dx, mline
                int 21h
                
                mov ah, 2
                mov cx, 5
                mov si, offset line3
                round3:
                    mov dl, [si]
                    int 21h
                    add si, 1
                    loop round3 
                        
                input2:
                    mov ah, 9
                    lea dx, nline
                    int 21h
                    lea dx, msg2
                    int 21h
        
                    mov ah, 1
                    int 21h 
                    mov bl, al
                    cmp bl, 49
                    jl error2
                    je one2
                    cmp bl, 50
                    je two2
                    cmp bl, 51
                    je three2
                    cmp bl, 52
                    je four2
                    cmp bl, 53
                    je five2
                    cmp bl, 54
                    je six2
                    cmp bl, 55
                    je seven2
                    cmp bl, 56
                    je eight2
                    cmp bl, 57
                    je nine2
                    jg error2
                    
                    
                    one2:
                        mov di, offset r1
                        cmp [di], 78
                        jg error2
                        mov [di], 88
                        mov counter, 1
                        jmp check2
                    two2:
                        mov si, offset r1
                        add si, 1
                        cmp [si], 78
                        jg error2                 
                        mov [si], 88
                        mov counter, 1
                        jmp check2                
                    three2:
                        mov si, offset r1
                        add si, 2
                        cmp [si], 78
                        jg error2                
                        mov [si], 88
                        mov counter, 1
                        jmp check2                  
                    four2:
                        mov si, offset r2
                        cmp [si], 78
                        jg error2
                        mov [si], 88
                        mov counter, 1
                        jmp check2                                  
                    five2:
                        mov si, offset r2
                        add si, 1
                        cmp [si], 78
                        jg error2                
                        mov [si], 88
                        mov counter, 1
                        jmp check2                                   
                    six2:
                        mov si, offset r2
                        add si, 2
                        cmp [si], 78
                        jg error2                
                        mov [si], 88
                        mov counter, 1
                        jmp check2                                    
                    seven2:
                        mov si, offset r3
                        cmp [si], 78
                        jg error2
                        mov [si], 88
                        mov counter, 1
                        jmp check2            
                    eight2:
                        mov si, offset r3
                        add si, 1
                        cmp [si], 78
                        jg error2
                        mov [si], 88 
                        mov counter, 1
                        jmp check2                                    
                    nine2:
                        mov si, offset r3
                        add si, 2
                        cmp [si], 78
                        jg error2
                        mov [si], 88
                        mov counter, 1
                        jmp check2
                        
                    error2:
                        mov ah, 9
                        lea dx, msg3
                        int 21h
                        jmp input2
    
                    check2:
                        mov si, offset r1
                        mov di, offset line1                
                        mov cx, 3
                        round4:
                            cmp [si], 78
                            jl skip5
                            mov dl, [si]
                            mov [di], dl 
                            skip5:
                                add si, 1
                                add di, 2
                            loop round4
                        
                        mov si, offset r2
                        mov di, offset line2                
                        mov cx, 3
                        round5:
                            cmp [si], 78
                            jl skip2            
                            mov dl, [si]
                            mov [di], dl
                            skip2: 
                                add si, 1
                                add di, 2
                            loop round5
                        
                        mov si, offset r3
                        mov di, offset line3                
                        mov cx, 3
                        round6:
                            cmp [si], 78
                            jl skip3
                            mov dl, [si]
                            mov [di], dl 
                            skip3:
                                add si, 1
                                add di, 2
                            loop round6
                            
                        add num, 1
                        cmp num, 5
                        jl print2
        
                        mov si, offset r1
                        mov dl, [si]                
                        add si, 1
                        cmp dl, [si]
                        jne compair2               
                        add si, 1
                        cmp dl, [si]
                        jne compair2
                        cmp dl, 0
                        je compair2
                        mov player, dl
                        jmp win2
                        
                        compair2:       
                            mov si, offset r2
                            mov dl, [si]                
                            add si, 1
                            cmp dl, [si]
                            jne compair3
                            add si, 1
                            cmp dl, [si]
                            jne compair3
                            cmp dl, 0
                            je compair3
                            mov player, dl
                            jmp win2 
                                           
                        compair3:    
                            mov si, offset r3                
                            mov dl, [si]                
                            add si, 1
                            cmp dl, [si]
                            jne compair4
                            add si, 1
                            cmp dl, [si]
                            jne compair4
                            cmp dl, 0
                            je compair4
                            mov player, dl
                            jmp win2
                        
                        compair4:    
                            mov bx, offset r1
                            mov si, offset r2
                            mov di, offset r3
                            mov cx, 3
                            round7:                                    
                                mov dl, [bx]
                                cmp dl, [si]
                                jne skip4                        
                                cmp dl, [di]
                                jne skip4
                                cmp dl, 0
                                je skip4
                                mov player, dl
                                jmp win2
                                skip4:                      
                                    add bx, 1
                                    add si, 1
                                    add di, 1
                                loop round7                
                         
                        mov bx, offset r1
                        mov si, offset r2
                        mov di, offset r3
                        mov cl, [bx]
                        add si, 1
                        add di, 2
                        cmp cl, [si]
                        jne compair5                
                        cmp cl, [di]
                        jne compair5
                        cmp cl, 0
                        je compair5
                        mov player, cl
                        jmp win2
                        
                        compair5:
                            mov bx, offset r1
                            mov si, offset r2
                            mov di, offset r3
                            add bx, 2
                            mov cl, [bx]
                            add si, 1
                            cmp cl, [si]
                            jne drawcheck2                         
                            cmp cl, [di]
                            jne drawcheck2
                            cmp cl, 0
                            je drawcheck2
                            mov player, cl
                            jmp win2
                            
                        drawcheck2:
                            cmp num, 9
                            jge draw2
                        ;;;;;;;;;;;;;;;;;;;;;;;;;;End of com vs player {Player part}                                       
            
            computerpart:
                
                mov counter, 0
                
                mov bx, offset r1
                mov si, offset r2
                mov di, offset r3
                
                logic1:                
                    cmp [bx], 79
                    jne logic7
                    cmp [bx+1], 79
                    jne logic2
                    cmp [bx+2], 0
                    jne logic2
                    mov [bx+2], 79
                    jmp comwin
                
                logic2:
                    cmp [bx+2], 79
                    jne logic3
                    cmp [bx+1], 0
                    jne logic3
                    mov [bx+1], 79
                    jmp comwin
                
                logic3:
                    cmp [si], 79
                    jne logic4
                    cmp [di], 0
                    jne logic4
                    mov [di], 79
                    jmp comwin
            
                logic4:
                    cmp [di], 79
                    jne logic5
                    cmp [si], 0
                    jne logic5
                    mov [si], 79
                    jmp comwin
            
                logic5:
                    cmp [si+1], 79
                    jne logic6
                    cmp [di+2], 0
                    jne logic6
                    mov [di+2], 79
                    jmp comwin
            
                logic6:
                    cmp [di+2], 79
                    jne logic7
                    cmp [si+1], 0
                    jne logic7
                    mov [si+1], 79
                    jmp comwin
            
                logic7:
                    cmp [bx+1], 79
                    jne logic10
                    cmp [bx+2], 79
                    jne logic8
                    cmp [bx], 0
                    jne logic8
                    mov [bx], 79
                    jmp comwin
            
                logic8:
                    cmp [si+1], 79
                    jne logic9
                    cmp [di+1], 0
                    jne logic9
                    mov [di+1], 79
                    jmp comwin
            
                logic9:
                    cmp [di+1], 79
                    jne logic10
                    cmp [si+1], 0
                    jne logic10
                    mov [si+1], 79
                    jmp comwin
            
                logic10:
                    cmp [bx+2], 79
                    jne logic14
                    cmp [si+2], 79
                    jne logic11
                    cmp [di+2], 0
                    jne logic11
                    mov [di+2], 79
                    jmp comwin
                
                logic11:
                    cmp [di+2], 79
                    jne logic12
                    cmp [si+2], 0
                    jne logic12
                    mov [si+2], 79
                    jmp comwin
                
                logic12:
                    cmp [si+1], 79
                    jne logic13
                    cmp [di], 0
                    jne logic13
                    mov [di], 79
                    jmp comwin
                
                logic13:
                    cmp [di], 79
                    jne logic14
                    cmp [si+1], 0
                    jne logic14
                    mov [si+1], 79
                    jmp comwin
                
                logic14:
                    cmp [si], 79
                    jne logic17
                    cmp [si+1], 79
                    jne logic15
                    cmp [si+2], 0
                    jne logic15
                    mov [si+2], 79
                    jmp comwin
                
                logic15:
                    cmp [si+2], 79
                    jne logic16
                    cmp [si+1], 0
                    jne logic16
                    mov [si+1], 79
                    jmp comwin
                
                logic16:
                    cmp [di], 79
                    jne logic17
                    cmp [bx], 0
                    jne logic17
                    mov [bx], 79
                    jmp comwin
                
                logic17:
                    cmp [si+1], 79
                    jne logic21
                    cmp [si+2], 79
                    jne logic18
                    cmp [si], 0
                    jne logic18
                    mov [si], 79
                    jmp comwin
                
                logic18:
                    cmp [di+1], 79
                    jne logic19
                    cmp [bx+1], 0
                    jne logic19
                    mov [bx+1], 79
                    jmp comwin
                    
                logic19:
                    cmp [di+2], 79
                    jne logic20
                    cmp [bx], 0
                    jne logic20
                    mov [bx], 79
                    jmp comwin    
                    
                logic20:
                    cmp [di], 79
                    jne logic21
                    cmp [bx+2], 0
                    jne logic21
                    mov [bx+2], 79
                    jmp comwin    
                    
                logic21:
                    cmp [di], 79
                    jne logic23
                    cmp [di+1], 79
                    jne logic22
                    cmp [di+2], 0
                    jne logic22
                    mov [di+2], 79
                    jmp comwin
                
                logic22:
                    cmp [di+2], 79
                    jne logic23
                    cmp [di+1], 0
                    jne logic23
                    mov [di+1], 79
                    jmp comwin    
                    
                logic23:
                    cmp [di+2], 79
                    jne logic25
                    cmp [si+2], 79
                    jne logic24
                    cmp [bx+2], 0
                    jne logic24
                    mov [bx+2], 79
                    jmp comwin
                
                logic24:
                    cmp [di+1], 79
                    jne logic25
                    cmp [di], 0
                    jne logic25
                    mov [di], 79
                    jmp comwin    
                    
                logic25:                
                    cmp [bx], 88
                    jne logic31
                    cmp [bx+1], 88
                    jne logic26
                    cmp [bx+2], 0
                    jne logic26
                    mov [bx+2], 79
                    jmp reload
                
                logic26:
                    cmp [bx+2], 88
                    jne logic27
                    cmp [bx+1], 0
                    jne logic27
                    mov [bx+1], 79
                    jmp reload
                
                logic27:
                    cmp [si], 88
                    jne logic28
                    cmp [di], 0
                    jne logic28
                    mov [di], 79
                    jmp reload
            
                logic28:
                    cmp [di], 88
                    jne logic29
                    cmp [si], 0
                    jne logic29
                    mov [si], 79
                    jmp reload
            
                logic29:
                    cmp [si+1], 88
                    jne logic30
                    cmp [di+2], 0
                    jne logic30
                    mov [di+2], 79
                    jmp reload
            
                logic30:
                    cmp [di+2], 88
                    jne logic31
                    cmp [si+1], 0
                    jne logic31
                    mov [si+1], 79
                    jmp reload
            
                logic31:
                    cmp [bx+1], 88
                    jne logic34
                    cmp [bx+2], 88
                    jne logic32
                    cmp [bx], 0
                    jne logic32
                    mov [bx], 79
                    jmp reload
            
                logic32:
                    cmp [si+1], 88
                    jne logic33
                    cmp [di+1], 0
                    jne logic33
                    mov [di+1], 79
                    jmp reload
            
                logic33:
                    cmp [di+1], 88
                    jne logic34
                    cmp [si+1], 0
                    jne logic34
                    mov [si+1], 79
                    jmp reload
            
                logic34:
                    cmp [bx+2], 88
                    jne logic38
                    cmp [si+2], 88
                    jne logic35
                    cmp [di+2], 0
                    jne logic35
                    mov [di+2], 79
                    jmp reload
                
                logic35:
                    cmp [di+2], 88
                    jne logic36
                    cmp [si+2], 0
                    jne logic36
                    mov [si+2], 79
                    jmp reload
                
                logic36:
                    cmp [si+1], 88
                    jne logic37
                    cmp [di], 0
                    jne logic37
                    mov [di], 79
                    jmp reload
                
                logic37:
                    cmp [di], 88
                    jne logic38
                    cmp [si+1], 0
                    jne logic38
                    mov [si+1], 79
                    jmp reload
                
                logic38:
                    cmp [si], 88
                    jne logic41
                    cmp [si+1], 88
                    jne logic39
                    cmp [si+2], 0
                    jne logic39
                    mov [si+2], 79
                    jmp reload
                
                logic39:
                    cmp [si+2], 88
                    jne logic40
                    cmp [si+1], 0
                    jne logic40
                    mov [si+1], 79
                    jmp reload
                
                logic40:
                    cmp [di], 88
                    jne logic41
                    cmp [bx], 0
                    jne logic41
                    mov [bx], 79
                    jmp reload
                
                logic41:
                    cmp [si+1], 88
                    jne logic45
                    cmp [si+2], 88
                    jne logic42
                    cmp [si], 0
                    jne logic42
                    mov [si], 79
                    jmp reload
                
                logic42:
                    cmp [di+1], 88
                    jne logic43
                    cmp [bx+1], 0
                    jne logic43
                    mov [bx+1], 79
                    jmp reload
                    
                logic43:
                    cmp [di+2], 88
                    jne logic44
                    cmp [bx], 0
                    jne logic44
                    mov [bx], 79
                    jmp reload    
                    
                logic44:
                    cmp [di], 88
                    jne logic45
                    cmp [bx+2], 0
                    jne logic45
                    mov [bx+2], 79
                    jmp reload    
                    
                logic45:
                    cmp [di], 88
                    jne logic47
                    cmp [di+1], 88
                    jne logic46
                    cmp [di+2], 0
                    jne logic46
                    mov [di+2], 79
                    jmp reload
                
                logic46:
                    cmp [di+2], 88
                    jne logic47
                    cmp [di+1], 0
                    jne logic47
                    mov [di+1], 79
                    jmp reload    
                    
                logic47:
                    cmp [di+2], 88
                    jne logic49
                    cmp [si+2], 88
                    jne logic48
                    cmp [bx+2], 0
                    jne logic48
                    mov [bx+2], 79
                    jmp reload
                
                logic48:
                    cmp [di+1], 88
                    jne logic49
                    cmp [di], 0
                    jne logic49
                    mov [di], 79
                    jmp reload    
                    
                logic49:
                    cmp [bx], 0
                    jne logic50
                    mov [bx], 79
                    jmp reload    
                    
                logic50:
                    cmp [bx+2], 0
                    jne logic51
                    mov [bx+2], 79
                    jmp reload    
                    
                logic51:
                    cmp [di], 0
                    jne logic52
                    mov [di], 79
                    jmp reload    
                    
                logic52:
                    cmp [di+2], 0
                    jne logic53
                    mov [di+2], 79
                    jmp reload    
                    
                logic53:
                    cmp [si+1], 0
                    jne logic54
                    mov [si+1], 79
                    jmp reload
                    
                logic54:
                    cmp [bx+1], 0
                    jne logic55
                    mov [bx+1], 79
                    jmp reload    
                    
                logic55:
                    cmp [si], 0
                    jne logic56
                    mov [si], 79
                    jmp reload    
                        
                logic56:
                    cmp [si+2], 0
                    jne logic57
                    mov [si+2], 79
                    jmp reload
                    
                logic57:
                    cmp [di+1], 0
                    jne reload
                    mov [di+1], 79
                     
            
                reload:
                    mov si, offset r1
                    mov di, offset line1                
                    mov cx, 3
                    round11:
                        cmp [si], 78
                        jl jumpto1
                        mov dl, [si]
                        mov [di], dl 
                        jumpto1:
                            add si, 1
                            add di, 2
                        loop round11
                    
                    mov si, offset r2
                    mov di, offset line2                
                    mov cx, 3
                    round12:
                        cmp [si], 78
                        jl jumpto2            
                        mov dl, [si]
                        mov [di], dl
                        jumpto2: 
                            add si, 1
                            add di, 2
                        loop round12
                    
                    mov si, offset r3
                    mov di, offset line3                
                    mov cx, 3
                    round13:
                        cmp [si], 78
                        jl jumpto3
                        mov dl, [si]
                        mov [di], dl 
                        jumpto3:
                            add si, 1
                            add di, 2
                        loop round13
                        
                    ;draw check
                    add num, 1
                    cmp num, 9
                    jge draw2
                
                goprint2:                                    
                    jmp print2 
                                
                comwin:
                    mov player, 79
                    
                    mov si, offset r1
                    mov di, offset line1                
                    mov cx, 3
                    round14:
                        cmp [si], 78
                        jl jumpto4
                        mov dl, [si]
                        mov [di], dl 
                        jumpto4:
                            add si, 1
                            add di, 2
                        loop round14
                    
                    mov si, offset r2
                    mov di, offset line2                
                    mov cx, 3
                    round15:
                        cmp [si], 78
                        jl jumpto5            
                        mov dl, [si]
                        mov [di], dl
                        jumpto5: 
                            add si, 1
                            add di, 2
                        loop round15
                    
                    mov si, offset r3
                    mov di, offset line3                
                    mov cx, 3
                    round16:
                        cmp [si], 78
                        jl jumpto6
                        mov dl, [si]
                        mov [di], dl 
                        jumpto6:
                            add si, 1
                            add di, 2
                        loop round16

                    jmp win2                     
            draw2:
                mov ah, 9
                lea dx, nline
                int 21h
                lea dx, nline
                int 21h
                lea dx, msgdraw
                int 21h
                jmp result2
         
            win2:
                mov ah, 9
                lea dx, nline
                int 21h
                lea dx, nline
                int 21h
                cmp player, 79
                je player3
                cmp player, 88
                je player4
        
                player3:
                    mov ah, 9
                    lea dx, nline
                    int 21h
                    lea dx, winer4
                    int 21h
                    lea dx, nline
                    int 21h
                    jmp result2
                     
                player4:
                    mov ah, 9
                    lea dx, nline
                    int 21h
                    lea dx, winer3
                    int 21h
                    lea dx, nline
                    int 21h        
            
            result2:
                mov ah, 9
                lea dx, nline
                int 21h
                    
                mov ah, 2
                mov cx, 5
                mov si, offset line1
                round8:
                    mov dl, [si]
                    int 21h
                    add si, 1
                    loop round8 
                mov ah, 9
                lea dx, nline
                int 21h
                lea dx, mline
                int 21h 
                
                mov ah, 2
                mov cx, 5
                mov si, offset line2
                round9:    
                    mov dl, [si]
                    int 21h
                    add si, 1
                    loop round9 
                mov ah, 9
                lea dx, nline
                int 21h
                lea dx, mline
                int 21h
                
                mov ah, 2
                mov cx, 5
                mov si, offset line3
                round10:
                    mov dl, [si]
                    int 21h
                    add si, 1
                    loop round10 
                mov ah, 9
                lea dx, nline
                int 21h
                lea dx, msgend
                int 21h                
        
    finishing:
     
    ret
    main endp
end main