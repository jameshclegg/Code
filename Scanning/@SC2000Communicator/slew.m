function [ txData, rxData ] = slew( self, ABSPOS, COUNT )
	% SLEW
	% Number of inputs: 3
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: ABSPOS is an LEWORD
	%	Input 3: COUNT is an LEWORD
	% For use in raster mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 14 February 2014. James Clegg.

commandBit = 5; 
rxBytes = 0; 

b1 = self.convert2leWord( ABSPOS );
b2 = self.convert2leWord( COUNT );
txData = [ commandBit, b1, b2 ];

if self.transmit.statusB 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = []; 
else
	rxData = []; 
end 

end