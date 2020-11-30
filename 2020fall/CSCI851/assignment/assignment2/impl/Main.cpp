#include <iostream>
#include "Main.h"
using namespace std;

int main(int argc, char *argv[])
{
	if (argc != 3)
	{
		cout << "Number of Argument is less than 2!" << endl;
		exit(0);
	}
	const int electorateSize = stoi(argv[1]);
	if (electorateSize > 10 || electorateSize < 1)
	{
		cerr << "Elect Size Should be From 1 to 10" << endl;
		exit(0);
	}
	int compaingDays = stoi(argv[2]);
	if (compaingDays > 30 || compaingDays < 1)
	{
		cerr << "Elect Size Should be From 1 to 30" << endl;
		exit(0);
	}
	const int sizeParty = 3;
	const int sizeIssue = 5;
	//Issues
	Stance *issueList = new Stance[sizeIssue]; //Creating 5 stance to store the list of the issues
	issueList->readIssueFile(issueList);	   //Reading from the file and adding issue to the Array of Stance which is using here like an array of issue
	issueList->print(issueList, sizeIssue);	   //printing the issue only

	//Parties
	Party partyList[sizeParty];										//Create Array of party with size 3
	readPartyFile(partyList, issueList, sizeIssue, electorateSize); //Reading data from Party.txt and other detail using random
	printParties(partyList, sizeParty, sizeIssue, electorateSize);	//Printing the array of party

	//Elect

	Elect electorateList[electorateSize];															//Creating array of Elect
	generateElectorate(electorateList, electorateSize, issueList, sizeIssue, partyList, sizeParty); //generating Elect using random and assigning candidate.
	printAllElectorate(electorateList, electorateSize, sizeParty, sizeIssue);
	//CAMPAIGN DAY
	campaignDay(compaingDays, electorateSize, electorateList, partyList, issueList, sizeIssue, sizeParty); //Event function which effect the vote

	cout << "****************************End of Campaign pre-election****************************" << endl;
	printParties(partyList, sizeParty, sizeIssue, electorateSize);
	printAllElectorate(electorateList, electorateSize, sizeParty, sizeIssue);
	//Result
	processVotes(electorateList, electorateSize, sizeIssue, partyList); //Calculating the vote.
	result(electorateList, electorateSize, partyList);					//Showing the result

	return 0;
}
