function txData = deltaPosition( self, RELOFFSET )
	% DELTAPOSITION
	% Number of inputs: 2
	%	 Input 1: self.serialObj is an open serial port
	%	 Input 2: RELOFFSET is an LEWORD
	% For use in raster mode.
	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 07 February 2014. James Clegg.


commandBit = 3; 
b1 = self.convert2leWord( RELOFFSET );

txData = [ commandBit, b1 ];

end