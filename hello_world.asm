.data
hello: .ascii "Hello World!\n"

.text
.globl _start
_start:
       mov $1, %rax
       mov $1, %rdi
       mov $hello,%rsi
       mov $13,%rdx
       syscall

       mov $60, %rax
       mov $0, %rdi
       syscall
