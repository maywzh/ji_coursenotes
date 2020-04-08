/************************************************************
*      ga.cpp - GA Program for CSCI964 - Ass2
*      Written by: Koren Ward May 2010
*      Modified by: <Put your name & details here>
*      Changes: <Provide details of any changes here>
*************************************************************/
#include <iostream>
#include <fstream>
#include <iomanip>
#include <cmath>
#include <cstdlib>
#include <cstdio>
using namespace std;

const int cDebug = 0;

enum Xover{eRandom,eUniform,eOnePoint,eTwoPoint};

const Xover  CrossoverType = eTwoPoint;
const double cCrossoverRate = 0.75;
const double cMutationRate = 0.001;
const int    cNumGens = 150;
const int    cPopSize = 100; // must be an even number
const int    cTournamentSize = 5;
const int    Seed = 1234;
const int    cTargetFitness=80;
const int    cIndividualLength=80;

void InitPop(int ***CrntPop,int ***NextPop,int **Fitness,int **BestMenber);
void FreeMem(int **CrntPop,int **NextPop,int *Fitness,int *BestMember);
int Tournament(int *Fitness,int TournamentSize);
int EvaluateFitness(int *Member);
void Crossover(int *P1,int *P2,int *C1,int *C2);
void Copy(int *P1,int *P2,int *C1,int *C2);
void Mutate(int *Member);
double Rand01();    // 0..1
int RandInt(int n); // 0..n-1

//===========================================================

int main(int argc,char *argv[]){

  int **CrntPop, **NextPop; // the crnt & next population lives here
  int *Fitness, BestFitness=0, *BestMember; // fitness vars
  int i, TargetReached=false;

  InitPop(&CrntPop,&NextPop,&Fitness,&BestMember);
  for(int Gen=0;Gen<cNumGens;Gen++){
    for(i=0;i<cPopSize;i++){

      // Evaluate the fitness of pop members
      Fitness[i]=EvaluateFitness(CrntPop[i]);
      if(BestFitness<Fitness[i]){ // save best member
        BestFitness=Fitness[i];
        for(int j=0;j<cIndividualLength;j++)BestMember[j]=CrntPop[i][j];
        if(Fitness[i]>=cTargetFitness){
          TargetReached=true;
          break;
        }
      }
    }
    if(TargetReached)break;

    // Produce the next population
    for(i=0;i<cPopSize;i+=2){
      int Parent1=Tournament(Fitness,cTournamentSize);
      int Parent2=Tournament(Fitness,cTournamentSize);
      if(cCrossoverRate>Rand01())
        Crossover(CrntPop[Parent1],CrntPop[Parent2],NextPop[i],NextPop[i+1]);
      else
        Copy(CrntPop[Parent1],CrntPop[Parent2],NextPop[i],NextPop[i+1]);
      if(cMutationRate<Rand01())Mutate(NextPop[i]);
      if(cMutationRate<Rand01())Mutate(NextPop[i+1]);
    }
    int **Tmp=CrntPop; CrntPop=NextPop; NextPop=Tmp;

    cout<<setw(3)<<Gen<<':'<<setw(5)<<BestFitness<<endl;
  }
  if(TargetReached) cout<<"Target fitness reached: "<<BestFitness<<"!\n";
  else cout<<"Target fitness not reached: "<<BestFitness<<"!\n";
  cout<<"Best Individual: ";
  for(i=0;i<cIndividualLength;i++)cout<<BestMember[i];cout<<endl;
  FreeMem(CrntPop,NextPop,Fitness,BestMember);
  char s[20];cin.getline(s,20);
  return 0;
}
//===========================================================

void InitPop(int ***CrntPop,int ***NextPop,int **Fitness,int **BestMember){
  int i, j;
  srand(Seed);
  *CrntPop = new int*[cPopSize];
  *NextPop = new int*[cPopSize];
  for(i=0;i<cPopSize;i++){
    (*CrntPop)[i] = new int[cIndividualLength];
    (*NextPop)[i] = new int[cIndividualLength];
  }
  *Fitness    = new int[cPopSize];
  *BestMember = new int[cIndividualLength];
  if(Fitness==NULL||BestMember==NULL)exit(1);
  for(i=0;i<cPopSize;i++){
    for(j=0;j<cIndividualLength;j++){
      (*CrntPop)[i][j] = RandInt(2);
    }
  }
}

