% IMPULSERESPONSEVECTOR
%
% Draws a step shape on one axis with a sweep on the other. Tests the
% impulse response of the system.
%
% Vector version of the impulse response testing. The raster timing was a
% little out, so I tried using vector mode instead. There may be an issue
% because slew commands for the sweep are interrupted by the step in the
% other axis.
%
% 10th Feb 2014. JHC.

%%
clear 
close all
%%
sweepSize = 9000;
stepSize = 6000;

t = 50;
d = -1000;
t1 = round(t/2);
t2 = t - t1;

name = 'i';

% the axis which the step occurs on
testAxis = 'x';

% p is a list of points (x,y) which the program steps through.
p = [-sweepSize, 0; ...
    0,0; ...
	0, stepSize; ...
	sweepSize, stepSize; ...
	sweepSize, d; ...
	-sweepSize, d ];

% swap the columns around if the test axis is x
switch testAxis
    case 'x'
        p = [p(:,2), p(:,1)];
    case 'y'
end

% find distance moved between each point, including the distance from the
% last point to the first
% x and y distances
pd = diff( [p(end,:); p ] );
% total distances between each point
displ = hypot( pd(:,1), pd(:,2) );

% work out scaled time so that spot will always move at same speed
ts = round( displ/sweepSize * t );

%%
c1 = SC2000Communicator;
c1.open();

%%
c1.createPgm( name );

c1.slewXY( p(1,1), p(1,2), ts(1) );
c1.slewXY( p(2,1), p(2,2), ts(2) );
c1.positionXY( p(3,1), p(3,2) );
c1.slewXY( p(3,1), p(3,2), ts(3) );
c1.slewXY( p(4,1), p(4,2), ts(4) );
c1.slewXY( p(5,1), p(5,2), ts(5) );
c1.slewXY( p(6,1), p(6,2), ts(6) );

c1.repeat();
c1.end();

%%

c1.enable( 3 );
c1.vector();
c1.executePgm( name );
%%

%pause()
 
%c1.exitPgm();

%c1.close();