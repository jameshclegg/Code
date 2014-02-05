function comConfig( self, BAUD, DATABITS, STOPBITS, PARITY, COMTYPE )
	% COMCONFIG
	% Number of inputs: 6
	%	 Input 1: self.serialObj is an open serial port
	%	 Input 2: BAUD is an LEWORD
	%	 Input 3: DATABITS is an LEWORD
	%	 Input 4: STOPBITS is an LEWORD
	%	 Input 5: PARITY is an LEWORD
	%	 Input 6: COMTYPE is an LEWORD
	% For use in vector and raster mode.

	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 05 February 2014. James Clegg.


serialObj = self.serialObj; 
commandBit = 35; 

b1 = hex2dec( reshape( dec2hex( BAUD, 4 ), 2, 2 ).').';
b2 = hex2dec( reshape( dec2hex( DATABITS, 4 ), 2, 2 ).').';
b3 = hex2dec( reshape( dec2hex( STOPBITS, 4 ), 2, 2 ).').';
b4 = hex2dec( reshape( dec2hex( PARITY, 4 ), 2, 2 ).').';
b5 = hex2dec( reshape( dec2hex( COMTYPE, 4 ), 2, 2 ).').';

txData = [ commandBit, b1, b2, b3, b4, b5 ];

fwrite( serialObj, txData, 'uint8' ); 

end