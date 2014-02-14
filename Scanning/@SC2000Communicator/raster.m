function [ txData, rxData ] = raster( self, RASTERVAL )
	% RASTER
	% Number of inputs: 2
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: RASTERVAL is an LEWORD
	% For use in N/A mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 14 February 2014. James Clegg.

commandBit = 25; 
rxBytes = 0; 

b1 = self.convert2leWord( RASTERVAL );
txData = [ commandBit, b1 ];

if self.transmit.statusB 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = []; 
else
	rxData = []; 
end 

end