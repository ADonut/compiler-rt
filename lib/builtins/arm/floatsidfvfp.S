//===-- floatsidfvfp.S - Implement floatsidfvfp ---------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is dual licensed under the MIT and the University of Illinois Open
// Source Licenses. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "../assembly.h"

//
// extern double __floatsidfvfp(int a);
//
// Converts a 32-bit int to a double precision float.
// Uses Darwin calling convention where a double precision result is 
// return in GPR register pair.
//
	.syntax unified
	.p2align 2
DEFINE_COMPILERRT_FUNCTION(__floatsidfvfp)
	vmov	s15, r0        // move int to float register s15
	vcvt.f64.s32 d7, s15   // convert 32-bit int in s15 to double in d7
	vmov	r0, r1, d7     // move d7 to result register pair r0/r1
	bx	lr
END_COMPILERRT_FUNCTION(__floatsidfvfp)
