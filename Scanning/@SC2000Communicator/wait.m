function txData = wait( self, DBLWORD )
	% WAIT
	% Number of inputs: 2
	%	 Input 1: self.serialObj is an open serial port
	%	 Input 2: DBLWORD is an LEDBLWORD
	% For use in vector and raster mode.
	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 07 February 2014. James Clegg.


commandBit = 16; 
b1 = self.convert2leWord( DBLWORD );

txData = [ commandBit, b1 ];

end