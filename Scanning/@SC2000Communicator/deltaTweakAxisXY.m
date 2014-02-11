function [ txData, rxData ] = deltaTweakAxisXY( self, xGAIN, xRELOFFSET, yGAIN, yRELOFFSET )
	% DELTATWEAKAXISXY
	% Number of inputs: 5
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: xGAIN is an LEWORD
	%	Input 3: xRELOFFSET is an LEWORD
	%	Input 4: yGAIN is an LEWORD
	%	Input 5: yRELOFFSET is an LEWORD
	% For use in vector mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 11 February 2014. James Clegg.

commandBit = 24; 
rxBytes = 0; 

b1 = self.convert2leWord( xGAIN );
b2 = self.convert2leWord( xRELOFFSET );
b3 = self.convert2leWord( yGAIN );
b4 = self.convert2leWord( yRELOFFSET );
txData = [ commandBit, b1, b2, b3, b4 ];

if self.transmit.statusB 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = []; 
else
	rxData = []; 
end 

end