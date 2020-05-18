clear allclear all;
close all;

data = load training_data.txt;
res = load results.out;

plot(data(:,1),data(:,2),'k.');
hold on
plot(res(1:25,1),res(1:25,2),'rx');
plot(res(101:125,1),res(101:125,2),'go');
plot(res(126:150,1),res(126:150,2),'m+');
plot(res(151:175,1),res(151:175,2),'k+');
plot(res(201:225,1),res(201:225,2),'cx');
plot(res(251:275,1),res(251:275,2),'bo');;


