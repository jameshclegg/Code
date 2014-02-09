
%%
b = 6000;
t = 2000;
name = 'a';

%%
c1 = SC2000Communicator;

%%
nameD = double(name);

txData = c1.createPgm( 0, 1, nameD );

txData = [txData, c1.slewXY( 0, b, b, t )];
txData = [txData, c1.slewXY( 0, 0, b, t )];
txData = [txData, c1.slewXY( 0, 0, 0, t )];
txData = [txData, c1.slewXY( 0, b, 0, t )];

txData = [txData, c1.repeat( 0 )];

txData = [txData, c1.pgmEnd( 0 )];

%%
c1.open()
c1.sendBytes( txData );
c1.enable(3);
c1.vector()
c1.executePgm( 0, nameD )
%%
%
pause()

c1.exitPgm( 0 );

c1.close( 0 );