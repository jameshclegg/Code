function writeToSC2000( hexInput )

% mess about with the string input to get it into the right form
hexInput = reshape( hexInput, 2, numel(hexInput)/2 ).';

obj1 = serial( 'COM1', 'BaudRate', 2400 );
%obj1 = fopen( 'outputFileTest.txt' , 'w+' );

if 1
    set( obj1, 'ByteOrder', 'bigEndian' );
    set( obj1, 'FlowControl', 'software' );
    set( obj1, 'TimeOut', 1);
end

fopen( obj1 );

fwrite( obj1, hex2dec( hexInput ).', 'uint8' );

fclose( obj1 );

delete( obj1 );

end