function [ txData, rxData ] = abortPgm( self, txrxOpt )
	% ABORTPGM
	% Number of inputs: 2
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: txrxOpt specifies if you want to transmit and receive data. 

	% For use in vector and raster mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 09 February 2014. James Clegg.

commandBit = 32; 
rxBytes = 0; 

txData = commandBit;

if txrxOpt 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = []; 
else 
	rxData = []; 
end 

end