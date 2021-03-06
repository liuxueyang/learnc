#include <cstring>
#include <iostream>
#include <algorithm>
#include <cstdio>
#include <queue>
#include <cmath>
#define rep(i, l, r) for (int i = l; i <= r; i++)
#define down(i, l, r) for (int i = l; i >= r; i--)
#define clr(x, y) memset(x, y, sizeof(x))
#define maxn 200500
#define inf 1000000000
using namespace std;
int b[maxn], a[maxn], q[maxn], tot, n, ans;
int read() {
  int x = 0, f = 1;
  char ch = getchar();
  while (!isdigit(ch)) {
    if (ch == '-') f = -1;
    ch = getchar();
  }
  while (isdigit(ch)) {
    x = x * 10 + ch - '0';
    ch = getchar();
  }
  return x * f;
}
bool jud(int i) {
  if (i < 1 || i == n) return 1;                /* i == n return 1!!! */
  if ((i & 1) && (a[i] < a[i + 1])) return 1;
  if (!(i & 1) && (a[i] > a[i + 1])) return 1;
  return 0;
}
int main() {
#ifndef ONLINE_JUDGE
  freopen("3", "r", stdin);
#endif /* -----  ONLINE_JUDGE  ----- */
  n = read();
  rep(i, 1, n) a[i] = read();
  rep(i, 1, n) if (!jud(i)) b[i] = b[i + 1] = 1;/* b[i] == 1 if `i` is a bad index */
  rep(i, 1, n) if (b[i]) q[++tot] = i;          /* q[i] is bad index */

  if (tot > 6) {
    puts("0");
    return 0;
  }
  rep(i, 1, n) if (b[i]) {
    rep(j, 1, n) if (j > i || !b[j]) {
      swap(a[i], a[j]);
      if (jud(i - 1) && jud(i) && jud(j - 1) && jud(j)) {
        rep(i, 1, tot) if (!jud(q[i])) goto stop;
        ans++;
      }
    stop:
      swap(a[i], a[j]);
    }
  }
  printf("%d\n", ans);
  return 0;
}
