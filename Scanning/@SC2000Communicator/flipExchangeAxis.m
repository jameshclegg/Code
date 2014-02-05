function flipExchangeAxis( self, BOOL, BOOL, BOOL )
	% FLIPEXCHANGEAXIS
	% Number of inputs: 4
	%	 Input 1: self.serialObj is an open serial port
	%	 Input 2: BOOL is an LEWORD
	%	 Input 3: BOOL is an LEWORD
	%	 Input 4: BOOL is an LEWORD
	% For use in vector and raster mode.

	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 05 February 2014. James Clegg.


serialObj = self.serialObj; 
commandBit = 62; 

b1 = hex2dec( reshape( dec2hex( BOOL, 4 ), 2, 2 ).').';
b2 = hex2dec( reshape( dec2hex( BOOL, 4 ), 2, 2 ).').';
b3 = hex2dec( reshape( dec2hex( BOOL, 4 ), 2, 2 ).').';

txData = [ commandBit, b1, b2, b3 ];

fwrite( serialObj, txData, 'uint8' ); 

end