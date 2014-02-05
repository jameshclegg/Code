function tweakAxis( self, GAIN, RELOFFSET )
	% TWEAKAXIS
	% Number of inputs: 3
	%	 Input 1: self.serialObj is an open serial port
	%	 Input 2: GAIN is an LEWORD
	%	 Input 3: RELOFFSET is an LEWORD
	% For use in raster mode.

	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 05 February 2014. James Clegg.


serialObj = self.serialObj; 
commandBit = 27; 

b1 = hex2dec( reshape( dec2hex( GAIN, 4 ), 2, 2 ).').';
b2 = hex2dec( reshape( dec2hex( RELOFFSET, 4 ), 2, 2 ).').';

txData = [ commandBit, b1, b2 ];

fwrite( serialObj, txData, 'uint8' ); 

end