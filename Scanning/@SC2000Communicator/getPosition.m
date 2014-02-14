function [ txData, rxData ] = getPosition( self, AXIS )
	% GETPOSITION
	% Number of inputs: 2
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: AXIS is an LEWORD
	% For use in N/A mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 14 February 2014. James Clegg.

commandBit = 42; 
rxBytes = 2; 

b1 = self.convert2leWord( AXIS );
txData = [ commandBit, b1 ];

if self.transmit.statusB 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = fread( serialObj, rxBytes ); 
else
	rxData = []; 
end 

end