
%%
clear 
close all
%%
b = 6000;
t = 200;
name = 'a';

%%
c1 = SC2000Communicator;

%%
c1.open();

%%
nameD = double(name);

c1.createPgm( 1, 1, nameD );
c1.slewXY( 1, b, 0, t );
c1.slewXY( 1, -b, 0, t );
c1.repeat( 1 );
c1.pgmEnd( 1 );

%%

c1.enable(1, 3);
c1.vector(1);
c1.executePgm( 1, nameD );
%%

%pause()
 
%c1.exitPgm( 1 );

%c1.close();