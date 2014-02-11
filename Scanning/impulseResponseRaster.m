% IMPULSERESPONSERASTER
%
% Draws a step shape on one axis with a sweep on the other. Tests the
% impulse response of the system.
%
% This also provides an interesting test of synchronisation. If the pattern
% is not stable in time then we cannot rely on the timing of two separate
% raster functions to stay synchronised.
%
% 10th Feb 2014. JHC.

%%
clear 
close all

%% parameters

sweepSize = 6000;
stepSize = 6000;

t = 2000;
t1 = round(t/2);
t2 = t - t1;

nameRepeat = 'r';
nameStep = 's';

%%
c1 = SC2000Communicator;
c1.open();

%% create the sweep program
c1.createPgm( 0, nameRepeat );
c1.slew( sweepSize, t );
c1.slew( -sweepSize, t );
c1.repeat();
c1.pgmEnd();

%% create the step program
c1.createPgm( 0, nameStep );
c1.position( 0 );
c1.wait( t1 );
c1.position( stepSize );
c1.wait( t2 );
c1.repeat();
c1.pgmEnd();

%% 
c1.enable(3);
c1.executeRasterPgm( nameStep, nameRepeat );
%%

%pause()
 
%c1.exitPgm();

%c1.close();