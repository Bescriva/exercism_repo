; Everything that comes after a semicolon (;) is a comment

WEIGHT_OF_EMPTY_BOX equ 500
TRUCK_HEIGHT equ 300
PAY_PER_BOX equ 5
PAY_PER_TRUCK_TRIP equ 220

section .text

global get_box_weight
get_box_weight:
    ; This function takes the following parameters:
    ; - The number of items for the first product in the box, as a 16-bit non-negative integer
    ; - The weight of each item of the first product, in grams, as a 16-bit non-negative integer
    ; - The number of items for the second product in the box, as a 16-bit non-negative integer
    ; - The weight of each item of the second product, in grams, as a 16-bit non-negative integer
    ; The function must return the total weight of a box, in grams, as a 32-bit non-negative integer
    movzx eax, di
    imul eax, esi
    movzx ebx, dx
    imul ebx, ecx
    add eax, ebx
    add eax, WEIGHT_OF_EMPTY_BOX
    ret

global max_number_of_boxes
max_number_of_boxes:
    ; This function takes the following parameter:
    ; - The height of the box, in centimeters, as a 8-bit non-negative integer
    ; The function must return how many boxes can be stacked vertically, as a 8-bit non-negative integer
    mov ax, TRUCK_HEIGHT
    mov bl, dil
    div bl
    ret

global items_to_be_moved
items_to_be_moved:
    ; This function takes the following parameters:
    ; - The number of items still unaccounted for a product, as a 32-bit non-negative integer
    ; - The number of items for the product in a box, as a 32-bit non-negative integer
    ; The function must return how many items remain to be moved, after counting those in the box, as a 32-bit integer
    mov eax, edi
    sub eax, esi
    ret

global calculate_payment
calculate_payment:
    ; This function takes the following parameters:
    ; - The upfront payment, as a 64-bit non-negative integer
    ; - The total number of boxes moved, as a 32-bit non-negative integer
    ; - The number of truck trips made, as a 32-bit non-negative integer
    ; - The number of lost items, as a 32-bit non-negative integer
    ; - The value of each lost item, as a 64-bit non-negative integer
    ; - The number of other workers to split the payment/debt with you, as a 8-bit positive integer
    ; The function must return how much you should be paid, or pay, at the end, as a 64-bit integer (possibly negative)
    ; Remember that you get your share and also the remainder of the division
    mov r15, rdi
    
    mov rax, 0
    movsxd rbx, esi
    imul rbx, 5
    add rax, rbx
    
    movsxd rbx, edx
    imul rbx, 220
    add rax, rbx
    
    movsxd rbx, ecx
    mov rcx, r8
    imul rbx, rcx
    sub rax, rbx

    sub rax, r15
    
    movzx rbx, r9b
    add rbx, 1
    cqo
    idiv rbx
    add rax, rdx

    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
