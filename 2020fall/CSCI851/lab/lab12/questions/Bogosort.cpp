// From http://en.wikibooks.org/wiki/Algorithm_Implementation/Sorting/Bogosort

 #include <iostream>
 #include <ctime>
 #include <cstdlib>
 #include <vector>
 #include <algorithm>
 #include <iterator>
 
 using namespace std;
 static const int NUM = 4;
 
 bool IsInOrder(const vector<int>& x)
 {
        return adjacent_find(x.begin(), x.end(), greater<int>()) == x.end();
 }
 
 int main()
 {
        int counter = 0;
        srand(time(0));
        vector<int> bogo;
 
        // Initiate the vector with NUM random numbers
        generate_n(back_inserter(bogo), NUM, rand);
 
        // Bogosort
        while(!IsInOrder(bogo))
        {
                random_shuffle(bogo.begin(), bogo.end());
                copy(bogo.begin(), bogo.end(), ostream_iterator<int>(cout, " "));
                cout << "\n";
                counter++;
        }
        cout << "Sorting took " << counter << " tries." << endl;
 }
