#include "A2.h"
#include <iostream>
#include <vector>
#include <fstream>
#include <sstream>
#include <random>
using namespace std;
//Member
default_random_engine randEng2;
Member::Member()
{
	name="";
}
void Member::print()
{
	cout<<name<<"\t";
}
void Member::setName(string n)
{
	name=n;
}
string Member::getName()
{
	return name;
}
//Manager--->Member
Manager::Manager()
{
	title=" ";
}
void Manager::setManager(string n,string title)
{
	Member::setName(n);
	this->title=title;
}
void Manager::setManager(Manager m)
{
	Member::setName(m.name);
	title=m.title;
}
void Manager::print()
{
	cout<<title<<" ";
	Member::print();
}
//FinancialManager---->Manager
int FinancialManager::getEffectiveness()
{
	return effectiveness;
}
void FinancialManager::setManager(string name,string title)
{
	Manager::setManager(name,title);
	uniform_int_distribution<unsigned> effectivenessRandom(1,10);
	effectiveness=effectivenessRandom(randEng2);
}
void FinancialManager::print()
{
	Manager::print();
	cout<<"effectiveness: "<<effectiveness<<endl;
}
//Campaign Manager
void CampaignManager::setNetwork()
{
	uniform_int_distribution<unsigned> randomNetwork(1,4);
	network=randomNetwork(randEng2);
}
int CampaignManager::getNetwork()
{
	return network;
}
void CampaignManager::setManager(CampaignManager m)
{
	Manager::setManager(m);
	network=m.network;
}
void CampaignManager::setManager(string name,string title)
{
	Manager::setManager(name,title);
	setNetwork();
}

int CampaignManager::fundImpact(int fund)
{
	float currentFund=fund;
	return currentFund/1000.00;
}
void CampaignManager::print()
{
	Manager::print();
	cout<<"Network:"<<network<<endl;
}
//NationalCampaignManager
void NationalCampaignManager::print()
{
	Manager::print();
	cout<<endl;
}
int NationalCampaignManager::numberOfAdvertisement()
{
	uniform_int_distribution<unsigned> GenerateNum(0,3);
	return GenerateNum(randEng2);
}
//TopMember---->Member
TopMember::TopMember()
{
	popularity=0;
}
int TopMember::getPopularity()
{
	return popularity;
}
void TopMember::setPopularity()
{
	uniform_int_distribution<unsigned> popularity(10,20);
	this->popularity=popularity(randEng2);
}
void TopMember::setPopularity(int popularity)
{
	this->popularity=popularity;
}
void TopMember::setTopMember(Stance *issueList)
{
	setPopularity();
	this->popularity=popularity;
}
void TopMember::setStance(Stance *issueList,Stance* partyStance)
{
	issueList->generateStanceBaseOnParty(5,stanceArray,issueList,partyStance);
}
void TopMember::getStance(Stance *stanceIn, int i)
{
	stanceIn->setStance(stanceArray[i].getSignifiance(),stanceArray[i].getApproach());
}
void TopMember::print()
{
	cout<<"Popularity: "<<popularity;
}
//Candidate----->TopMember
Candidate::Candidate()
{
        donation=0;
		vote=0;
}
int Candidate::getDonation()
{
	return donation;
}
void Candidate::setDonation(int newDonation)
{

	donation+=newDonation;
}
void Candidate::setVote(int vote)
{
	this->vote=vote;
}
int Candidate::getVote()
{
	return vote;
}
void Candidate::setCandidate(string nameIn,int donationIn,Stance *issueList)
{
	Member::setName(nameIn);
	TopMember::setTopMember(issueList);
	donation=donationIn;
}
void Candidate::setCandidate(Candidate candidateIn,int issueSize)
{
	name=candidateIn.name;
	popularity=candidateIn.popularity;
	donation=candidateIn.donation;
	for(int i=0;i<issueSize;i++)
        {
                stanceArray[i]=candidateIn.stanceArray[i];
        }

}
void Candidate::print(int sizeIssue)
{
	cout<<"Candidate ";
	Member::print();
	TopMember::print();
	cout<<"\t Donation:"<<donation<<"k"<<" Vote:"<<vote<<endl;
	cout<<"*Stance of Candidate: ";
	for(int i=0;i<sizeIssue;i++)
        {
                stanceArray[i].print();
                cout<<" ";
        }
        cout<<endl;
}
//Leader------>TopMember
Leader::Leader()
{
	yearsInPolitic=0;
}
int Leader::getExperience()
{
	return yearsInPolitic;
}
void Leader::setLeader(string n,int y,Stance *issueList)
{
	Member::setName(n);
	TopMember::setTopMember(issueList);
        yearsInPolitic=y;
}
void Leader::print(int sizeIssue)
{
	cout<<"Leader:\t";
	Member::print();
        TopMember::print();
	cout<<"\tExperience:"<<yearsInPolitic<<endl;
	cout<<"*Stance of Leader: ";
	for(int i=0;i<sizeIssue;i++)
        {
                stanceArray[i].print();
                cout<<" ";
        }
        cout<<endl;
}
void printAllLeadersPopularity(Party* parties, int partySize,int issueSize)
{
	cout<<"Party\tPopularity"<<endl;
	for(int i=0;i<partySize;i++)
	{
		cout<<i+1<<"\t"<<parties[i].getLeader().getPopularity()<<endl;
	}
}

