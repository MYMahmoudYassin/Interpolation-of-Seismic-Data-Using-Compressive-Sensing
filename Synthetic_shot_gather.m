clear,clc,close all

%EE562 Term 212 testing data for the term project.
%Prof. W. Mousa Date 23 Jan. 2022

load Syn_shot1g

figure,imagesc(offset(1:60),t,Dg),colormap(sgray),colorbar
xlabel('Offset(m)','FontName','times','FontSize',14)
set(gca,'xaxislocation','top')
ylabel('Time(s)','FontName','times','FontSize',14)








