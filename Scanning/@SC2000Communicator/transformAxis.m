function transformAxis( self, xROTA, xROTB, yROTB, yROTA )
	% TRANSFORMAXIS
	% Number of inputs: 5
	%	 Input 1: self.serialObj is an open serial port
	%	 Input 2: xROTA is an LEWORD
	%	 Input 3: xROTB is an LEWORD
	%	 Input 4: yROTB is an LEWORD
	%	 Input 5: yROTA is an LEWORD
	% For use in vector mode.

	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 05 February 2014. James Clegg.


serialObj = self.serialObj; 
commandBit = 63; 

b1 = hex2dec( reshape( dec2hex( xROTA, 4 ), 2, 2 ).').';
b2 = hex2dec( reshape( dec2hex( xROTB, 4 ), 2, 2 ).').';
b3 = hex2dec( reshape( dec2hex( yROTB, 4 ), 2, 2 ).').';
b4 = hex2dec( reshape( dec2hex( yROTA, 4 ), 2, 2 ).').';

txData = [ commandBit, b1, b2, b3, b4 ];

fwrite( serialObj, txData, 'uint8' ); 

end