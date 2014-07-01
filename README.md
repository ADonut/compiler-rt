Compiler-RT
================================

This directory and its subdirectories contain source code for the compiler
support routines.

Compiler-RT is open source software. You may freely distribute it under the
terms of the license agreement found in LICENSE.txt.

================================
Quick and dirty port to vectorproc arch. In-tree builds don't seem to support
 crosscompilation. Build it outside the main LLVM checkout.

Run make with "CC=<llvm-vectorproc-install>/bin/clang" appended to the command line.

Compile builtin library for vectorproc:
`$> make clang_vectorproc -j4 CC=<llvm-vectorproc-install>/bin/clang
`
Static library is available under clang_vectorproc/builtins/vectorproc/

It is a static library and it's missing references to external functions. The
error function abort() is not present and is referenced by multiple 
functions (like divisions) that might fail. If your program doesn't reference
an unlinkable function it will work. 

Currently missing:

```
jon:~/git/compiler-rt/clang_vectorproc/builtins-vectorproc/vectorproc/SubDir.lib__builtins$ /usr/local/llvm-vectorproc/bin/clang *.o

Undefined symbol: enable_execute_stack.o: sysconf
Undefined symbol: divsc3.o: fmaxf
Undefined symbol: divxc3.o: fmaxl
Undefined symbol: divsc3.o: scalbnf
Undefined symbol: divxc3.o: scalbnl
Undefined symbol: divdc3.o: fmax
Undefined symbol: mulxc3.o: fabsl
Undefined symbol: int_util.o: abort
Undefined symbol: atomic.o: memcmp
Undefined symbol: gcc_personality_v0.o: _Unwind_GetRegionStart
Undefined symbol: muldc3.o: fabs
Undefined symbol: eprintf.o: fflush
Undefined symbol: <command line option -e>: _start
Undefined symbol: mulsc3.o: fabsf
Undefined symbol: divdc3.o: scalbn
Undefined symbol: eprintf.o: stderr
Undefined symbol: gcc_personality_v0.o: _Unwind_SetGR
Undefined symbol: gcc_personality_v0.o: _Unwind_GetLanguageSpecificData
Undefined symbol: divsc3.o: logbf
Undefined symbol: enable_execute_stack.o: mprotect
Undefined symbol: divxc3.o: logbl
Undefined symbol: divdc3.o: logb
Undefined symbol: atomic.o: memcpy
Undefined symbol: gcc_personality_v0.o: _Unwind_GetIP
Undefined symbol: eprintf.o: fprintf
Undefined symbol: gcc_personality_v0.o: _Unwind_SetIP
Undefined symbol: atomic.o: __atomic_is_lock_free
symbol(s) not found
clang-3.5: error: VectorProc-ld command failed with exit code 1 (use -v to see invocation)

jon:~/git/compiler-rt/clang_vectorproc/builtins-vectorproc/vectorproc/SubDir.lib__builtins$
````

TODO:
- memcpy/memset from gpgpu/firmware/3D-renderer/utils.cpp
- just nop abort(), or make it a simulator-only trap.

