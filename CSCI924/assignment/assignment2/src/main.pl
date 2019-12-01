% Define a robot that can move by one position up,down,right or left
% The robot can visit the states as defined in DB.pl
% The robot starts in startState and must find a sequence of states
% that lead to the goalState
% Aim: Write a rule called "roby" which find the shortest path.



roby(X):-[X], <complete_the_rule_here>.

roby:-roby('DB').