void FreeMem(int **CrntPop,int **NextPop,int *Fitness,int *BestMenber){
  for(int i=0;i<cPopSize;i++){
    delete[]CrntPop[i];
    delete[]NextPop[i];
  }
  delete CrntPop;
  delete NextPop;
  delete Fitness;
  delete BestMenber;
}
//===========================================================

int EvaluateFitness(int *Member){
//Evaluates fitness based on bit pattern
  int i;
  int TheFitness = 0;
  for(i=0;i<cIndividualLength/6;i++)
    TheFitness += Member[i]==0;
  for(;i<cIndividualLength*2/6;i++)
    TheFitness += Member[i]==1;
  for(;i<cIndividualLength*3/6;i++)
    TheFitness += Member[i]==0;
  for(;i<cIndividualLength*4/6;i++)
    TheFitness += Member[i]==1;
  for(;i<cIndividualLength*5/6;i++)
    TheFitness += Member[i]==0;
  for(;i<cIndividualLength;i++)
    TheFitness += Member[i]==1;
  return(TheFitness);
}
//================================================================

int Tournament(int *Fitness,int TournamentSize){
  int WinFit = -99999, Winner;
  for(int i=0;i<TournamentSize;i++){
    int j = RandInt(cPopSize);
    if(Fitness[j]>WinFit){
      WinFit = Fitness[j];
      Winner = j;
    }
  }
  return Winner;
}

void Crossover(int *P1,int *P2,int *C1,int *C2){
  int i, Left, Right;
  switch(CrossoverType){
    case eRandom: // swap random genes
      for(i=0;i<cIndividualLength;i++){
        if(RandInt(2)){
          C1[i]=P1[i]; C2[i]=P2[i];
        }else{
          C1[i]=P2[i]; C2[i]=P1[i];
        }
      }
      break;
    case eUniform: // swap odd/even genes
      for(i=0;i<cIndividualLength;i++){
        if(i%2){
          C1[i]=P1[i]; C2[i]=P2[i];
        }else{
          C1[i]=P2[i]; C2[i]=P1[i];
        }
      }
      break;
    case eOnePoint:  // perform 1 point x-over
      Left = RandInt(cIndividualLength);
      if(cDebug){
        printf("Cut points: 0 <= %d <= %d\n",Left,cIndividualLength-1);
      }
      for(i=0;i<=Left;i++){
        C1[i]=P1[i]; C2[i]=P2[i];
      }
      for(i=Left+1;i<cIndividualLength;i++){
        C1[i]=P2[i]; C2[i]=P1[i];
      }
      break;
    case eTwoPoint:  // perform 2 point x-over
      Left = RandInt(cIndividualLength -1);
      Right = Left+1+RandInt(cIndividualLength-Left-1);
      if(cDebug){
        printf("Cut points: 0 <= %d < %d <= %d\n",Left,Right,cIndividualLength-1);
      }
      for(i=0;i<=Left;i++){
        C1[i]=P1[i]; C2[i]=P2[i];
      }
      for(i=Left+1;i<=Right;i++){
        C1[i]=P2[i]; C2[i]=P1[i];
      }
      for(i=Right+1;i<cIndividualLength;i++){
        C1[i]=P1[i]; C2[i]=P2[i];
      }
      break;
    default:
      printf("Invalid crossover?\n");
      exit(1);
  }
}

void Mutate(int *Member){
  int Pick = RandInt(cIndividualLength);
  Member[Pick]=!Member[Pick];
}

void Copy(int *P1,int *P2,int *C1,int *C2){
  for(int i=0;i<cIndividualLength;i++){
    C1[i]=P1[i]; C2[i]=P2[i];
  }
}
//=================================================================

double Rand01(){ // 0..1
  return(rand()/(double)(RAND_MAX));
}

int RandInt(int n){ // 0..n-1
  return int( rand()/(double(RAND_MAX)+1) * n );
}

