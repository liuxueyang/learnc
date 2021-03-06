/*
 * =====================================================================================
 *
 *       Filename:  main.cpp
 *
 *    Description:  把变量初始化为无穷大的时候要注意，不能随意在
 *    无穷大上面加数字，因为会溢出。
 *
 *        Version:  1.0
 *        Created:  2016/08/29 21时08分22秒
 *       Compiler:  g++
 *
 *         Author:  Sabastian (liuxueyang.github.io), read3valprintloop@gmail.com
 *
 * =====================================================================================
 */
#include <bits/stdc++.h>
using namespace std;
#define _ ios_base::sync_with_stdio(0);cin.tie(0);
#define rep(i, a, n) for (int i = a; i < n; ++i)
#define per(i, a, n) for (int i = n-1; i >= a; --i)
#define pb push_back
#define mp make_pair
#define all(x) (x).begin(),(x).end()
#define fi first
#define se second
#define SZ(x) ((int)(x).size())
typedef vector<int> VI;
typedef map<int,int> MI;
typedef long long ll;
typedef pair<int,int> PII;
const ll MOD=1000000007;
const int N=105;
ll a[N][N][N];
int n,M,K,co[N],p[N][N];

int main ( void )
{
#ifndef  ONLINE_JUDGE
  freopen("input.txt", "r", stdin);
#endif     /* -----  ONLINE_JUDGE  ----- */

  while(cin>>n>>M>>K){
    rep(i,1,n+1)cin>>co[i];

    rep(i,1,n+1){
      rep(j,1,M+1){
        cin>>p[i][j];
      }
    }

    rep(i,0,n+1)
      rep(b,0,K+1)
      rep(k,0,M+1)
      a[i][b][k]=LLONG_MAX;

    if(!co[1]){
      rep(k,1,M+1)
        a[1][1][k]=p[1][k];
    }
    else{
      a[1][1][co[1]]=0;
    }

    rep(i,2,n+1){
      rep(b,1,K+1){
        if(co[i]){
          if(LLONG_MAX!=a[i-1][b][co[i]])
            a[i][b][co[i]]=min(a[i][b][co[i]],
                a[i-1][b][co[i]]); 
          rep(k,1,M+1){                         /* pos i-1 */
            if(k!=co[i]){
              if(LLONG_MAX!=a[i-1][b-1][k]){
                a[i][b][co[i]]=min(a[i][b][co[i]],
                    a[i-1][b-1][k]);
              }
            }
          }
        }
        else{                                   /* co[i]==0 */
          rep(k,1,M+1)                          /* pos i */
          {
            /* same color */
            if(LLONG_MAX!=a[i-1][b][k])
              a[i][b][k]=min(a[i][b][k],a[i-1][b][k]+p[i][k]); 
            rep(k1,1,M+1)                       /* pos i-1 */
            {
              if(k!=k1){
                if(LLONG_MAX!=a[i-1][b-1][k1])
                  a[i][b][k]=min(a[i][b][k],a[i-1][b-1][k1]+p[i][k]);
              }
            }
          }
        }
      }
    }

    ll res=LLONG_MAX;
    rep(k,1,M+1){
      res=min(res,a[n][K][k]);
    }
    if(res<0||LLONG_MAX==res)res=-1;
    cout<<res<<endl;
  }

  return EXIT_SUCCESS;
}				/* ----------  end of function main  ---------- */

