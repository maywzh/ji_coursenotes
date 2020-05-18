clear all;
close all;

data = load ('training_data.txt');
res = load ('results.out');

figure;
plot(data(:,1),data(:,2),'r.');
hold on
for i = 0 : 24
    %h1=plot(res(1+i,1),res(1+i,2),'r.','LineWidth',2);
    %h2=plot(res(101+i,1),res(101+i,2),'r.','LineWidth',2);
    str_label = strcat ( '(',int2str(floor(i/5)),',', int2str(mod(i,5)),')' );
    %str_labe = int2str(i);
    text(res(1+i,1),res(1+i,2),str_label,'Color','b','FontWeight','bold','FontSize',8);
    text(res(101+i,1),res(101+i,2),str_label,'Color','k','FontWeight','bold','FontSize',8);
    line([res(1+i,1),res(101+i,1)],[res(1+i,2),res(101+i,2)])
end
title('blue - begin, black - end');

figure;
plot(data(:,1),data(:,2),'r.');
hold on
for i = 0 : 24
    %h1=plot(res(1+i,1),res(1+i,2),'r.','LineWidth',2);
    %h2=plot(res(101+i,1),res(101+i,2),'r.','LineWidth',2);
    str_label = strcat ( '(',int2str(floor(i/5)),',', int2str(mod(i,5)),')' );
    %str_labe = int2str(i);
    text(res(1+i,1),res(1+i,2),str_label,'Color','b','FontWeight','bold','FontSize',8);
    text(res(126+i,1),res(126+i,2),str_label,'Color','k','FontWeight','bold','FontSize',8);
    line([res(1+i,1),res(126+i,1)],[res(1+i,2),res(126+i,2)])
end
title('blue - begin, black - end');

figure;
plot(data(:,1),data(:,2),'r.');
hold on
for i = 0 : 24
    %h1=plot(res(1+i,1),res(1+i,2),'r.','LineWidth',2);
    %h2=plot(res(101+i,1),res(101+i,2),'r.','LineWidth',2);
    str_label = strcat ( '(',int2str(floor(i/5)),',', int2str(mod(i,5)),')' );
    %str_labe = int2str(i);
    text(res(1+i,1),res(1+i,2),str_label,'Color','b','FontWeight','bold','FontSize',8);
    text(res(151+i,1),res(151+i,2),str_label,'Color','k','FontWeight','bold','FontSize',8);
    line([res(1+i,1),res(151+i,1)],[res(1+i,2),res(151+i,2)])
end
title('blue - begin, black - end');

figure;
plot(data(:,1),data(:,2),'r.');
hold on
for i = 0 : 24
    %h1=plot(res(1+i,1),res(1+i,2),'r.','LineWidth',2);
    %h2=plot(res(101+i,1),res(101+i,2),'r.','LineWidth',2);
    str_label = strcat ( '(',int2str(floor(i/5)),',', int2str(mod(i,5)),')' );
    %str_labe = int2str(i);
    text(res(1+i,1),res(1+i,2),str_label,'Color','b','FontWeight','bold','FontSize',8);
    text(res(201+i,1),res(201+i,2),str_label,'Color','k','FontWeight','bold','FontSize',8);
    line([res(1+i,1),res(201+i,1)],[res(1+i,2),res(201+i,2)])
end
title('blue - begin, black - end');

figure;
plot(data(:,1),data(:,2),'r.');
hold on
for i = 0 : 24
    %h1=plot(res(1+i,1),res(1+i,2),'r.','LineWidth',2);
    %h2=plot(res(101+i,1),res(101+i,2),'r.','LineWidth',2);
    str_label = strcat ( '(',int2str(floor(i/5)),',', int2str(mod(i,5)),')' );
    %str_labe = int2str(i);    
    text(res(1+i,1),res(1+i,2),str_label,'Color','b','FontWeight','bold','FontSize',8);
    text(res(251+i,1),res(251+i,2),str_label,'Color','k','FontWeight','bold','FontSize',8);
    line([res(1+i,1),res(251+i,1)],[res(1+i,2),res(251+i,2)])
end
title('blue - begin, black - end');
