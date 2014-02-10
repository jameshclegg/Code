

%%
clear 
close all
%%
sweepSize = 6000;
t = 200;
t1 = round(t/2);
t2 = t - t1;
stepSize = 1000;
nameRepeat = 'r';
nameStep = 's';

%%
c1 = SC2000Communicator;

%%
c1.open();

%%
nameRepeatDec = double(nameRepeat);

c1.createPgm( 1, 0, nameRepeatDec );
c1.slew( 1, sweepSize, t );
c1.slew( 1, -sweepSize, t );
c1.repeat( 1 );
c1.pgmEnd( 1 );

%%
nameStepDec = double(nameStep);

c1.createPgm( 1, 0, nameStepDec );
c1.wait( 1, t1 );
c1.position( 1, 0 );
c1.position( 1, stepSize );
c1.wait( 1, t2 );
c1.repeat( 1 );
c1.pgmEnd( 1 );

%%

c1.enable(1, 3);
%c1.raster(1,3);
c1.executeRasterPgm( 1, nameRepeat, nameStep );
%%

%pause()
 
%c1.exitPgm( 1 );

%c1.close();