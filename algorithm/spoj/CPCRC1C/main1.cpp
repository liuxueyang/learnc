/*
 * =====================================================================================
 *
 *       Filename:  main1.cpp
 *
 *    Description:  http://www.spoj.com/problems/CPCRC1C/
 *
 *        Version:  1.0
 *        Created:  08/14/2016 20:39:52
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

int num_len(int n) {return floor(log10(n))+1;}
ll solve(int n) {
  if(n<=0)return 0;
  int d=num_len(n);
  if(d==1)return (1+n)*n/2;
  int p=(int)pow(10,d-1),msd=n/p;
  return solve(p-1)*msd+solve(msd-1)*p+(n%p+1)*msd+solve(n%p);
}

int main ( void )
{
#ifndef  ONLINE_JUDGE
  freopen("input.txt", "r", stdin);
#endif     /* -----  ONLINE_JUDGE  ----- */
  int a,b;while(cin>>a>>b&&(a!=-1))cout<<solve(b)-solve(a-1)<<endl;

  return EXIT_SUCCESS;
}				/* ----------  end of function main  ---------- */

