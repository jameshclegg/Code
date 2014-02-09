function [ txData, rxData ] = tempOK( self, txrxOpt, DEVICEID )
	% TEMPOK
	% Number of inputs: 3
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: txrxOpt specifies if you want to transmit and receive data. 
	%	Input 3: DEVICEID is an LEWORD
	% For use in N/A mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 09 February 2014. James Clegg.

commandBit = 44; 
rxBytes = 2; 

b1 = self.convert2leWord( DEVICEID );
txData = [ commandBit, b1 ];

if txrxOpt 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = fread( serialObj, rxBytes ); 
else 
	rxData = []; 
end 

end