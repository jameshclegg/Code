function rxData = status( self )
	% STATUS
	% Number of inputs: 1
	%	 Input 1: self.serialObj is an open serial port

	% For use in N/A mode.
	% 6 bytes of rxData

	% Generated automatically by functionFile.m class, then edited by me
	% because this command has a peculiar requirement to send the FF byte 8
	% times.
    
	% Source dictionary is at the end of SC2000 command reference document.

	% 05 February 2014. James Clegg.


serialObj = self.serialObj; 
commandBit = 255; 
rxBytes = 6; 


txData = repmat( commandBit, 1, 9 );

fwrite( serialObj, txData, 'uint8' ); 

rxData = fread( serialObj, rxBytes ); 

end