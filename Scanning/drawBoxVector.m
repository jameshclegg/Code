% DRAWBOXVECTOR
%
% draws a square using vector commands
%
% 11th Feb 2014. JHC.

%%
clear 
close all
%% input parameters
% b is half of box side length
b = 6000;
% t is a time parameter.
t = 200;
name = 'a';

%% create serial connection and open it
c1 = SC2000Communicator;
c1.open();

%% send the program
c1.createPgm( 1, name );
c1.slewXY( b, b, t );
c1.slewXY( -b, b, t );
c1.slewXY( -b, -b, t );
c1.slewXY( b, -b, t );
c1.repeat();
c1.pgmEnd();

%% enable the axes, execute the program
c1.enable(3);
c1.vector();
c1.executePgm( name );
%%

%pause()
 
%c1.exitPgm();

%c1.close();