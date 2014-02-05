

b = 10000;
t = 10000;
name = 'a';


c1 = SC2000Communicator;
%
c1.open();

nameD = double(name);

c1.createPgm( 1, name )

c1.slewXY( b, b, t );
c1.slewXY( 0, b, t );
c1.slewXY( 0, 0, t );
c1.slewXY( b, 0, t );

c1.repeat();

c1.pgmEnd();

%%%%%
c1.enable(3);
c1.vector()
c1.executePgm( nameD )

%
pause()

c1.exitPgm();

c1.close();