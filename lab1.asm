.section .data
.section .text
.globl _start

_start:



  # Assignment solutions here
  mov $10, %rax
  mov %rax, %r10

loop_sum:
  sub $1, %r10
  cmp $0, %r10
  jle end_sum
  add %r10, %rax
  jmp loop_sum

end_sum:
  call print_rax



  mov $10, %rax
  mov %rax, %r10

loop_product:
  sub $1, %r10
  cmp $0, %r10
  jle end_loop
  mul %r10
  jmp loop_product

end_loop:
  call print_rax



  mov $2000000000, %rax
  mov %rax, %r12
  mov $0, %r10
  mov $0, %r11
  jmp loop_more_sum

loop_more_sum_add:
  add %r10, %r11

loop_more_sum:
  add $1, %r10
  cmp %r12, %r10
  jg end_more_sum

  mov $0, %rdx
  mov %r10, %rax

  mov $3, %r13
  div %r13
  cmp $0, %rdx
  je loop_more_sum_add

  mov $0, %rdx
  mov %r10, %rax

  mov $5, %r13
  div %r13
  cmp $0, %rdx
  je loop_more_sum_add
  jmp loop_more_sum

end_more_sum:
  mov %r11, %rax

  call print_rax          # to print the RAX register

  # Syscall calling sys_exit
  mov $60, %rax            # rax: int syscall number
  mov $0, %rdi             # rdi: int error code
  syscall


.type print_rax, @function
print_rax:
  /* Prints the contents of rax. */

  push  %rbp
  mov   %rsp, %rbp        # function prolog
  
  push  %rax              # saving the registers on the stack
  push  %rcx
  push  %rdx
  push  %rdi
  push  %rsi
  push  %r9

  mov   $6, %r9           # we always print the 6 characters "RAX: \n"
  push  $10               # put '\n' on the stack
  
  loop1:
  mov   $0, %rdx
  mov   $10, %rcx
  idiv  %rcx              # idiv alwas divides rdx:rax/operand
                          # result is in rax, remainder in rdx
  add   $48, %rdx         # add 48 to remainder to get corresponding ASCII
  push  %rdx              # save our first ASCII sign on the stack
  inc   %r9               # counter
  cmp   $0, %rax   
  jne   loop1             # loop until rax = 0
  
  mov   $0x20, %rax       # ' '
  push  %rax
  mov   $0x3a, %rax       # ':'
  push  %rax
  mov   $0x58, %rax       # 'X'
  push  %rax
  mov   $0x41, %rax       # 'A"
  push  %rax
  mov   $0x52, %rax       # 'R'
  push  %rax

  print_loop:
  mov   $1, %rax          # Here we make a syscall. 1 in rax designates a sys_write
  mov   $1, %rdi          # rdx: int file descriptor (1 is stdout)
  mov   %rsp, %rsi        # rsi: char* buffer (rsp points to the current char to write)
  mov   $1, %rdx          # rdx: size_t count (we write one char at a time)
  syscall                 # instruction making the syscall
  add   $8, %rsp          # set stack pointer to next char
  dec   %r9
  jne   print_loop

  pop   %r9               # restoring the registers
  pop   %rsi
  pop   %rdi
  pop   %rdx
  pop   %rcx
  pop   %rax

  mov   %rbp, %rsp        # function Epilog
  pop   %rbp
  ret
