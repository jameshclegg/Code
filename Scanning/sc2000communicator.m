classdef sc2000communicator
    %SC2000COMMUNICATOR is a class for talking to the SC2000 scan control
    %board
    %   
    % 31.01.14. James Clegg.
    
    properties
        initialBaudRate = 2400;
        baudRate = '7';
        
        dictionary
        
        serialObj
    end
    
    properties (SetAccess = private)
        lastTx
        lastRx
    end
    
    methods
        function self = sc2000communicator()
            % constructor method.
            
            self.serialObj = serial( 'COM1', 'BaudRate', 2400 );
            set( self.serialObj, 'FlowControl', 'software' );
            set( self.serialObj, 'TimeOut', 1);
            
        end
        
        function self = openConnection( self )
            
           fopen( self.serialObj );
           fprintf( 'Serial port is %s\n' , get( self.serialObj, 'Status' ))
           
        end
        
        function self = setBaudRate( self, newRate )
            
           fprintf( 'Setting baud rate to %i\n', newRate )
           comConfig = sprintf( '23000%s00080001000000E8', newRate );
           self = writeData( self, comConfig );
           set( self.serialObj, 'BaudRate', 115200 );
           
        end
        
        function self = closeConnection( self )
            
            fclose( self.serialObj );
            delete( self.serialObj );
            
        end
        
        function self = writeData( self, hexInput )
            % hexInput is a string - we must convert it into hex pairs for
            % conversion to 8 bit integers.
            hexInput = reshape( hexInput, 2, numel(hexInput)/2 ).';
            
            txData = hex2dec( hexInput ).';
            
            self.lastTx = txData;   
            
            fwrite( self.serialObj, txData, 'uint8' );
            
        end
        
        function self = readData( self )
            
            rxData = fread( self.serialObj );
            
            self.lastRx = rxData;
            
        end
    end
    
end

