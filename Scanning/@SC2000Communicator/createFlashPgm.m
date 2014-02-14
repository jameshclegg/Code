function [ txData, rxData ] = createFlashPgm( self, PGMTYPE, PGMID )
	% CREATEFLASHPGM
	% Number of inputs: 3
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: PGMTYPE is an LEWORD
	%	Input 3: PGMID is an LEWORD
	% For use in N/A mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 14 February 2014. James Clegg.

commandBit = 30; 
rxBytes = 0; 

b1 = self.convert2leWord( PGMTYPE );
b2 = self.convert2leWord( PGMID );
txData = [ commandBit, b1, b2 ];

if self.transmit.statusB 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = []; 
else
	rxData = []; 
end 

end