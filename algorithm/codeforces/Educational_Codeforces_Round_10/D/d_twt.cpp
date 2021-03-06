#include <bits/stdc++.h>
using namespace std;
typedef long long ll;

const int N = 200050;
int n, m, f[N], ans[N];

struct Pair {
  int l, r, t, p;
};
struct Q {
  int x, y;
};

Pair p[N];
Q q[N];

void add(int x) {
  while (x < N) {
    f[x]++;
    x += ((~x) + 1) & x;
  }
}

int sum(int x) {
  int ret = 0;
  while (x > 0) {
    ret += f[x];
    x -= ((~x) + 1) & x;
  }
  return ret;
}

bool cmp(struct Pair a, struct Pair b) { return a.r < b.r; }
bool cmp2(struct Q a, struct Q b) { return a.x < b.x; }

int main() {
  scanf("%d", &n);
  for (int i = 1; i <= n; i++) {
    scanf("%d%d", &p[i].l, &p[i].r);
    q[i].x = p[i].l;
    q[i].y = i;
    p[i].t = i;
  }

  // 把x(也就是l)离散化，p代替原来的x
  sort(q + 1, q + n + 1, cmp2);
  for (int i = 1; i <= n; i++)
    p[q[i].y].p = i;

  sort(p + 1, p + n + 1, cmp);
  for (int i = 1; i <= n; i++) {
    ans[p[i].t] = i - 1 - sum(p[i].p);
    add(p[i].p);
  }

  for (int i = 1; i <= n; i++)
    printf("%d\n", ans[i]);
  return 0;
}
