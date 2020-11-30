#include "Main.h"
#include <iostream>
#include <vector>
#include <fstream>
#include <sstream>
#include <random>
using namespace std;
//Stance

Stance::Stance()
{
	issue = "";
	issueDetail = "";
	signifiance = 0;
	approach = 0;
}
int Stance::getSignifiance()
{
	return signifiance;
}
void Stance::setIssueDetail(string detail)
{
	issueDetail = detail;
}
int Stance::getApproach()
{
	return approach;
}
void Stance::setIssue(string i)
{
	issue = i;
}
void Stance::setStance(int signifiance, int approach)
{
	this->signifiance = signifiance;
	this->approach = approach;
}
void Stance::print()
{
	cout << issue << "(" << signifiance << "," << approach << ") ";
}

void Stance::print(Stance *issueList, int size)
{
	cout << "Issue" << endl;
	for (int i = 0; i < size; i++)
	{
		cout << issueList[i].issue << ": " << issueList[i].issueDetail << endl;
	}
}
default_random_engine randEngStance;
//Generate stance for an array
void Stance::generateStance(int sizeIssue, Stance *stanceArray, Stance *issueList)
{
	//default_random_engine randEng;
	for (int j = 0; j < sizeIssue; j++)
	{
		uniform_int_distribution<unsigned> sig(10, 100);
		uniform_int_distribution<unsigned> apr(10, 100);
		stanceArray[j].setIssue(issueList[j].issue);
		stanceArray[j].setStance(sig(randEngStance), apr(randEngStance));
	}
}
//
void Stance::generateStanceBaseOnParty(int sizeIssue, Stance *stanceArray, Stance *issueList, Stance *partyStance)
{
	//default_random_engine randEng;
	for (int j = 0; j < sizeIssue; j++)
	{
		stanceArray[j].setIssue(issueList[j].issue);
		normal_distribution<> sig(partyStance[j].getSignifiance(), 5);
		normal_distribution<> apr(partyStance[j].getApproach(), 5);
		int sigTemp = sig(randEngStance);
		int appTemp = apr(randEngStance);
		if (sigTemp > 100 || appTemp > 100)
		{
			if (sigTemp > 100)
			{
				sigTemp = 100;
			}
			if (appTemp > 100)
			{
				appTemp = 100;
			}
		}
		if (sigTemp < 1 || appTemp < 1)
		{
			if (sigTemp < 1)
			{
				sigTemp = 1;
			}
			if (appTemp < 1)
			{
				appTemp = 1;
			}
		}
		stanceArray[j].setStance(sig(randEngStance), apr(randEngStance));
	}
}
//Generate Stance for one Elect only
void Stance::generateStance(int sizeIssue, Stance *stanceArray, Stance *issueList, int index)
{
	//default_random_engine randEng;
	stanceArray[index].setIssue(issueList[index].issue);
	uniform_int_distribution<unsigned> sig(1, 100);
	uniform_int_distribution<unsigned> apr(1, 100);
	stanceArray[index].setStance(sig(randEngStance), apr(randEngStance));
}