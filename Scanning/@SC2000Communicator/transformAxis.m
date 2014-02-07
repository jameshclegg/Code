function txData = transformAxis( self, xROTA, xROTB, yROTB, yROTA )
	% TRANSFORMAXIS
	% Number of inputs: 5
	%	 Input 1: self.serialObj is an open serial port
	%	 Input 2: xROTA is an LEWORD
	%	 Input 3: xROTB is an LEWORD
	%	 Input 4: yROTB is an LEWORD
	%	 Input 5: yROTA is an LEWORD
	% For use in vector mode.
	% Generated automatically by functionFile.m class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 07 February 2014. James Clegg.


commandBit = 63; 
b1 = self.convert2leWord( xROTA );
b2 = self.convert2leWord( xROTB );
b3 = self.convert2leWord( yROTB );
b4 = self.convert2leWord( yROTA );

txData = [ commandBit, b1, b2, b3, b4 ];

end