#include "Main.h"
#include <iostream>
#include <vector>
#include <fstream>
#include <sstream>
#include <random>
#include <algorithm>
#include <string>
#include <istream>
using namespace std;

default_random_engine randEng;
//Elect
Elect::Elect()
{
}
void Elect::setVote(int vote)
{
	this->vote = vote;
}
int Elect::getPartyIndex()
{
	return partyIndex;
}
void Elect::setStance(int sizeIssue, Stance *issueList)
{
	issueList->generateStance(sizeIssue, stanceArray, issueList);
}
void Elect::setStance(int sizeIssue, Stance *issueList, int index)
{
	issueList->generateStance(sizeIssue, stanceArray, issueList, index);
}
void Elect::getStanceElectorate(Stance *stance, int index)
{
	stance[index].setStance(stanceArray[index].getSignifiance(), stanceArray[index].getApproach());
}
Stance Elect::getStanceElectorate(int i)
{
	return stanceArray[i];
}
void Elect::getStanceCandidate(Stance *stanceCandidate, int indexIssue, int IndexCandidate)
{
	candidateArray[IndexCandidate].getStance(stanceCandidate, indexIssue);
}
void Elect::regenerateStanceCandidates(int sizeParty)
{
	for (int i = 0; i < sizeParty; i++)
	{
		candidateArray[i].setPopularity();
	}
}
void Elect::print(int sizeParty, int sizeIssue)
{
	cout << "Vote:\t" << vote << endl;
	for (int i = 0; i < sizeIssue; i++)
	{
		stanceArray[i].print();
	}
	cout << endl;
	for (int i = 0; i < sizeParty; i++)
	{
		cout << "*Party " << i + 1 << ":";
		candidateArray[i].print(sizeIssue);
		managerArray[i].print();
		cout << "---------------" << endl;
	}
}
void Elect::printStance(int sizeIssue)
{
	for (int i = 0; i < sizeIssue; i++)
	{
		stanceArray[i].print();
	}
}
void Elect::printCandidatePopularity(int sizeParty)
{
	for (int i = 0; i < sizeParty; i++)
	{
		cout << "Candidate" << i + 1 << ":\t" << candidateArray[i].getPopularity() << endl;
		;
	}
}
//Updating donation for Candidate Donation event in local event
void Elect::updateDonation(int sizeParty)
{
	for (int i = 0; i < sizeParty; i++)
	{
		uniform_int_distribution<unsigned> randomDonation(2, 5);
		int todayDonation = randomDonation(randEng);
		cout << "Today's Donation from candiate" << i << " :" << todayDonation << endl;
		candidateArray[i].setDonation(randomDonation(randEng));
	}
}
void Elect::printDonation(int sizeParty)
{
	for (int i = 0; i < sizeParty; i++)
	{
		cout << "Candidate" << i + 1 << ":\t" << candidateArray[i].getDonation() << "K" << endl;
		;
	}
}

