function txData = deltaPositionXY( self, xRELOFFSET, yRELOFFSET )
	% DELTAPOSITIONXY
	% Number of inputs: 3
	%	 Input 1: self.serialObj is an open serial port
	%	 Input 2: xRELOFFSET is an LEWORD
	%	 Input 3: yRELOFFSET is an LEWORD
	% For use in vector mode.
	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 07 February 2014. James Clegg.


commandBit = 4; 
b1 = self.convert2leWord( xRELOFFSET );
b2 = self.convert2leWord( yRELOFFSET );

txData = [ commandBit, b1, b2 ];

end