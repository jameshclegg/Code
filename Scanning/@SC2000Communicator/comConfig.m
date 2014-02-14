function [ txData, rxData ] = comConfig( self, BAUD, DATABITS, STOPBITS, PARITY, COMTYPE )
	% COMCONFIG
	% Number of inputs: 6
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: BAUD is an LEWORD
	%	Input 3: DATABITS is an LEWORD
	%	Input 4: STOPBITS is an LEWORD
	%	Input 5: PARITY is an LEWORD
	%	Input 6: COMTYPE is an LEWORD
	% For use in vector and raster mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 14 February 2014. James Clegg.

commandBit = 35; 
rxBytes = 0; 

b1 = self.convert2leWord( BAUD );
b2 = self.convert2leWord( DATABITS );
b3 = self.convert2leWord( STOPBITS );
b4 = self.convert2leWord( PARITY );
b5 = self.convert2leWord( COMTYPE );
txData = [ commandBit, b1, b2, b3, b4, b5 ];

if self.transmit.statusB 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = []; 
else
	rxData = []; 
end 

end