clear all
close all

%try

obj1 = serial( 'COM1', 'BaudRate', 2400 );
%obj1 = fopen( 'outputFileTest.txt' , 'w+' );

if isa( obj1, 'serial' )
    set( obj1, 'ByteOrder', 'bigEndian' );
    set( obj1, 'FlowControl', 'software' );
    set( obj1, 'TimeOut', 1);
end

txdata = '29';
txdata_dec = hex2dec( txdata );

fopen( obj1 );
fwrite( obj1, txdata_dec, 'uint8' );
rxdata_dec = fread( obj1, 6 );
disp( rxdata_dec );

%rxdata = dec2hex( rxdata_dec );

fwrite( obj1, hex2dec( ['14'] ), 'uint8' );
fwrite( obj1, hex2dec( ['00'] ), 'uint8' );
fwrite( obj1, hex2dec( ['01'] ), 'uint8' );

fclose( obj1 );

%catch
%    fclose( obj1 );
%end
if isa( obj1, 'serial' )
    delete( obj1 );
end

clear obj1
