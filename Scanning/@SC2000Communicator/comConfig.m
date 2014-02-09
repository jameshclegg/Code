function [ txData, rxData ] = comConfig( self, txrxOpt, BAUD, DATABITS, STOPBITS, PARITY, COMTYPE )
	% COMCONFIG
	% Number of inputs: 7
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: txrxOpt specifies if you want to transmit and receive data. 
	%	Input 3: BAUD is an LEWORD
	%	Input 4: DATABITS is an LEWORD
	%	Input 5: STOPBITS is an LEWORD
	%	Input 6: PARITY is an LEWORD
	%	Input 7: COMTYPE is an LEWORD
	% For use in vector and raster mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 09 February 2014. James Clegg.

commandBit = 35; 
rxBytes = 0; 

b1 = self.convert2leWord( BAUD );
b2 = self.convert2leWord( DATABITS );
b3 = self.convert2leWord( STOPBITS );
b4 = self.convert2leWord( PARITY );
b5 = self.convert2leWord( COMTYPE );
txData = [ commandBit, b1, b2, b3, b4, b5 ];

if txrxOpt 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = []; 
else 
	rxData = []; 
end 

end