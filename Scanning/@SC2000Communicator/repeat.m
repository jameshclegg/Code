function [ txData, rxData ] = repeat( self )
	% REPEAT
	% Number of inputs: 1
	%	Input 1: self.serialObj is an open serial port

	% For use in vector and raster mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 14 February 2014. James Clegg.

commandBit = 9; 
rxBytes = 0; 

txData = commandBit;

if self.transmit.statusB 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = []; 
else
	rxData = []; 
end 

end