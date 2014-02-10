function [ txData, rxData ] = slewXY( self, txrxOpt, xABSPOS, yABSPOS, COUNT )
	% SLEWXY
	% Number of inputs: 5
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: txrxOpt specifies if you want to transmit and receive data. 
	%	Input 3: xABSPOS is an LEWORD
	%	Input 4: yABSPOS is an LEWORD
	%	Input 5: COUNT is an LEWORD
	% For use in vector mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 10 February 2014. James Clegg.

commandBit = 6; 
rxBytes = 0; 

b1 = self.convert2leWord( xABSPOS );
b2 = self.convert2leWord( yABSPOS );
b3 = self.convert2leWord( COUNT );
txData = [ commandBit, b1, b2, b3 ];

if txrxOpt 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = []; 
else 
	rxData = []; 
end 

end