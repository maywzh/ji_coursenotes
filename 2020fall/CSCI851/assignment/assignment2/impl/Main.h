#ifndef A2_HEADER
#define A2_HEADER
#include <iostream>
using namespace std;
//Class Stance is to store list of issue, sig and approach
struct Stance
{
private:
	string issue;
	string issueDetail;
	int signifiance;
	int approach;

public:
	Stance(); //default constructor
	int getSignifiance();
	int getApproach();
	void setIssueDetail(string detail);
	void setIssue(string);
	string getIssue() { return issue; };
	void setStance(int, int);
	void readIssueFile(Stance *sList);											//Reading issue data from issue.txt
	void generateStance(int sizeIssue, Stance *stanceArray, Stance *issueList); //Generate Stance randomly for list of issue
	void generateStance(int sizeIssue, Stance *stanceArray, Stance *issueList, int index);
	void generateStanceBaseOnParty(int sizeIssue, Stance *stanceArray, Stance *issueList, Stance *partyStance);
	void print();						 //prining list issue, sig and approach
	void print(Stance *sList, int size); //Printing only issue not sig or approach
};
//Class Member which is the base class for TopMember and Manager
class Member
{
protected:
	string name;

public:
	Member(); //default constructor, nothing crazy
	void setName(string);
	string getName();
	virtual void print(); //polymorphism for printing Member
};
//Top Member is derived from Member and it is the base for Candidate class and Leader class
class TopMember : public Member
{
protected:
	Stance stanceArray[5];
	int popularity;

public:
	TopMember();
	int getPopularity();
	void setStance(Stance *issueList, Stance *partyStance);
	void setPopularity();	 //generating popluarity
	void setPopularity(int); //instead of generating poularity, this function get a value and set it as poularity
	void setTopMember(Stance *i);
	void getStance(Stance *s, int); //Not a perfect name, but does the work. This function is basically getting the index and the stance array and set it.
	virtual void print();			//polymorphism for printing TopMember
};
//Candidate class is derived from Top Member and has 2 extra attributes
class Candidate : public TopMember
{
private:
	int donation; //Okay, so donation effect the popularity
	int vote;	  //storing vote for candidate here. It is zero in the start.
public:
	Candidate(); //This is just a default constructor. instead I used setCandidate to set the condidate.
	int getDonation();
	void setDonation(int newDonation);
	void setVote(int);
	int getVote();
	void setCandidate(string, int, Stance *i); //The reason that I am using this instead of Constructor is that I do not create new candidate or delete it then
	void setCandidate(Candidate c, int PartySize);
	virtual void print(int sizeIssue); //polymorphism for printing Candidate
};
//Leader class is derived from Top Member and has a extra attribute
class Leader : public TopMember
{
private:
	int yearsInPolitic;

public:
	Leader();
	int getExperience();
	void setLeader(string, int, Stance *i); //  I used this instead of construct so that I should not create any new obj
	virtual void print(int sizeIssue);		//polymorphism for printing Leader
};
//Managers is derived class from Member and base class for other managers
class Manager : public Member
{
protected:
	string title; //title is basically the manager's position
public:
	Manager();
	virtual void setManager(Manager);
	virtual void setManager(string, string);
	virtual void print(); //polymorphism for printing Manager
};
//Class CampaignManager is derived from class Manager but does not have any extra attribute. Just extra function
class CampaignManager : public Manager
{
	int network;

public:
	int getNetwork();
	void setNetwork();
	virtual void setManager(string, string);
	virtual void setManager(CampaignManager);
	int fundImpact(int f); //Calculate the fund and have impact on popularirty. It was mentioned in the specification to add such a function here
	int remainingFund(int);
	virtual void print(); //polymorphism for printing CampaignManager
};
//class FinancialManager is derived from Manager class which extra extra attribute
class FinancialManager : public Manager
{
private:
	int effectiveness; // By network, it means his connection with important and rich people.
public:
	virtual void setManager(string, string); //I could use inhertiance constructor but then I needed to create a new obj so no
	int getEffectiveness();
	virtual void print(); //polymorphism for printing FinancialManager
};
//class NationalCampaignManager is derived from Manager class
class NationalCampaignManager : public Manager
{
public:
	int numberOfAdvertisement(); // NationalCampaignManager do some advertisment per day and the high it is , the higher popularity
	virtual void print();		 //polymorphism for printing NationalCampaignManager
};
//This is going to get the array of stance and size and then generate it.
void generateStance(int sizeIssue, Stance *stanceArray);
//Parties
class Party
{
private:
	Leader leader;
	Candidate candidates[10];
	CampaignManager campaginM[10];
	NationalCampaignManager nationalcampagin;
	FinancialManager nationalFinancial;
	int fund;
	Stance stanceArray[5];

public:
	void setLeaderPopularity(int newPopularity);
	void setParty(Leader leaderIn, Candidate candidatesIn[10], CampaignManager campaginMIn[10], NationalCampaignManager nationalcampaginIn, FinancialManager nationalFinancialIn, Stance *issueList, int sizeIssue, int numberOfElectorate);
	void getCandidateElectorate(Candidate *c, int, int PartySize);
	void getManagerElectorate(CampaignManager *m, int);
	FinancialManager getFinancialManager();
	NationalCampaignManager getNationalCampaignManager();
	Leader getLeader();
	void setFund(int);
	int getFund();
	void print(int sizeIssue, int numberOfElectorate);
};
void readPartyFile(Party *parties, Stance *issueList, int sizeParty, int numberofElectorate); //Reading from party.txt file
void printParties(Party *parties, int partySize, int sizeIssue, int numOfElectorate);
//Elctorate
class Elect
{
private:
	int vote; //numbers of vote they get
	Stance stanceArray[5];
	Candidate candidateArray[3];
	CampaignManager managerArray[3];
	int partyIndex; //whichever party won the seat, the index will be save here
public:
	Elect();
	void setVote(int);
	int getPartyIndex();
	void setStance(int, Stance *s);
	int getVote();
	Stance getStanceElectorate(int i);
	void printStancePerIndex(int issueIndex);
	void printStance(int sizeIssue);
	void CandidatePopluarityUpdateUsingDonation(int sizeParty);
	void printDonation(int sizeParty);
	void updateDonation(int sizeParty);
	void CandidatePopluarityCampaignManager(int sizeParty);
	void setVoteCandidate(int, int, int);
	void getStanceElectorate(Stance *s, int);
	void setStance(int sizeIssue, Stance *issueList, int index);
	void getStanceCandidate(Stance *s, int, int);
	void regenerateStanceCandidates(int sizeParty);
	void assignCandidate(Party *p, int, int sizeParty, int sizeIssue);		   //This is going to assign the candidates from the party to Elect
	void assignManager(Party *p, int, int sizeParty);						   // same as assiging candidate, this one assign manager
	void setPartyIndex(int);												   // saving the index of the party that won the seat here.
	void useFund(Party *parties, int sizeIssue, int index, int numElectorate); //spending the fund on electorate, it is called in event
	void processVotePerElectorate(int, Party *parties);						   //calculating the distance between each stance using distance formula
	void print(int sizeParty, int sizeIssue);
	void CandidatePopluarityUpdate(int sizeParty);
	void printCandidatePopularity(int sizeParty);
};
void printElectorateStance(Elect *electoateArray, int sizeElectorate, int sizeIssue);
void printAllElectorate(Elect *electorate, int electorateSize, int sizeParty, int sizeIssue);
//here we are going to get the empty array of ELectorate and generate the candidate, manager,... for each electorate.
void generateElectorate(Elect *electorateArray, int sizeElectorate, Stance *s, int sizeIssue, Party *parties, int sizeParty);
//****************************Till here we have all the party, candidate and stance ready*******************
//*************************************Now let's look at the compagin day **********************************

