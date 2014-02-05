function deltaTweakAxisXY( self, xGAIN, xRELOFFSET, yGAIN, yRELOFFSET )
	% DELTATWEAKAXISXY
	% Number of inputs: 5
	%	 Input 1: self.serialObj is an open serial port
	%	 Input 2: xGAIN is an LEWORD
	%	 Input 3: xRELOFFSET is an LEWORD
	%	 Input 4: yGAIN is an LEWORD
	%	 Input 5: yRELOFFSET is an LEWORD
	% For use in vector mode.

	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 05 February 2014. James Clegg.


serialObj = self.serialObj; 
commandBit = 24; 

b1 = hex2dec( reshape( dec2hex( xGAIN, 4 ), 2, 2 ).').';
b2 = hex2dec( reshape( dec2hex( xRELOFFSET, 4 ), 2, 2 ).').';
b3 = hex2dec( reshape( dec2hex( yGAIN, 4 ), 2, 2 ).').';
b4 = hex2dec( reshape( dec2hex( yRELOFFSET, 4 ), 2, 2 ).').';

txData = [ commandBit, b1, b2, b3, b4 ];

fwrite( serialObj, txData, 'uint8' ); 

end