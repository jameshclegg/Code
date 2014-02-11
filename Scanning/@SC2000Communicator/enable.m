function [ txData, rxData ] = enable( self, DEVICEID )
	% ENABLE
	% Number of inputs: 2
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: DEVICEID is an LEWORD
	% For use in vector and raster mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 11 February 2014. James Clegg.

commandBit = 20; 
rxBytes = 0; 

b1 = self.convert2leWord( DEVICEID );
txData = [ commandBit, b1 ];

if self.transmit.statusB 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = []; 
else
	rxData = []; 
end 

end