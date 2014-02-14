function [ txData, rxData ] = executeRasterPgm( self, xPGMID, yPGMID )
	% EXECUTERASTERPGM
	% Number of inputs: 3
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: xPGMID is an LEWORD
	%	Input 3: yPGMID is an LEWORD
	% For use in vector mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 14 February 2014. James Clegg.

commandBit = 15; 
rxBytes = 0; 

b1 = self.convert2leWord( xPGMID );
b2 = self.convert2leWord( yPGMID );
txData = [ commandBit, b1, b2 ];

if self.transmit.statusB 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = []; 
else
	rxData = []; 
end 

end