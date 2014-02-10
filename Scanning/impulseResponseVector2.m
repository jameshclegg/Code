

%%
clear 
close all
%%
sweepSize = 9000;
t = 50;
d = -1000;
t1 = round(t/2);
t2 = t - t1;
stepSize = 6000;
name = 'i';
testAxis = 'x';

p = [-sweepSize, 0; ...
    0,0; ...
	0, stepSize; ...
	sweepSize, stepSize; ...
	sweepSize, d; ...
	-sweepSize, d ];

switch testAxis
    case 'x'
    case 'y'
        p = [p(:,2), p(:,1)];
end

% find distance moved between each point
pd = diff( [p(end,:); p ] );
displ = hypot( pd(:,1), pd(:,2) );

% work out scaled time so that spot will always move at same speed
ts = round( displ/sweepSize * t );

%%
c1 = SC2000Communicator;

%%
c1.open();

%%
c1.createPgm( 1, 1, name );

c1.positionXY( 1, p(1,1), p(1,2) );
c1.slewXY( 1, p(2,1), p(2,2), t );
c1.positionXY( 1, p(3,1), p(3,2) );
c1.slewXY( 1, p(4,1), p(4,2), t );
c1.positionXY( 1, p(5,1), p(5,2) );
c1.slewXY( 1, p(6,1), p(6,2), 2*t );

c1.repeat( 1 );
c1.pgmEnd( 1 );

%%

c1.enable(1, 3);
c1.vector(1);
c1.executePgm( 1, name );
%%

%pause()
 
%c1.exitPgm( 1 );

%c1.close();