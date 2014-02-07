function txData = dumpDataMem( self, WORD )
	% DUMPDATAMEM
	% Number of inputs: 2
	%	 Input 1: self.serialObj is an open serial port
	%	 Input 2: WORD is an LEWORD
	% For use in N/A mode.
	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 07 February 2014. James Clegg.


commandBit = 61; 
b1 = self.convert2leWord( WORD );

txData = [ commandBit, b1 ];

end