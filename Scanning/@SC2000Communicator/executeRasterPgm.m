function executeRasterPgm( self, xPGMID, yPGMID )
	% EXECUTERASTERPGM
	% Number of inputs: 3
	%	 Input 1: self.serialObj is an open serial port
	%	 Input 2: xPGMID is an LEWORD
	%	 Input 3: yPGMID is an LEWORD
	% For use in vector mode.

	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 05 February 2014. James Clegg.


serialObj = self.serialObj; 
commandBit = 15; 

b1 = hex2dec( reshape( dec2hex( xPGMID, 4 ), 2, 2 )).';
b2 = hex2dec( reshape( dec2hex( yPGMID, 4 ), 2, 2 )).';

txData = [ commandBit, b1, b2 ];

fwrite( serialObj, txData, 'uint8' ); 

end