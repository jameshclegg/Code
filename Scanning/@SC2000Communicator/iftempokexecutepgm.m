function iftempokexecutepgm( self, DEVICEID, PGMID )
	% IFTEMPOKEXECUTEPGM
	% Number of inputs: 3
	%	 Input 1: self.serialObj is an open serial port
	%	 Input 2: DEVICEID is an LEWORD
	%	 Input 3: PGMID is an LEWORD
	% For use in vector and raster mode.

	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 05 February 2014. James Clegg.


serialObj = self.serialObj; 
commandBit = 12; 

b1 = hex2dec( reshape( dec2hex( DEVICEID, 4 ), 2, 2 )).';
b2 = hex2dec( reshape( dec2hex( PGMID, 4 ), 2, 2 )).';

txData = [ commandBit, b1, b2 ];

fwrite( serialObj, txData, 'uint8' ); 

end