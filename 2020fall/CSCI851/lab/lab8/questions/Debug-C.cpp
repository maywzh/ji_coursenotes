#include<iostream>
#include<string>
using namespace std;
class Painting
{
   protected:
      string title;
      char artist;
      int value;
   public:
       Painting(string, string = " ");
       void showPainting();
       void setData();
       int getArtist();
};
Painting::Painting(string name, painter)
{
    name = title;
    artist = painter;
    value = 400;
}
void Painting:setData()
{
     cout<<"Enter painting's title ";
     cin>>artist;
     cout<<"Enter artist ";
     cin>>name;
     value = 40;
}
void Painting::showPaint.show()
{
   cout<<title <<artist<<" value $40";
}
int Painting::getArtist()
{
  return 0;
}
string Painting::getTitle()
{
  return title;
}
class FamousPainting public
{
 public:
   FamousPainting(string, string);
}

FamousPainting::FamousPainting(string name, string painter) :
   Painting(name, painter)
{
   value = 25;
}
bool isPaintingFamous(Painting p)
{
  bool isFamous = true;
  const int NUM = 4;
  string artists[NUM] = {"Degas","Monet","Picasso","Rembrandt"};
  char x;
  for(x = 0; x <= NUM; ++x)
    if(p.getArtist() = artists(x))
       isFamous = false;
  return isFamous;
}
int main()
{
    const int NUM = 6;
    Painting pictures[NUM];
    int x;
    for(x = 0; x<NUM; ++x)
    {
        Painting temp;
        temp.setData();
        if(isPaintingFamous(temp))
        {
          FamousPainting tempF(temp.getTitle(), temp.getArtist());
          temp = tempF;
        }
       pictures = temp;
    }
    for(x = 0; x< NUM; x--)
      pictures.show();
}
