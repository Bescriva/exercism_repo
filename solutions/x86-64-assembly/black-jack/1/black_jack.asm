
C2 equ 2
C3 equ 3
C4 equ 4
C5 equ 5
C6 equ 6
C7 equ 7
C8 equ 8
C9 equ 9
C10 equ 10
CJ equ 11
CQ equ 12
CK equ 13
CA equ 14

TRUE equ 1
FALSE equ 0

section .text

global value_of_card
value_of_card:
    ; This function takes as parameter a number representing a card
    ; The function should return the numerical value of the passed-in card
    mov rax, rdi
    cmp rax, CA
    je its_ace

    cmp rax, C10
    jg is_face
    ret

    is_face:
    mov rax, 10
    ret

    its_ace:
    mov rax, 1
    ret

global higher_card
higher_card:
    ; This function takes as parameters two numbers each representing a card
    ; The function should return which card has the higher value
    ; If both have the same value, both should be returned
    ; If one is higher, the second one should be 0
    push rdi
    push rsi
    call value_of_card
    mov r8, rax
    mov rdi, rsi
    call value_of_card
    pop rsi
    pop rdi
    
    cmp r8, rax
    jb is_less
    je is_equal
    
    mov rax, rdi
    mov rdx, 0
    ret
    
    is_less:
    mov rax, rsi
    mov rdx, 0
    ret

    is_equal:
    mov rax, rdi
    mov rdx, rsi
    ret

global value_of_ace
value_of_ace:
    ; This function takes as parameters two numbers each representing a card
    ; The function should return the value of an upcoming ace
    call value_of_card
    mov r8, rax
    mov rdi, rsi
    call value_of_card
    
    cmp r8, 1
    je one
    cmp rax, 1
    je one
    
    add rax, r8
    cmp rax, 10
    jbe eleven

    one:
    mov rax, 1
    ret

    eleven:
    mov rax, 11
    ret

global is_blackjack
is_blackjack:
    ; This function takes as parameters two numbers each representing a card
    ; The function should return TRUE if the two cards form a blackjack, and FALSE otherwise
    mov rax, 0
    
    cmp rdi, CA
    je is_ace
    cmp rdi, C10
    jge is_ten
    ret

    is_ace:
    cmp rsi, CA
    je two_aces
    cmp rsi, C10
    jge blackjack
    ret

    is_ten:
    cmp rsi, CA
    je blackjack
    ret

    two_aces:
    ret

    blackjack:
    mov rax, 1
    ret

global can_split_pairs
can_split_pairs:
    ; This function takes as parameters two numbers each representing a card
    ; The function should return TRUE if the two cards can be split into two pairs, and FALSE otherwise
    call value_of_card
    mov r8, rax
    mov rdi, rsi
    call value_of_card

    cmp r8, rax
    je can_split
    mov rax, 0
    ret

    can_split:
    mov rax, 1
    ret

global can_double_down
can_double_down:
    ; This function takes as parameters two numbers each representing a card
    ; The function should return TRUE if the two cards form a hand that can be doubled down, and FALSE otherwise
    call value_of_card
    mov r8, rax
    mov rdi, rsi
    call value_of_card
    add rax, r8

    cmp rax, 9
    jb cannot_double
    cmp rax, 11
    jg cannot_double
    mov rax, 1
    ret

    cannot_double:
    mov rax, 0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
