# Invalid Opcode Exception Handler

## Overview

This project implements a Linux kernel module that replaces the default x86 Invalid Opcode exception handler with a custom handler.

The module installs a custom handler for interrupt vector `0x06`, which corresponds to the Invalid Opcode exception. When an invalid instruction is executed, the assembly handler reads the opcode, calls a C helper function to decide how to handle it, and either skips the invalid instruction or forwards execution to the original kernel handler.

This project was created as part of a Computer Organization and Programming course.

## Features

* Linux kernel module
* Custom Invalid Opcode exception handler
* Interrupt Descriptor Table inspection and modification
* Saving and restoring the original IDT
* Assembly-level exception handling
* C and assembly integration
* Test programs that intentionally trigger invalid opcodes
* QEMU / virtual machine testing workflow

## Technologies Used

* C
* x86-64 Assembly
* Linux Kernel Modules
* Makefile
* QEMU
* Low-level systems programming
* Interrupt and exception handling

## Project Files

* `ili_main.c` - kernel module setup and cleanup
* `ili_utils.c` - helper functions for reading/loading the IDT and modifying gate descriptors
* `ili_handler.asm` - custom assembly invalid-opcode handler
* `Makefile` - builds the kernel module and test programs
* `inst_test.asm` - test program containing a one-byte invalid instruction
* `inst_test_2.asm` - test program containing a two-byte invalid instruction
* `initial_setup.sh` - installs required Linux headers and tools
* `compile.sh` - builds the module and copies artifacts into the VM filesystem
* `start.sh` - starts the QEMU testing environment

## How It Works

1. The kernel module reads and stores the current IDT register.
2. It saves the original Invalid Opcode handler address.
3. It creates a modified IDT.
4. It replaces the Invalid Opcode handler entry with the custom handler.
5. When an invalid opcode occurs, the assembly handler reads the instruction.
6. The handler calls a C function to decide whether the opcode should be handled.
7. If the opcode is handled, the instruction pointer is advanced.
8. If the opcode is not handled, execution is forwarded to the original kernel handler.
9. When the module is unloaded, the original IDT is restored.

## Safety Warning

This project modifies low-level kernel exception handling and should only be run inside a virtual machine.

Do not run this directly on your main operating system.

## What I Learned

* How CPU exceptions are represented in the Interrupt Descriptor Table
* How Linux kernel modules can modify low-level CPU structures
* How C and assembly interact in kernel-level code
* How exception handlers preserve registers and return with `iretq`
* How invalid instructions can be tested intentionally
* Why low-level systems programming is powerful, fragile, and extremely unforgiving
