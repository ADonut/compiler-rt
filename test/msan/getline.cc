// RUN: %clangxx_msan -O0 %s -o %t && %run %t %p
// RUN: %clangxx_msan -O2 %s -o %t && %run %t %p
// RUN: %clang_msan -O0 -xc %s -o %t && %run %t %p
// RUN: %clang_msan -O2 -xc %s -o %t && %run %t %p
// RUN: %clang_msan -O0 -xc -D_GNU_SOURCE=1 %s -o %t && %run %t %p
// RUN: %clang_msan -O2 -xc -D_GNU_SOURCE=1 %s -o %t && %run %t %p

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv) {
  assert(argc == 2);
  char buf[1024];
  snprintf(buf, sizeof(buf), "%s/%s", argv[1], "getline_test_data");

  FILE *fp = fopen(buf, "r");
  assert(fp);

  char *line = 0;
  size_t len = 0;
  int n = getline(&line, &len, fp);
  assert(n == 6);
  assert(strcmp(line, "abcde\n") == 0);

  n = getline(&line, &len, fp);
  assert(n == 6);
  assert(strcmp(line, "12345\n") == 0);
  
  free(line);
  fclose(fp);

  return 0;
}
