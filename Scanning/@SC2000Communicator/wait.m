function [ txData, rxData ] = wait( self, DBLWORD )
	% WAIT
	% Number of inputs: 2
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: DBLWORD is an LEDBLWORD
	% For use in vector and raster mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 14 February 2014. James Clegg.

commandBit = 16; 
rxBytes = 0; 

b1 = self.convert2meWord( DBLWORD );
txData = [ commandBit, b1 ];

if self.transmit.statusB 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = []; 
else
	rxData = []; 
end 

end