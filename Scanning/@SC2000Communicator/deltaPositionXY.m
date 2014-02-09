function [ txData, rxData ] = deltaPositionXY( self, txrxOpt, xRELOFFSET, yRELOFFSET )
	% DELTAPOSITIONXY
	% Number of inputs: 4
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: txrxOpt specifies if you want to transmit and receive data. 
	%	Input 3: xRELOFFSET is an LEWORD
	%	Input 4: yRELOFFSET is an LEWORD
	% For use in vector mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 09 February 2014. James Clegg.

commandBit = 4; 
rxBytes = 0; 

b1 = self.convert2leWord( xRELOFFSET );
b2 = self.convert2leWord( yRELOFFSET );
txData = [ commandBit, b1, b2 ];

if txrxOpt 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = []; 
else 
	rxData = []; 
end 

end