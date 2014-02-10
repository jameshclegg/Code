
%%
clear 
close all
%%
b = 6000;
t = 2000;
name = 'a';

%%
c1 = SC2000Communicator;

%%
c1.open();
%c1.sendBytes( txData );
%c1.enable(1, 3);
%c1.vector(1)

%%
nameD = double(name);

% txData = c1.createPgm( 0, 1, nameD );
% 
% txData = [txData, c1.slewXY( 0, b, b, t )];
% txData = [txData, c1.slewXY( 0, 0, b, t )];
% txData = [txData, c1.slewXY( 0, 0, 0, t )];
% txData = [txData, c1.slewXY( 0, b, 0, t )];
% 
% txData = [txData, c1.repeat( 0 )];
% 
% txData = [txData, c1.pgmEnd( 0 )];

c1.createPgm( 1, 1, nameD );
c1.slewXY( 1, b, b, t );
c1.slewXY( 1, 0, b, t );
c1.slewXY( 1, 0, 0, t );
c1.slewXY( 1, b, 0, t );
c1.repeat( 1 );
c1.pgmEnd( 1 );

%%
%c1.open()
%c1.sendBytes( txData );
c1.enable(1, 3);
c1.vector(1)
c1.executePgm( 1, nameD )
%%
%
pause()

c1.exitPgm( 0 );

c1.close( 0 );