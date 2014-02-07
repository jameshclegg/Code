function txData = iftempokexecuterasterpgm( self, DEVICEID, xPGMID, yPGMID )
	% IFTEMPOKEXECUTERASTERPGM
	% Number of inputs: 4
	%	 Input 1: self.serialObj is an open serial port
	%	 Input 2: DEVICEID is an LEWORD
	%	 Input 3: xPGMID is an LEWORD
	%	 Input 4: yPGMID is an LEWORD
	% For use in vector mode.
	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 07 February 2014. James Clegg.


commandBit = 13; 
b1 = self.convert2leWord( DEVICEID );
b2 = self.convert2leWord( xPGMID );
b3 = self.convert2leWord( yPGMID );

txData = [ commandBit, b1, b2, b3 ];

end