//LOCAL EVENT will be called for each electorate with probablity of %20
void localDebate(Elect *electorateArray, Stance *issueList, int size, int sizeParty, int index); //This effects the popularity of candidate and stance of electorate.
void candidateEventDonationElectorate(Elect *electorateArray, int sizeParty, int index);		 //This effect the popularity of candidate
void candidateEventPopularity(Elect *electorateArray, int sizeParty, int index);
void localIssueEvent(Elect *electorateArray, Stance *issueList, int size, int index); //This effect the stance of each electorate
//NATIONAL EVENT will be called once a day with probablity of %30
void printAllLeadersPopularity(Party *parties, int partySize, int issueSize);
void leadersDebate(Elect *electorateArray, int, Stance *issueList, int size, Party *parties, int sizeParty); //This effects the popularity of leader and stance of electorate.
void printAllLeadersPopularity(Party *parties, int partySize);
void leaderEventPopularity(Elect *electorateArray, int, Stance *issueList, int sizeIssue, Party *parties, int sizeParty); //This effect the popularity of leader
void updateLeaderPopularityBaseOnYear(Party *parties, int partySize);
void leaderEventExperinceImpact(Elect *electorateArray, int, Stance *issueList, int sizeIssue, Party *parties, int sizeParty);
void nationalIssueEvent1(Elect *electorateArray, int, Stance *issueList); //This effect the stance of all electorate
//CAMPAIGN DAY
void distributeFund(Party *parties, int fundRecived, int sizeParty);						  //distributing the fund that we got.
void dailySpending(Elect *electorateArray, Party *parties, int sizeIssue, int numElectorate); //This is the effect of the fund
void campaignDay(int, int numElectorate, Elect *electorateArray, Party *parties, Stance *issueList, int sizeIssue, int sizeParty);
void updateElectorateStance(Elect *electorateArray, int, Stance *issueList, int size);
void updateElectorateStance(Party *parties, int partySize);

//*****************************Now the stance and pupolarty have changed and effected the stance of electorate also.
//*****************************Calculting the votes
//ELECTION PROCESS
float distance(int x1, int y1, int x2, int y2);					 //calculating distance of two stance
void processVotes(Elect *Electorates, int, int, Party *parties); //using distance formula, electorate, vote to candidate with less distance
//Result
void result(Elect *Electorates, int sizeParty, Party *parties); //announcing the result

#endif