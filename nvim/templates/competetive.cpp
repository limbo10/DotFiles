#pragma GCC optimize("-O2")
#include <bits/stdc++.h>
using namespace std;

using ll = long long;
using vi = vector<int>;
using vb = vector<bool>;
using pii = pair<int, int>;

#define endl " \n"
#define size(x) int((x).size())
#define all(a) a.begin(), a.end()
#define all_rev(a) a.rbegin(), a.rend()
const int mod = 1e9+7, inf = INT_MAX, ninf = INT_MIN;

void setIO(string name = "") {
	cin.tie(0)->sync_with_stdio(0);
	if (!name.empty()) { freopen((name+".in").c_str(), "r", stdin); freopen((name+".out").c_str(), "w", stdout); }
}

void solve(); void helper();

int main() { setIO(); solve(); return 0; }

void solve() {
    int t = 1;
    // cin >> t;
    while (t--) { helper(); }
}

void helper() {
}
