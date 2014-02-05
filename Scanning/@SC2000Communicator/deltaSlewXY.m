function deltaSlewXY( self, xRELOFFSET, yRELOFFSET, COUNT )
	% DELTASLEWXY
	% Number of inputs: 4
	%	 Input 1: self.serialObj is an open serial port
	%	 Input 2: xRELOFFSET is an LEWORD
	%	 Input 3: yRELOFFSET is an LEWORD
	%	 Input 4: COUNT is an LEWORD
	% For use in vector mode.

	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 05 February 2014. James Clegg.


serialObj = self.serialObj; 
commandBit = 8; 

b1 = hex2dec( reshape( dec2hex( xRELOFFSET, 4 ), 2, 2 ).').';
b2 = hex2dec( reshape( dec2hex( yRELOFFSET, 4 ), 2, 2 ).').';
b3 = hex2dec( reshape( dec2hex( COUNT, 4 ), 2, 2 ).').';

txData = [ commandBit, b1, b2, b3 ];

fwrite( serialObj, txData, 'uint8' ); 

end