#include <iostream>
#include <string>
using namespace std;

class Painting {
    protected:
        string title;
        string artist;
        int value;
    public:
        Painting();
        Painting(string, string);
        void showPainting();
        void setData();
        string getArtist();
        string getTitle();
};

Painting::Painting() {
}

Painting::Painting(string title, string artist) : title(title), artist(artist) {
    value = 400;
}

void Painting::setData() {
    cout << "Enter painting's title ";
    cin >> title;
    cout << "Enter artist ";
    cin >> artist;
    value = 400;
}

void Painting::showPainting() {
    cout << title << " by " << artist << " value $" << value << endl;
}

string Painting::getArtist() {
    return artist;
}

string Painting::getTitle() {
    return title;
}

// Derived class. FamousPainting inherits Painting.
// Default class inheritance is private.
// Here it is set to public so that an array that holds objects of type Painting can also hold objects of type FamousPainting.
class FamousPainting : public Painting {
    public:
        FamousPainting(string title, string artist);
};

FamousPainting::FamousPainting(string title, string artist) : Painting(title, artist) {
    value = 25000;
}

bool isPaintingFamous(Painting painting) {
    string artists[] = {"Degas", "Monet", "Picasso", "Rembrandt"};

    for (int i = 0; i < 4; ++i) {
        if (painting.getArtist() == artists[i]) {
            return true;
        }
    }
    return false;
}

int main() {
    Painting paintings[4]; // Array can hold both Painting and FamousPainting objects
    int i;

    for (i = 0; i < 4; ++i) {
        Painting painting;
        painting.setData();

        if (isPaintingFamous(painting)) {
            FamousPainting famousPainting(painting.getTitle(), painting.getArtist());
            paintings[i] = famousPainting;
        }
        else {
            paintings[i] = painting;
        }
    }

    for (i = 0; i < 4; ++i) {
        paintings[i].showPainting();
    }

    return 0;
}
