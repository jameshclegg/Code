classdef SC2000Communicator
    %SC2000COMMUNICATOR is a class for talking to the SC2000 scan control
    %board
    %   
    % 31.01.14. James Clegg.
    
    properties
        baudRate = 115200;
        
        serialObj
    end
    
    properties (Access = private)
        initialBaudRate = 2400;
    end
    
    methods
        function self = SC2000Communicator()
            % constructor method.
            
            sObjs = instrfind( 'Port', 'COM1' );
            if ~isempty( sObjs )
                fclose( sObjs );
                delete( sObjs );
            end
                        
            self.serialObj = serial( 'COM1', 'BaudRate', 2400 );
            set( self.serialObj, 'FlowControl', 'hardware' );
            set( self.serialObj, 'TimeOut', 1);
            
        end
        
        function self = open( self )
            
           fopen( self.serialObj );
           fprintf( 'Serial port is %s\n' , get( self.serialObj, 'Status' ))
           
        end
        
        function self = setBaudRate( self, newRateDec )
           
           baudRates = 2400*[1 2 4 8 16 24 48];
           baudBytes =  num2str( (1:7).' );
           
           newRateByte = str2double( baudBytes(  baudRates==newRateDec ) );
            
           fprintf( 'Setting baud rate to %i, id %i\n', newRateDec, newRateByte )

           self.comConfig( newRateByte, 8, 1, 0, 232 );
           
           set( self.serialObj, 'BaudRate', newRateDec );
           
        end
        
        function self = close( self )
            fclose( self.serialObj );
        end
        
        function self = delete( self )
            delete( self.serialObj ) 
        end
                
    end
    
end

