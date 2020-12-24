
#include <iostream>
#include <chrono>
#include <vector>

int main(int argc, char* argv[])
{

  int number=atoi(argv[1]);

{
  auto start = std::chrono::system_clock::now();

  std::vector<int> vOne;
  vOne.reserve(number);

  for (int i=0; i < number; i++)
    vOne.push_back(i);

  auto end = std::chrono::system_clock::now();

  std::chrono::duration<double> elapsed_seconds = end-start;
  std::time_t end_time = std::chrono::system_clock::to_time_t(end);

  std::cout << "Time with reserved: " << elapsed_seconds.count() << "s\n";

}
{
  auto start = std::chrono::system_clock::now();

  std::vector<int> vTwo;
  for (int i=0; i < number; i++)
    vTwo.push_back(i);

  auto end = std::chrono::system_clock::now();

  std::chrono::duration<double> elapsed_seconds = end-start;
  std::time_t end_time = std::chrono::system_clock::to_time_t(end);

  std::cout << "Time without reserved: " << elapsed_seconds.count() << "s\n";
}

}
