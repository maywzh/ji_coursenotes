
#include "Main.h"
#include <iostream>
#include <random>
#include <string>
using namespace std;
default_random_engine randEng3;

//This Function update the opinion of all Elect.
void updateElectorateStance(Elect *electorateArray, int electorateSize, Stance *issueList, int size)
{
	for (int j = 0; j < electorateSize; j++)
	{
		electorateArray[j].setStance(size, issueList);
	}
}
//LOCAL EVENT
//This Event is going to effect the popularity of each CANDIDATE in the Elect and opinion of EACH Elect.
//It is going to update the stance and popularity.
void localDebate(Elect *electorate, Stance *issueList, int issueSize, int sizeParty, int index)
{
	cout << "*Local Debate for Elect " << index + 1 << endl;
	cout << "Stance before the event:  ";
	electorate[index].printStance(issueSize);
	electorate[index].setStance(issueSize, issueList);
	cout << "\nStance after the event:  ";
	electorate[index].printStance(issueSize);
	cout << "\nCandidate Popularity before the event:\n";
	electorate[index].printCandidatePopularity(sizeParty);
	cout << "Candidate Popularity after the event:\n";
	electorate[index].CandidatePopluarityCampaignManager(sizeParty);
	electorate[index].printCandidatePopularity(sizeParty);
	cout << endl;
}
//The two functions below effect popularity of the candidates.
//The candidate is going to make some more donation which may increase his pouparity.
void candidateEventDonationElectorate(Elect *electorate, int sizeParty, int index)
{
	cout << "*Canidate Donation Event for Elect " << index + 1 << endl;
	cout << "Record of previous Donation for each candidate in this electorate" << endl;
	electorate[index].printDonation(sizeParty);
	cout << "Candidate Popularity before the event:\n";
	electorate[index].printCandidatePopularity(sizeParty);
	cout << "Record of new Donation for each candidate in this electorate" << endl;
	electorate[index].updateDonation(sizeParty);
	electorate[index].CandidatePopluarityUpdateUsingDonation(sizeParty);
	electorate[index].printDonation(sizeParty);
	cout << "\nCandidate Popularity after the event:\n";
	electorate[index].printCandidatePopularity(sizeParty);
}
//This function will regenerate the Popularity
void candidateEventPopularity(Elect *electorate, int sizeParty, int index)
{
	cout << "*Canidate Popularity Event for Elect " << index + 1 << endl;
	cout << "Candidate Popularity before the event:\n";
	electorate[index].printCandidatePopularity(sizeParty);
	cout << "\nCandidate Popularity after the event:\n";
	electorate[index].CandidatePopluarityUpdate(sizeParty);
	electorate[index].printCandidatePopularity(sizeParty);
	cout << endl;
}
//The two functions below effect opinion of the electorates(Stance on each issue).
//it will randomly select an issue and update the stance of the issue only
void localIssueEvent(Elect *electorateArray, Stance *issueList, int size, int index)
{
	uniform_int_distribution<unsigned> RandomIssue(0, 4);
	int issueIndex = RandomIssue(randEng3);
	cout << "*Canidate Issue(" << issueList[issueIndex].getIssue() << ") Event for Elect " << index + 1 << endl;
	cout << "Stance before the Event: ";
	electorateArray[index].printStancePerIndex(issueIndex);
	electorateArray[index].setStance(size, issueList, issueIndex);
	cout << "\nStance After the Event: ";
	electorateArray[index].printStancePerIndex(issueIndex);
	cout << endl;
}
//NATIONAL EVENT
//This function update popularity of leaders base on the number of advertisments of national campaign manager
void NationalCampaignManagereffect(Party *parties, int partySize)
{
	int NationalCampaignManagereffect, newPopularity;
	cout << "Party\tNumberOfAdvertisment" << endl;
	for (int j = 0; j < partySize; j++)
	{

		NationalCampaignManagereffect = parties[j].getNationalCampaignManager().numberOfAdvertisement();
		cout << j + 1 << "\t" << NationalCampaignManagereffect << endl;
		parties[j].setLeaderPopularity(parties[j].getLeader().getPopularity() + NationalCampaignManagereffect);
	}
}
//This Event is going to effect the popularity of the LEADERS base on finanacial Manager in all the parties and opinion of Electorates which is Stance of ALL electorate
void leadersDebate(Elect *electorateArray, int electorateSize, Stance *issueList, int sizeIssue, Party *parties, int sizeParty)
{
	cout << "*Leader Debate for all Electorates" << endl;
	cout << "Stance Before Event" << endl;
	printElectorateStance(electorateArray, electorateSize, sizeIssue);
	cout << "Stance After Event" << endl;
	updateElectorateStance(electorateArray, electorateSize, issueList, sizeIssue);
	printElectorateStance(electorateArray, electorateSize, sizeIssue);
	cout << "Leaders Popularity before the event:\n";
	printAllLeadersPopularity(parties, sizeParty, sizeIssue);
	cout << "\Leaders Popularity after the event:\n";
	NationalCampaignManagereffect(parties, sizeParty);
	printAllLeadersPopularity(parties, sizeParty, sizeIssue);
	cout << endl;
}
void updateLeaderPopularity(Party *parties, int partySize)
{
	for (int j = 0; j < partySize; j++)
	{
		parties[j].getLeader().setPopularity();
	}
}
//This Event is going to effect the popularity of the LEADERS randomly in all the parties and opinion of Electorates which is Stance of ALL electorate
void leaderEventPopularity(Elect *electorateArray, int electorateSize, Stance *issueList, int sizeIssue, Party *parties, int sizeParty)
{
	cout << "*Leader Popularity Event" << endl;
	cout << "Stance Before Event" << endl;
	printElectorateStance(electorateArray, electorateSize, sizeIssue);
	cout << "Stance After Event" << endl;
	updateElectorateStance(electorateArray, electorateSize, issueList, sizeIssue);
	printElectorateStance(electorateArray, electorateSize, sizeIssue);
	cout << "Leaders Popularity before the event :\n";
	printAllLeadersPopularity(parties, sizeParty, sizeIssue);
	cout << "\Leaders Popularity after the event:\n";
	updateLeaderPopularity(parties, sizeParty);
	printAllLeadersPopularity(parties, sizeParty, sizeIssue);
	cout << endl;
}
void updateLeaderPopularityBaseOnYear(Party *parties, int partySize)
{
	int newPopularity = 0;
	for (int j = 0; j < partySize; j++)
	{
		newPopularity = parties[j].getLeader().getExperience() + parties[j].getLeader().getPopularity();
		parties[j].setLeaderPopularity(newPopularity);
	}
}
//This Event is going to effect the popularity of the LEADERS base on year of experince in all the parties and opinion of Electorates which is Stance of ALL electorate
void leaderEventExperinceImpact(Elect *electorateArray, int electorateSize, Stance *issueList, int sizeIssue, Party *parties, int sizeParty)
{
	cout << "*Leader Experience Impact Event" << endl;
	cout << "Stance Before Event" << endl;
	printElectorateStance(electorateArray, electorateSize, sizeIssue);
	cout << "Stance After Event" << endl;
	updateElectorateStance(electorateArray, electorateSize, issueList, sizeIssue);
	printElectorateStance(electorateArray, electorateSize, sizeIssue);
	cout << "Leaders Popularity before the event:\n";
	printAllLeadersPopularity(parties, sizeParty, sizeIssue);
	cout << "\Leaders Popularity after the event:\n";
	updateLeaderPopularityBaseOnYear(parties, sizeParty);
	printAllLeadersPopularity(parties, sizeParty, sizeIssue);
	cout << endl;
}
void nationalIssueEvent1(Elect *electorateArray, int electorateSize, Stance *issueList, int sizeIssue)
{
	uniform_int_distribution<unsigned> RandomIssue(0, 4);
	int issueIndex = RandomIssue(randEng3);
	cout << "*National Issue Event: " << issueList[issueIndex].getIssue() << endl;
	cout << "Stance Before Event" << endl;
	printElectorateStance(electorateArray, electorateSize, sizeIssue);
	for (int i = 0; i < electorateSize; i++)
	{
		electorateArray[i].setStance(sizeIssue, issueList, issueIndex);
	}
	cout << "Stance After Event" << endl;
	printElectorateStance(electorateArray, electorateSize, sizeIssue);
}
bool percentage(float probability)
{
	return rand() % 100 < (probability * 100);
}
bool percentage30(float probability)
{
	return rand() % 100 < (probability * 100);
}
//EACH CAMPAIGN DAY
//This function is going to recieve the fund and divide it between the parties. Base on the getEffectiveness of each financial manager
//of each party the fund will be divided.
void distributeFund(Party *parties, int fundRecived, int sizeParty)
{
	cout << "*Total Fund for Today: " << fundRecived << endl;
	int FinancialManagerNetorkArray[3];
	for (int i = 0; i < sizeParty; i++)
	{
		FinancialManagerNetorkArray[i] = parties[i].getFinancialManager().getEffectiveness();
	}
	float sum = 0;
	for (int i = 0; i < sizeParty; i++)
	{
		sum += FinancialManagerNetorkArray[i];
	}
	cout << "Party\tPreviousFund\tToday's incomingFund\tcurrentFund" << endl;
	for (int i = 0; i < sizeParty; i++)
	{
		int incomeFund = (fundRecived / sum) * FinancialManagerNetorkArray[i];
		cout << i + 1 << "\t" << parties[i].getFund() << "\t\t" << incomeFund;
		parties[i].setFund(parties[i].getFund() + incomeFund);
		cout << "\t\t\t" << parties[i].getFund();
		cout << endl;
	}
}
//The impact of the fund is going to be on the popularity of candidate of each party.
void dailySpending(Elect *electorateArray, Party *parties, int partySize, int numElectorate)
{
	cout << "*Daily Spending by Campaign Manager*" << endl;
	cout << "Elect\tCampaignManagerParty\tFundImpact\tCurrentPopularity\tPreviousFund\tCurrentPopularity\tCurrentFund" << endl;
	for (int i = 0; i < numElectorate; i++)
	{
		electorateArray[i].useFund(parties, partySize, i, numElectorate);
	}
}
void campaignDay(int numOfDay, int electorateSize, Elect *electorateArray, Party *parties, Stance *issueList, int sizeIssue, int sizeParty)
{
	for (int i = 0; i < numOfDay; i++)
	{
		cout << "******************************Day" << i << "***********************************" << endl;
		dailySpending(electorateArray, parties, sizeParty, electorateSize);
		for (int j = 0; j < electorateSize; j++)
		{
			uniform_int_distribution<unsigned> eventType(1, 5); //Randomaly generate number between 1 to 5 and call the random event from Local Event.
			if (percentage(0.20))								//Check the probability, if it is 20% then it return true otherwise it will be false.
			{
				switch (eventType(randEng3))
				{
				case 1:
					localDebate(electorateArray, issueList, sizeIssue, sizeParty, j);
					break;
				case 2:
					candidateEventDonationElectorate(electorateArray, sizeParty, j);
					break;
				case 3:
					candidateEventPopularity(electorateArray, sizeParty, j);
					break;
				case 4:
					localIssueEvent(electorateArray, issueList, sizeIssue, j);
					break;
				case 5:
					localIssueEvent(electorateArray, issueList, sizeIssue, j);
					break;
				}
			}
		}
		//National Events are called here.
		//The reason that it is not inside the the Elect loop is because, National event effect all the electorate not each of them.
		//Plus nationl event does not happen for each electorate.
		if (percentage30(0.30)) //Check the probability, if it is 20% then it return true otherwise it will be false.
		{
			uniform_int_distribution<unsigned> eventType(1, 5);
			switch (eventType(randEng3))
			{
			case 1:
				leadersDebate(electorateArray, electorateSize, issueList, sizeIssue, parties, sizeParty);
				break;
			case 2:
				leaderEventPopularity(electorateArray, electorateSize, issueList, sizeIssue, parties, sizeParty);
				break;
			case 3:
				leaderEventExperinceImpact(electorateArray, electorateSize, issueList, sizeIssue, parties, sizeParty);
				break;
			case 4:
				nationalIssueEvent1(electorateArray, electorateSize, issueList, sizeIssue);
				break;
			case 5:
				nationalIssueEvent1(electorateArray, electorateSize, issueList, sizeIssue);
				break;
			}
		}
		//Fund
		uniform_int_distribution<unsigned> fundDis(10000, 15000); //Generate Fund
		distributeFund(parties, fundDis(randEng3), sizeParty);
	}
}
//This is distance formula
//The reason I used is because we are using 2d cluster so I want to calculate the distance between the two points.
float distance(int x1, int y1, int x2, int y2)
{
	return sqrt(pow(x1 - x2, 2) +
				pow(y1 - y2, 2));
}
//This Function use distance function to calculate the distance between the opinion of the electorates and the candidates, so base on that, the electorate vote for candidate.
void processVotes(Elect *Electorates, int eSize, int issueSize, Party *parties)
{
	cout << "*************************Election Day*************************" << endl;
	cout << "Elect\tParty1\tParty2\tParty3\tWinner" << endl;
	for (int i = 0; i < eSize; i++)
	{
		cout << i + 1 << "\t\t";
		Electorates[i].processVotePerElectorate(issueSize, parties);
	}
}
//Election Result after calculating the seat won by each party.
void result(Elect *Electorates, int sizeElectorate, Party *parties)
{
	cout << "*************************Result*************************" << endl;
	int candidateIndex[3];
	for (int j = 0; j < sizeElectorate; j++)
	{
		if (j == 0)
		{
			candidateIndex[0] = 0;
			candidateIndex[1] = 0;
			candidateIndex[2] = 0;
		}
		if (Electorates[j].getPartyIndex() == 0)
		{
			candidateIndex[0] += 1;
		}
		if (Electorates[j].getPartyIndex() == 1)
		{
			candidateIndex[1] += 1;
		}
		if (Electorates[j].getPartyIndex() == 2)
		{
			candidateIndex[2] += 1;
		}
	}
	bool flag = true;
	int winnerIndex = 0, winnerSeat = 0;
	cout << "Party\tWonSeat" << endl;
	for (int i = 0; i < 3; i++)
	{
		cout << i + 1 << "\t" << candidateIndex[i] << endl;
		if (winnerSeat < candidateIndex[i])
		{
			winnerIndex = i;
			winnerSeat = candidateIndex[i];
		}
	}
	for (int j = 0; j < 3; j++)
	{
		if (winnerIndex != j)
		{
			if (winnerSeat == candidateIndex[j])
			{
				flag = false;
			}
		}
	}
	if (flag == false)
	{
		cout << "*There is not Winner because two more parties has same numbers of Seat!" << endl;
	}
	else
	{
		cout << "*The Winner is Party " << winnerIndex + 1 << " with " << winnerSeat << " seats!" << endl;
		cout << "The new government leader is " << parties[winnerIndex].getLeader().getName() << endl;
	}
}
