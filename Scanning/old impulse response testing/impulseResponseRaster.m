function c = impulseResponseRaster( testAxis, t, sweepSize, stepSize )
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
% 12th Feb 2014. JHC. Changed to function.

% parameters
if isempty( t )
    t = 300;
end

if isempty( sweepSize )
   sweepSize = 8000;
end

if isempty( stepSize )
    stepSize = 3000;
end

t1 = round(t/3);
t2 = t - t1;
tWait = round(t/10);

nameRepeat = 'r';
nameStep = 's';

%%
c = SC2000Communicator;
c.open();

%% create the sweep program
c.createPgm( 0, nameRepeat );
c.wait( tWait );
c.slew( sweepSize, t );
c.wait( tWait );
c.slew( -sweepSize, t );
c.repeat();
c.end();

%% create the step program
c.createPgm( 0, nameStep );
c.wait( tWait );
c.position( -stepSize );
c.wait( t1-1 );
c.position( stepSize );
c.wait( t2-1 );
c.wait( tWait );
c.wait( t1 );
c.position( -stepSize );
c.wait( t2-1 );
c.repeat();
c.end();

%% 

switch testAxis
    case 'x'
        arg1 = nameStep;
        arg2 = nameRepeat;
    case 'y'
        arg1 = nameRepeat;
        arg2 = nameStep;
end

c.executeRasterPgm( arg1, arg2 );

%%

%pause()
 
%c1.exitPgm();

%c1.close();

end