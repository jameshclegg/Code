function rxData = status( self )
	% STATUS
	% Number of inputs: 1
	%	 Input 1: self.serialObj is an open serial port

	% For use in N/A mode.
	% 6 bytes of rxData

	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 05 February 2014. James Clegg.


serialObj = self.serialObj; 
commandBit = 255; 
rxBytes = 6; 


txData = commandBit;

fwrite( serialObj, txData, 'uint8' ); 

rxData = fread( serialObj, rxBytes ); 

end