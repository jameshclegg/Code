function [ txData, rxData ] = ifexecuterasterpgm( self, txrxOpt, CHANID, xPGMID, yPGMID )
	% IFEXECUTERASTERPGM
	% Number of inputs: 5
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: txrxOpt specifies if you want to transmit and receive data. 
	%	Input 3: CHANID is an LEWORD
	%	Input 4: xPGMID is an LEWORD
	%	Input 5: yPGMID is an LEWORD
	% For use in vector mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 09 February 2014. James Clegg.

commandBit = 11; 
rxBytes = 0; 

b1 = self.convert2leWord( CHANID );
b2 = self.convert2leWord( xPGMID );
b3 = self.convert2leWord( yPGMID );
txData = [ commandBit, b1, b2, b3 ];

if txrxOpt 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = []; 
else 
	rxData = []; 
end 

end