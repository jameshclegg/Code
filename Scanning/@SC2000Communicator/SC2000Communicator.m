classdef SC2000Communicator
    %SC2000COMMUNICATOR is a class for talking to the SC2000 scan control
    %board
    %   
    % 31.01.14. James Clegg.
    
    properties
        
        baudRate = 115200;
        
        serialObj
        
        commandTable
        commandList
        
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
            
            % set up command information table
            cMaker = SC2000commandMaker();
            
            self.commandTable = cMaker.commandTable;
            self.commandList = cMaker.newNameList;
            
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
        
        function varargout = exec( self, commandName, varargin )
            
            l = self.commandList;
            t = self.commandTable;
            
            % find commandName in commandInfoTable
            rowID = find( strcmpi( l, commandName ), 1 );
            
            % find out how many inputs and outputs are needed
            nIn = str2double( t{ rowID, 2 });
            nOut = str2double( t{ rowID, 6 });
            
            % check if length of varargin is the same as number of inputs
            % needed
            if numel( varargin ) ~= nIn
                error( 'Wrong number of inputs' )
            end
            
            % call the self.'commandName' with the supplied inputs
            % continue here on 10 Feb 2013.
            txData = eval( sprintf('self.%s()',varargin ) );
            % write txData to the device
            
            % if the command has a return value then read it to varargout
            
        end
    end
    
    methods (Static, Access = private)
        function y = convert2leWord( x )
           
            % first deal with the sign
            if x >= 0
                y=x;
            else
                y = 2^16 + x;
            end
            
            % now convert to a two element decimal
            y = [ floor( y/256 ), mod( y, 256 ) ];
            
        end 
    end
    
end

