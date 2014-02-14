function [ txData, rxData ] = setGSS( self, GSS )
	% SETGSS
	% Number of inputs: 2
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: GSS is an LEWORD
	% For use in N/A mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 14 February 2014. James Clegg.

commandBit = 48; 
rxBytes = 0; 

b1 = self.convert2leWord( GSS );
txData = [ commandBit, b1 ];

if self.transmit.statusB 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = []; 
else
	rxData = []; 
end 

end