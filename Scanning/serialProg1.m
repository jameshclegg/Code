clear all
close all
clc

obj1 = serial( 'COM1', 'BaudRate', 2400 );


opt = 'file';
%opt = 'port';

%set( obj1, 'BaudRate', 2400 );
%set( obj1, 'ByteOrder', 'bigEndian' );
%set( obj1, 'FlowControl', 'software' );

fopen( obj1 );
file1 = fopen( 'outputFileTest.txt' , 'w+' );

txdata = '29';

%Convert to decimal format

txdata_dec = hex2dec( txdata );

%Write using the UINT8 data format

if strcmp( opt, 'port' )
    
    fwrite( obj1, txdata_dec, 'uint8' );
    rxdata_dec = fread( obj1 );
    
else
    
    fwrite( file1, txdata_dec, 'uint8' );
    rxdata_dec = fread( file1 );
    
end

% Convert data back to hexadecimal format

rxdata = dec2hex( rxdata_dec );

fclose( obj1 );

delete( obj1 );

clear obj1
