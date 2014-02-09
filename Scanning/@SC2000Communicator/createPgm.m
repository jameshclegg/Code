function [ txData, rxData ] = createPgm( self, txrxOpt, PGMTYPE, PGMID )
	% CREATEPGM
	% Number of inputs: 4
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: txrxOpt specifies if you want to transmit and receive data. 
	%	Input 3: PGMTYPE is an LEWORD
	%	Input 4: PGMID is an LEWORD
	% For use in N/A mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 09 February 2014. James Clegg.

commandBit = 33; 
rxBytes = 0; 

b1 = self.convert2leWord( PGMTYPE );
b2 = self.convert2leWord( PGMID );
txData = [ commandBit, b1, b2 ];

if txrxOpt 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = []; 
else 
	rxData = []; 
end 

end