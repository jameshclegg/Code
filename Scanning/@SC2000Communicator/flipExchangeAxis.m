function [ txData, rxData ] = flipExchangeAxis( self, txrxOpt, BOOL, BOOL, BOOL )
	% FLIPEXCHANGEAXIS
	% Number of inputs: 5
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: txrxOpt specifies if you want to transmit and receive data. 
	%	Input 3: BOOL is an LEWORD
	%	Input 4: BOOL is an LEWORD
	%	Input 5: BOOL is an LEWORD
	% For use in vector and raster mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 10 February 2014. James Clegg.

commandBit = 62; 
rxBytes = 0; 

b1 = self.convert2leWord( BOOL );
b2 = self.convert2leWord( BOOL );
b3 = self.convert2leWord( BOOL );
txData = [ commandBit, b1, b2, b3 ];

if txrxOpt 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = []; 
else 
	rxData = []; 
end 

end