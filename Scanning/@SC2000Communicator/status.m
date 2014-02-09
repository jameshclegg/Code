function [ txData, rxData ] = status( self, txrxOpt )
	% STATUS
	% Number of inputs: 2
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: txrxOpt specifies if you want to transmit and receive data. 

	% For use in N/A mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 09 February 2014. James Clegg.

commandBit = 255; 
rxBytes = 6; 

txData = repmat( commandBit, 1, 9 );

if txrxOpt 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = fread( serialObj, rxBytes ); 
else 
	rxData = []; 
end 

end