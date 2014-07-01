Description := Static runtime libraries for clang/vectorpoc.

###

# CC := /usr/local/llvm-vectorproc/bin/clang
Arch := vectorproc

SupportedArches += vectorproc
Configs := builtins-vectorproc
Arch.builtins-vectorproc = vectorproc


###

CFLAGS := -Wall -Werror -O3 -fomit-frame-pointer
SANITIZER_CFLAGS := -fPIE -fno-builtin -gline-tables-only

CFLAGS.builtins-vectorproc := $(CFLAGS) -target vectorproc

# Use our stub SDK as the sysroot to support more portable building. For now we
# just do this for the core module, because the stub SDK doesn't have
# enough support to build the sanitizers or profile runtimes.
CFLAGS.builtins-vectorproc += -idirafter $(ProjSrcRoot)/SDKs/linux/usr/include

FUNCTIONS.builtins-vectorproc := $(CommonFunctions) $(ArchFunctions.vectorproc)

# Always use optimized variants.
OPTIMIZED := 1

# We don't need to use visibility hidden on Linux.
VISIBILITY_HIDDEN := 0

SHARED_LIBRARY_SUFFIX := so
