/*
This method of a private constructor uses a friend class.
Another method is to use the Singleton design pattern.
*/
#include <iostream>
#include <string>
using namespace std;

class Apple {
    friend class Tree;

    public:
        void print() { cout << "Apple weight: " << weight << endl; }

    private:
        Apple(int weight) : weight(weight) {
            cout << "Apple constructor called." << endl;
        }

        int weight;
};

class Tree {
    public:
        Tree(int height);
        void print() { cout << "Tree height: " << height << endl; }
    private:
        int height;
};

Tree::Tree(int height) : height(height) {
    cout << "Tree constructor called." << endl;
    Apple apple(2);
    apple.print();
}

int main() {
    Tree tree(10);
    tree.print();

    return 0;
}
