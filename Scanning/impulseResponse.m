

%%
clear 
close all
%%
sweepSize = 6000;
t = 2000;
t1 = round(t/2);
t2 = t - t1;
stepSize = 6000;
nameRepeat = 'r';
nameStep = 's';

%%
c1 = SC2000Communicator;

%%
c1.open();

%%
c1.createPgm( 1, 0, nameRepeat );
c1.slew( 1, sweepSize, t );
c1.slew( 1, -sweepSize, t );
c1.repeat( 1 );
c1.pgmEnd( 1 );

%%
c1.createPgm( 1, 0, nameStep );
c1.position( 1, 0 );
c1.wait( 1, t1 );
c1.position( 1, stepSize );
c1.wait( 1, t2 );
c1.repeat( 1 );
c1.pgmEnd( 1 );

%%

c1.enable(1, 3);
%c1.raster(1,3);
c1.executeRasterPgm( 1, nameStep, nameRepeat );
%%

%pause()
 
%c1.exitPgm( 1 );

%c1.close();