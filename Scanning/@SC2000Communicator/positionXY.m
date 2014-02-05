function positionXY( self, xABSPOS, yABSPOS )
	% POSITIONXY
	% Number of inputs: 3
	%	 Input 1: self.serialObj is an open serial port
	%	 Input 2: xABSPOS is an LEWORD
	%	 Input 3: yABSPOS is an LEWORD
	% For use in vector mode.

	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 05 February 2014. James Clegg.


serialObj = self.serialObj; 
commandBit = 2; 

b1 = hex2dec( reshape( dec2hex( xABSPOS, 4 ), 2, 2 )).';
b2 = hex2dec( reshape( dec2hex( yABSPOS, 4 ), 2, 2 )).';

txData = [ commandBit, b1, b2 ];

fwrite( serialObj, txData, 'uint8' ); 

end