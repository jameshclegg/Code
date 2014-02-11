function [ txData, rxData ] = slewXY( self, xABSPOS, yABSPOS, COUNT )
	% SLEWXY
	% Number of inputs: 4
	%	Input 1: self.serialObj is an open serial port
	%	Input 2: xABSPOS is an LEWORD
	%	Input 3: yABSPOS is an LEWORD
	%	Input 4: COUNT is an LEWORD
	% For use in vector mode.
	% Generated automatically by functionWriter class.
	% Source dictionary is at the end of SC2000 command reference document.

	% 11 February 2014. James Clegg.

commandBit = 6; 
rxBytes = 0; 

b1 = self.convert2leWord( xABSPOS );
b2 = self.convert2leWord( yABSPOS );
b3 = self.convert2leWord( COUNT );
txData = [ commandBit, b1, b2, b3 ];

if self.transmit.statusB 
	serialObj = self.serialObj; 
	fwrite( serialObj, txData, 'uint8' ); 
	rxData = []; 
else
	rxData = []; 
end 

end