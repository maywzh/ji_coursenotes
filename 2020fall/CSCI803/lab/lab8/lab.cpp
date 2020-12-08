#include <iostream>
#include <vector>
#include <string>
using namespace std;

long long compute_hash(string const &s, int begin, int end)
{
    // [begin..end)
    const int p = 31;
    const int m = 1e9 + 9;
    long long hash_v = 0;
    long long p_pow = 1;
    for (int i = begin; i < end; i++)
    {
        char c = s.at(i);
        hash_v = (hash_v + (c - 'a' + 1) * p_pow) % m;
        p_pow = (p_pow * p) % m;
    }
    return hash_v;
}

string solution(string const &s)
{
    int s_len = s.size();
    bool has_ans = false;
    string ans;
    // the length of the substring
    for (int i = 1; i <= s_len - 2; i++)
    {
        long long hash_prefix = compute_hash(s, 0, i);
        long long hash_suffix = compute_hash(s, s_len - i, s_len);
        if (hash_prefix == hash_suffix)
        {
            // the begin of the obelix string
            for (int j = 1; j + i < s_len; j++)
            {
                long long hash_obelix = compute_hash(s, j, j + i);
                if (hash_obelix == hash_prefix)
                {
                    has_ans = true;
                    ans = s.substr(0, i);
                }
            }
        }
    }
    if (!has_ans)
    {
        return "Just a legend";
    }
    else
    {
        return ans;
    }
}

int main()
{
    cout << "Input the s: ";
    string s;
    cin >> s;
    string ans = solution(s);
    cout << ans << endl;
    return 0;
}
