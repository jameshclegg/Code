function [ txData, rxData ] = tweakAxisXY( self, txrxOpt, xGAIN, xRELOFFSET, yGAIN, yRELOFFSET )
	% TWEAKAXISXY
	% Number of inputs: 6
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: txrxOpt specifies if you want to transmit and receive data. 
	%	Input 3: xGAIN is an LEWORD
	%	Input 4: xRELOFFSET is an LEWORD
	%	Input 5: yGAIN is an LEWORD
	%	Input 6: yRELOFFSET is an LEWORD
	% For use in vector mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 09 February 2014. James Clegg.

commandBit = 28; 
rxBytes = 0; 

b1 = self.convert2leWord( xGAIN );
b2 = self.convert2leWord( xRELOFFSET );
b3 = self.convert2leWord( yGAIN );
b4 = self.convert2leWord( yRELOFFSET );
txData = [ commandBit, b1, b2, b3, b4 ];

if txrxOpt 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = []; 
else 
	rxData = []; 
end 

end