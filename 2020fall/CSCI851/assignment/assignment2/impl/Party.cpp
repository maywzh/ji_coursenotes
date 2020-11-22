#include "A2.h"
#include <iostream>
#include <vector>
#include <fstream>
#include <sstream>
#include <random>
#include <regex>
using namespace std;
//Split Function
vector<string> split(const string &line, char delim)
{
        vector<string> tempLine;
        istringstream ss(line);
        string item;
        while(getline(ss,item,delim))
        {
                tempLine.push_back(item);
        }
        return tempLine;
}

void Stance::readIssueFile(Stance *issueList)
{
	int i=0;
	ifstream inData;
	inData.open("Issues.txt");
	string line="";
	if(inData.good())
	{
		if(inData.peek() == std::ifstream::traits_type::eof()) 
                {
                        cerr<<"File issue is empty"<<endl;
                        exit(0);
                }
		cout<<"************************Reading Issue File************************"<<endl;
		while(getline(inData,line))
		{
			if(i==5)
			{
				cerr<<"The maximum limit for the issue is 5!!"<<endl;
			}
			if(count(line.begin(),line.end(),'.')!=1)
			{
				cerr<<"The file does not meet the format!"<<endl;
				exit(0);
			}
			vector<string> column=split(line,'.');
			if(column[0].empty())
			{
				cerr<<"File has issue name missing!"<<endl;
				exit(0);
			}
			if(column[1].empty())
			{
				cerr<<"Detail of issues are missing!Line: "<<i+1<<endl;
				exit(0);
			}
			issueList[i].setIssue(column[0]);
			issueList[i].setIssueDetail(column[1]);
			i++;
		}
		cout<<"Reading Issue File was successful!"<<endl;
		inData.close();
	}
	else
	{
		cerr<<"Unable to open the file!"<<endl;
		system("PAUSE");
  	}
}
//Parties
void Party::setParty(Leader leader,Candidate candidates[10],CampaignManager campaginM[10],NationalCampaignManager nationalcampagin,FinancialManager nationalFinancial,Stance *issueList,int PartySize,int numberOfElectorate)
{
		//GENERATE STANCE FOR THE PARTY
		issueList->generateStance(5,stanceArray,issueList);
        this->leader=leader;
		this->leader.setStance(issueList,stanceArray);
        for(int i=0;i<numberOfElectorate;i++)
        {
                this->candidates[i].setCandidate(candidates[i],PartySize);
				this->candidates[i].setStance(issueList,stanceArray);
        }
        for(int i=0;i<numberOfElectorate;i++)
        {
                this->campaginM[i].setManager(campaginM[i]);
        }
        this->nationalcampagin= nationalcampagin;
        this->nationalFinancial=nationalFinancial;
		
}
void Party::setFund(int fundIn)
{
	fund=fundIn;
}
int Party::getFund()
{
	return fund;
}
NationalCampaignManager Party::getNationalCampaignManager()
{
	return nationalcampagin;
}
Leader Party::getLeader()
{
	return leader;
}
FinancialManager Party::getFinancialManager()
{
	return nationalFinancial;
}
void Party::print(int sizeIssue,int NumberOfElectorate)
{
	cout<<"*Stance of Party: ";
	for(int i=0;i<sizeIssue;i++)
        {
                stanceArray[i].print();
		cout<<" ";
        }
	cout<<endl;
	leader.print(sizeIssue);
	for(int i=0;i<NumberOfElectorate;i++)
	{
		candidates[i].print(sizeIssue);
	}
	for(int i=0;i<NumberOfElectorate;i++)
        {
                campaginM[i].print();
        }
	nationalcampagin.print();
	nationalFinancial.print();
	cout<<"Initial Fund: "<<fund;
	cout<<endl;
}
void readPartyFile(Party* PartyList,Stance *issueList,int sizeIssue,int numberOfElectorate)
{
        int i=0;
		default_random_engine randEng;
        ifstream inData;
        inData.open("Parties.txt");
        string line="";
        if(inData.good())
        {
            cout<<"-------------Reading Parties File-------------"<<endl;
	     if(inData.peek() == std::ifstream::traits_type::eof())
             {
                    cerr<<"The file Party does not meet the format!"<<endl;
                    exit(0);
             }
	     while(getline(inData,line))
             {

				if(i==3)
				{
					cerr<<"Number of parties should be 3!"<<endl;
				}
				//READING NAME FOR THE MEMBERS OF THE PARTY
				vector<string> column=split(line,':');
				int size=(numberOfElectorate*2)+3;
				if(column.size()<((numberOfElectorate*2)+3))
				{
					cerr<<"(Line "<<i+1<<")Number of Members in this part is less or more than "<<(numberOfElectorate*2)+3<<endl;
					exit(0);
				}
				for(int j=0;j<column.size();j++)
				{
					if(column[j].empty())
					{
						cerr<<"Name of Member in the party can not be empty! error in line "<<j+1<<endl;
						exit(0);
					}
				}
				//GENERATE YEAR FOR LEADER
				Leader leader;
				uniform_int_distribution<unsigned> years(10,50);
				leader.setLeader(column[0],years(randEng),issueList);
				leader.setPopularity();
				//GENERATE DONATION FOR THE Candidate
				Candidate cArray[10];
				for(int k=0;k<numberOfElectorate;k++)
				{
					uniform_int_distribution<unsigned> donation(10,100);
					cArray[k].setPopularity();
					cArray[k].setCandidate(column[k+1],donation(randEng),issueList);
				}
				CampaignManager mArray[10];
				for(int j=0;j<numberOfElectorate;j++)
				{
					mArray[j].setManager(column[j+11],"Campaign Manager");
				}
				NationalCampaignManager nc;
				nc.setManager(column[21],"National Compagin Manager ");
				FinancialManager nf;
				nf.setManager(column[22],"National Financial Manager");
				PartyList[i].setParty(leader,cArray,mArray,nc,nf,issueList,sizeIssue,numberOfElectorate);
				uniform_int_distribution<unsigned> fundGenerator(10000,15000);
				PartyList[i].setFund(fundGenerator(randEng));
				i++;
            }
			cout<<"Reading Party File was successful!"<<endl;
            inData.close();
        }
        else
        {
                cerr<<"Unable to open the file!"<<endl;
                system("PAUSE");
        }
}
void Party::setLeaderPopularity(int newPopularity)
{
	leader.setPopularity(newPopularity);
}
void Party::getCandidateElectorate(Candidate *candidateArray,int electorateNum,int PartySize)
{
	candidateArray->setCandidate(candidates[electorateNum], PartySize);
}
void Party::getManagerElectorate(CampaignManager *managerArray,int electorateNum)
{
        managerArray->setManager(campaginM[electorateNum]);
}

void printParties(Party *parties,int partySize,int sizeIssue,int numOfElectorate)
{
	cout<<"************************************Party Report************************************"<<endl;
	for(int i=0;i<partySize;i++)
	{
		cout<<"***********************Party "<<i+1<<"***********************"<<endl;
		parties[i].print(sizeIssue,numOfElectorate);
	}
	cout<<"************************************************************************************"<<endl;
}