void Elect::printStancePerIndex(int issueIndex)
{
	stanceArray[issueIndex].print();
}
void Elect::useFund(Party *parties, int partySize, int index, int electorateSize)
{
	int popularityImpactByFund, fundPerCandidate;
	int currentPartyFund;
	for (int i = 0; i < partySize; i++)
	{
		cout << index + 1 << "\t\t\t" << i + 1 << "\t\t";
		currentPartyFund = parties[i].getFund();
		fundPerCandidate = currentPartyFund / electorateSize;
		popularityImpactByFund = managerArray[i].fundImpact(fundPerCandidate); //Daily fund calculation by Campaign Manager
		cout << popularityImpactByFund;
		cout << "\t\t" << candidateArray[i].getPopularity() << "\t\t\t" << parties[i].getFund();
		parties[i].setFund(currentPartyFund - fundPerCandidate);
		candidateArray[i].setPopularity(candidateArray[i].getPopularity() + popularityImpactByFund);
		if (candidateArray[i].getPopularity() > 100)
		{
			candidateArray[i].setPopularity(100);
		}
		cout << "\t\t" << candidateArray[i].getPopularity() << "\t\t\t" << parties[i].getFund() << endl;
	}
}
void Elect::CandidatePopluarityUpdate(int sizeParty)
{
	for (int i = 0; i < sizeParty; i++)
	{
		candidateArray[i].setPopularity();
	}
}
void Elect::CandidatePopluarityUpdateUsingDonation(int sizeParty)
{
	for (int i = 0; i < sizeParty; i++)
	{
		int newPopularity = (candidateArray[i].getDonation() / 10.0) + candidateArray[i].getPopularity();
		candidateArray[i].setPopularity(newPopularity);
	}
}
void Elect::CandidatePopluarityCampaignManager(int sizeParty)
{
	int newPopularity = 0;
	for (int i = 0; i < sizeParty; i++)
	{
		newPopularity = candidateArray[i].getPopularity() + managerArray[i].getNetwork();
		candidateArray[i].setPopularity(newPopularity);
	}
}
void Elect::setVoteCandidate(int result1, int result2, int result3)
{
	candidateArray[0].setVote(result1);
	candidateArray[1].setVote(result2);
	candidateArray[2].setVote(result3);
}
int Elect::getVote()
{
	return vote;
}
void Elect::assignCandidate(Party *parties, int electorateNum, int sizeParty, int sizeIssue)
{
	for (int i = 0; i < sizeParty; i++)
	{
		parties[i].getCandidateElectorate(&candidateArray[i], electorateNum, sizeIssue);
	}
}
void Elect::assignManager(Party *parties, int electorateNum, int sizeParty)
{
	for (int i = 0; i < sizeParty; i++)
	{
		parties[i].getManagerElectorate(&managerArray[i], electorateNum);
	}
}
void Elect::setPartyIndex(int i)
{
	partyIndex = i;
}
void Elect::processVotePerElectorate(int sizeissue, Party *parties)
{
	float total = 0;
	int *totalVote;
	const int sizeParty = 3;
	int candidateArrayVote[sizeParty];
	int temp = 0;
	for (int i = 0; i < sizeissue; i++)
	{
		if (i == 0)
		{
			candidateArrayVote[0] = 0;
			candidateArrayVote[1] = 0;
			candidateArrayVote[2] = 0;
		}
		for (int j = 0; j < sizeParty; j++)
		{
			temp = 0;
			Stance stancePerCandidate;
			candidateArray[j].getStance(&stancePerCandidate, i);
			float ElectorateOpinion = distance(stanceArray[i].getSignifiance(), stanceArray[i].getApproach(), stancePerCandidate.getSignifiance(), stancePerCandidate.getApproach());
			ElectorateOpinion = 100 - ElectorateOpinion;
			candidateArrayVote[j] += ElectorateOpinion;
			total += ElectorateOpinion;
		}
	}
	for (int k = 0; k < sizeParty; k++)
	{
		candidateArrayVote[k] -= candidateArray[k].getPopularity();
		total -= candidateArray[k].getPopularity();
		candidateArrayVote[k] -= parties[k].getLeader().getPopularity();
		total -= parties[k].getLeader().getPopularity();
	}
	for (int k = 0; k < sizeParty; k++)
	{
		candidateArray[k].setVote((vote / total) * (candidateArrayVote[k]));
	}
	//Finding Percentage
	for (int k = 0; k < sizeParty; k++)
	{
		candidateArray[k].setVote((vote / total) * (candidateArrayVote[k]));
	}
	int max = 0;
	for (int k = 0; k < sizeParty; k++)
	{
		if (max < candidateArray[k].getVote())
		{
			partyIndex = k;
			max = candidateArray[k].getVote();
		}
		cout << candidateArray[k].getVote() << "\t";
	}
	cout << partyIndex + 1 << endl;
}
void printElectorateStance(Elect *electoateArray, int sizeElectorate, int sizeIssue)
{
	for (int j = 0; j < sizeElectorate; j++)
	{
		for (int i = 0; i < sizeIssue; i++)
		{
			electoateArray[j].getStanceElectorate(i).print();
		}
		cout << endl;
	}
}

void generateElectorate(Elect *electorateArray, int sizeElectorate, Stance *issueList, int sizeIssue, Party *parties, int sizeParty)
{

	for (int i = 0; i < sizeElectorate; i++)
	{
		//ASSIGN CANDIDATE
		electorateArray[i].assignCandidate(parties, i, sizeParty, sizeIssue);
		//ASSIGN CAMPIGN MANAGER
		electorateArray[i].assignManager(parties, i, sizeParty);
		//GENERATE VOTE
		normal_distribution<> normal(100, 15);
		electorateArray[i].setVote(normal(randEng));
		//GENERATE STANCE
		electorateArray[i].setStance(sizeIssue, issueList);
	}
}
void printAllElectorate(Elect *electorate, int electorateSize, int sizeParty, int sizeIssue)
{
	cout << "************************************Nation Report************************************" << endl;
	for (int i = 0; i < electorateSize; i++)
	{
		cout << "\nElectorate " << i + 1 << ":" << endl;
		electorate[i].print(sizeParty, sizeIssue);
	}
}
