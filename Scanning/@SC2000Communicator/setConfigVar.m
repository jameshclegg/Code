function txData = setConfigVar( self, xWORD, yWORD )
	% SETCONFIGVAR
	% Number of inputs: 3
	%	 Input 1: self.serialObj is an open serial port
	%	 Input 2: xWORD is an LEWORD
	%	 Input 3: yWORD is an LEWORD
	% For use in N/A mode.
	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 07 February 2014. James Clegg.


commandBit = 48; 
b1 = self.convert2leWord( xWORD );
b2 = self.convert2leWord( yWORD );

txData = [ commandBit, b1, b2 ];

end