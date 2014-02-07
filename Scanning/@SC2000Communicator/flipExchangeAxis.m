function txData = flipExchangeAxis( self, BOOL, BOOL, BOOL )
	% FLIPEXCHANGEAXIS
	% Number of inputs: 4
	%	 Input 1: self.serialObj is an open serial port
	%	 Input 2: BOOL is an LEWORD
	%	 Input 3: BOOL is an LEWORD
	%	 Input 4: BOOL is an LEWORD
	% For use in vector and raster mode.
	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 07 February 2014. James Clegg.


commandBit = 62; 
b1 = self.convert2leWord( BOOL );
b2 = self.convert2leWord( BOOL );
b3 = self.convert2leWord( BOOL );

txData = [ commandBit, b1, b2, b3 ];

end