/*
 * =====================================================================================
 *       Filename : forest.cpp
 *    Description : 
 *    Version     : 
 *        Created : 01/13/15 10:36
 *         Author : Liu Xue Yang (LXY), liuxueyang457@163.com
 *         Motto  : Suicide is Painless
 * =====================================================================================
 */
#include <stdio.h>
int n, k, ind[66000], x[66000];
int q[66000], head, tail;
int main() {
  scanf("%d", &n);
  for (int i = 0; i < n; i++) {
    scanf("%d%d", &ind[i], &x[i]);
    k += ind[i]; if (ind[i] == 1) q[++tail] = i;
  }
  printf("%d\n", k / 2);
  while (head < tail) {
    int u = q[++head], v = x[u];
    if (!ind[u]) continue;
    printf("%d %d\n", u, v);
    x[v] ^= u; ind[u]--; x[u] ^= v;
    if (--ind[v] == 1) q[++tail] = v;
  }
  return 0;
}

