function txData = iftempokexecutepgm( self, DEVICEID, PGMID )
	% IFTEMPOKEXECUTEPGM
	% Number of inputs: 3
	%	 Input 1: self.serialObj is an open serial port
	%	 Input 2: DEVICEID is an LEWORD
	%	 Input 3: PGMID is an LEWORD
	% For use in vector and raster mode.
	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 07 February 2014. James Clegg.


commandBit = 12; 
b1 = self.convert2leWord( DEVICEID );
b2 = self.convert2leWord( PGMID );

txData = [ commandBit, b1, b2 ];

end