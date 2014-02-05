function exitPgm( self )
	% EXITPGM
	% Number of inputs: 1
	%	 Input 1: self.serialObj is an open serial port

	% For use in vector and raster mode.

	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 05 February 2014. James Clegg.


serialObj = self.serialObj; 
commandBit = 37; 


txData = commandBit;

fwrite( serialObj, txData, 'uint8' ); 

end