// 2016/07/22 19:58:12 PM
// Sabastian

#include <iostream>
#include <stdio.h>
#include <string.h>

using namespace std;

typedef long long ll;

typedef struct TreeNode {
  int start, end;
  ll total;
  ll lazy;
} TreeNode;

TreeNode tree[4 * 100000 + 10];
ll a[4 * 100000 + 10];

void printNode(int stIndex) {
  TreeNode &t = tree[stIndex];
  printf("(%d, %d), lazy=%lld, total=%lld\n",
         t.start, t.end, t.lazy, t.total);
}

void build(int stIndex, int start, int end) {
  tree[stIndex].start = start;
  tree[stIndex].end = end;
  tree[stIndex].lazy = 0;

  if (start == end) {
    tree[stIndex].total = a[start];
    return;
  }

  int mid = (start + end) / 2, leftChildIndex = stIndex * 2,
    rightChildIndex = leftChildIndex + 1;
  build(leftChildIndex, start, mid);
  build(rightChildIndex, mid + 1, end);
  tree[stIndex].total = tree[leftChildIndex].total +
    tree[rightChildIndex].total;
}

void UpdateNode(int stIndex, TreeNode & t, ll value) {
  bool isLeaf = (t.start == t.end);

  t.total += (t.end - t.start + 1) * value;
  if (!isLeaf) {
    tree[stIndex * 2].lazy += value;
    tree[stIndex * 2 + 1].lazy += value;
  }
  t.lazy = 0;

  return;
}

void update(int stIndex, int start, int end) {
  TreeNode & t = tree[stIndex];

  // needs updated
  if (t.lazy) {
    UpdateNode(stIndex, t, t.lazy);
  }

  if (start > t.end || end < t.start || start > end) {
    return;
  }

  // node contain is contained in [start..end]
  if (t.start >= start && t.end <= end) {
    UpdateNode(stIndex, t);
    return;
  }

  int leftChildIndex = stIndex * 2, rightChildIndex = leftChildIndex + 1;

  update(leftChildIndex, start, end, value);
  update(rightChildIndex, start, end, value);
  t.total = tree[leftChildIndex].total + tree[rightChildIndex].total;

  return;
}

ll query(int stIndex, int start, int end) {
  TreeNode & t = tree[stIndex];

  // needs updated
  if (t.lazy) {
    UpdateNode(stIndex, t, t.lazy);
  }

  if (start > t.end || end < t.start || start > end) {
    return 0;
  }

  // node contain is contained in [start..end]
  if (t.start >= start && t.end <= end) {
    return t.total;
  }

  int leftChildIndex = stIndex * 2, rightChildIndex = leftChildIndex + 1;

  return query(leftChildIndex, start, end) +
    query(rightChildIndex, start, end);
}

int main(void) {
  #ifdef DEBUG
  freopen("input.txt", "r", stdin);
  #endif

  int N, M;

  while (cin >> N) {
    for (int i = 0; i < N; ++i) {
      cin >> a[i];
    }

    build(1, 0, N - 1);
    cin >> M;
    for (int m = 1; m <= M; ++m) {
      int i, x, y;
      cin >> i >> x >> y;
      x--; y--;
      cout << "Case #" << m << ":" << endl;
      if (i) {
        cout << query(1, x, y) << endl;
      }
      else {
        update(1, x, y);
      }
      if (m != M) {
        cout << endl;
      }
    }
  }
  return 0;
}