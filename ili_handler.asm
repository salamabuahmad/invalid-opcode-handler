.globl my_ili_handler

.text
.align 4, 0x90
my_ili_handler:
  
  push %rsi
  push %rax
  push %rcx
  push %rdx

  movq 32(%rsp), %rax
  movq (%rax), %rax
  cmpb $0x0F, %al
  jne ONE_BYTE_HW3

  mov $2, %cl
  movb %ah, %al
  jmp SKIP_HW3

ONE_BYTE_HW3:
  
  mov $1, %cl
SKIP_HW3:
  movzbq %al, %rdi
  push %rcx
  call what_to_do
  pop %rcx


  test %rax, %rax
  jne SKIP_FAULT_HW3
  pop %rdx
  pop %rcx
  pop %rax
  pop %rsi

  jmp *old_ili_handler
  jmp END_HW3

SKIP_FAULT_HW3:
  movq %rax, %rdi
  
  mov 32(%rsp), %rsi
  movzbq %cl, %rcx
  add %rcx, %rsi
  mov %rsi, 32(%rsp)

  pop %rdx
  pop %rcx
  pop %rax
  pop %rsi


END_HW3:
  iretq
