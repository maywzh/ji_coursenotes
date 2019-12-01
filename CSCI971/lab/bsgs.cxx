#include <cstdio>
#include <algorithm>
#include <map>
#include <cmath>
using namespace std;
typedef long long ll;
map<ll, int> mp;
ll p, a, b;
ll n, m, now, ans, t;
bool flag;
ll fast_pow(ll x)
{
    ll sum = 1;
    ll aa = a;
    while (x > 0)
    {
        if (x & 1)
            sum = (sum * aa) % p;
        x = x >> 1;
        aa = (aa * aa) % p;
    }
    return sum;
}
int main()
{
    while (scanf("%lld%lld%lld", &p, &a, &b) != EOF)
    {
        if (a % p == 0)
        {
            printf("no solution\n");
            continue;
        }
        mp.clear();
        m = ceil(sqrt(p));
        flag = false;
        now = b % p; //b*a^j 当j==0时
        mp[now] = 0;
        for (int i = 1; i <= m; ++i)
        {
            now = (now * a) % p;
            mp[now] = i;
        }
        t = fast_pow(m);
        now = 1;
        for (int i = 1; i <= m; ++i) //枚举 (a^m)^i
        {
            now = (now * t) % p;
            if (mp[now])
            {
                flag = true;
                ans = i * m - mp[now];
                printf("%lld\n", (ans % p + p) % p); //printf("%lld\n",(ans%p+p)%p);
                break;
            }
        }
        if (!flag)
            printf("no solution\n");
    }
    return 0;
}