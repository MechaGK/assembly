.section .data

buffer:
    .ascii "abcdefgh"

.section .text
.globl _start

_start:
    mov $0, %rax
    mov $0, %rdi
    mov $buffer, %rsi
    mov $128, %rdx
    syscall

    mov %rax, %rdx
    mov $1, %rax
    mov $1, %rdi
    mov $buffer, %rsi
    syscall

    mov $60, %rax
    mov $0, %rdi
    syscall

.type get_string_length, @function
get_string_length:
  /* Dertermines the length of a zero-terminated string. Returns result in %rax.
   * %rax: Address of string.
   */
  push %rbp
  mov %rsp, %rbp

  push %rcx
  push %rbx
  push %rdx
  push %rsi
  push %r11

  xor %rdx, %rdx

  # Get string length
  lengthLoop:
    movb (%rax), %bl    # Read a byte from string
    cmp $0, %bl         # If byte == 0: end loop
  je lengthDone
    inc %rdx
    inc %rax
  jmp lengthLoop
  lengthDone:

  mov %rdx, %rax

  pop %r11
  pop %rsi
  pop %rdx
  pop %rbx
  pop %rcx

  mov %rbp, %rsp
  pop %rbp
  ret
