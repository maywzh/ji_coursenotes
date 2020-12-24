#include <iostream>
#include <list>
#include <algorithm>
#include <string>
#include <random>
#include <iterator>
using namespace std;

int main() {
    list<int> list1, list2;

    list1.push_back(3);
    list1.push_back(13);
    list1.push_back(23);
    list1.push_back(15);
    list1.push_back(9);
    list1.push_back(13);
    list1.push_back(12);
    list1.push_back(33);

    list2.push_back(1);
    list2.push_back(2);
    list2.push_back(3);
    list2.push_back(4);
    list2.push_back(5);
    list2.push_back(6);
    list2.push_back(7);
    list2.push_back(8);

    // https://en.cppreference.com/w/cpp/algorithm/sort
    cout << "\nsort(): sorts a range into ascending order" << endl;
    list1.sort();
    for (auto it = list1.begin(); it != list1.end(); ++it) {
        cout << *it << " ";
    }
    cout << endl;

    // https://en.cppreference.com/w/cpp/algorithm/merge
    cout << "\nmerge(): merges two sorted ranges" << endl;
    list2.merge(list1);
    for (auto it = list2.begin(); it != list2.end(); ++it) {
        cout << *it << " ";
    }
    cout << endl;

    // https://en.cppreference.com/w/cpp/algorithm/partial_sum
    cout << "\npartial_sum(): computes the partial sum of a range of elements" << endl;
    int val[] = {10, 20, 30, 40, 50};
    std::cout << "Elements: ";
    for (int i = 0; i < 5; i++) { std::cout << val[i] << " "; }
    std::cout << endl;
    int result[5];
    std::partial_sum(val, val + 5, result);
    std::cout << "Partial sum: ";
    for (int i = 0; i < 5; i++) { std::cout << result[i] << " "; }
    cout << endl;

    // https://en.cppreference.com/w/cpp/algorithm/random_shuffle
    cout << "\nshuffle(): randomly re-orders elements in a range" << endl;
    std::vector<int> v = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    std::random_device rd;
    std::mt19937 g(rd());
    std::shuffle(v.begin(), v.end(), g);
    std::copy(v.begin(), v.end(), std::ostream_iterator<int>(std::cout, " "));
    cout << endl;

    // https://en.cppreference.com/w/cpp/algorithm/next_permutation
    cout << "\nnext_permutation(): generates the next greater lexicographic permutation of a range of elements" << endl;
    std::string s = "0011";
    std::sort(s.begin(), s.end());
    do {
        std::cout << s << '\n';
    }
    while(std::next_permutation(s.begin(), s.end()));
}

/*

sort(): sorts a range into ascending order
3 9 12 13 13 15 23 33

merge(): merges two sorted ranges
1 2 3 3 4 5 6 7 8 9 12 13 13 15 23 33

partial_sum(): computes the partial sum of a range of elements
Elements: 10 20 30 40 50
Partial sum: 10 30 60 100 150

shuffle(): randomly re-orders elements in a range
6 4 3 2 9 1 8 5 7 10

next_permutation(): generates the next greater lexicographic permutation of a range of elements
0011
0101
0110
1001
1010
1100

*/
