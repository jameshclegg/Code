function [ txData, rxData ] = delayedUnsetSync( self, CHANID )
	% DELAYEDUNSETSYNC
	% Number of inputs: 2
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: CHANID is an LEWORD
	% For use in vector and raster mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 11 February 2014. James Clegg.

commandBit = 55; 
rxBytes = 0; 

b1 = self.convert2leWord( CHANID );
txData = [ commandBit, b1 ];

if self.transmit.statusB 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = []; 
else
	rxData = []; 
end 

end