function rxData = tempOK( self, DEVICEID )
	% TEMPOK
	% Number of inputs: 2
	%	 Input 1: self.serialObj is an open serial port
	%	 Input 2: DEVICEID is an LEWORD
	% For use in N/A mode.
	% 2 bytes of rxData

	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 05 February 2014. James Clegg.


serialObj = self.serialObj; 
commandBit = 44; 
rxBytes = 2; 

b1 = hex2dec( reshape( dec2hex( DEVICEID, 4 ), 2, 2 ).').';

txData = [ commandBit, b1 ];

fwrite( serialObj, txData, 'uint8' ); 

rxData = fread( serialObj, rxBytes ); 

end