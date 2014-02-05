function unSetSync( self, CHANID )
	% UNSETSYNC
	% Number of inputs: 2
	%	 Input 1: self.serialObj is an open serial port
	%	 Input 2: CHANID is an LEWORD
	% For use in vector and raster mode.

	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 05 February 2014. James Clegg.


serialObj = self.serialObj; 
commandBit = 19; 

b1 = hex2dec( reshape( dec2hex( CHANID, 4 ), 2, 2 )).';

txData = [ commandBit, b1 ];

fwrite( serialObj, txData, 'uint8' ); 

end