classdef functionFile
    %FUNCTIONFILE
    %
    % 31st January 2014. JHC.
    
    properties
        
        fnName
        nInputs
        decID
        inputParams
        inputParamTypes
        context
        rxDataBytes
        
    end
    
    properties (Access = private)
        
        subDir = '@SC2000Communicator/';
        
        communicatorObjName = 'self';
        serialObjName = 'serialObj';
        rxName = 'rxData';
        rxBytesName = 'rxBytes';
        commandBitName = 'commandBit';
        bitMode = '''uint8''';
        txDataName = 'txData';
        
        fid

    end
    
    methods
        function self = writeFile( self )
            
            %open the file
            self.fid = fopen( sprintf( '%s%s.m', self.subDir, self.fnName ) , 'w' );
            
            writeTopLine( self )
            writeComments( self )
            writeCommands( self )
            
            fprintf( self.fid, 'end' );
                       
            fclose( self.fid );
        end
    end
    
    methods (Access = private)
        function writeTopLine( self )
            
            if self.rxDataBytes == 0
                outputStr = '';
            else
                outputStr = sprintf( '%s = ', self.rxName );
            end
            
            %%%%%%%%%%%%%%%%%%%%
            % print function name
            inputStr = [ ' ', self.communicatorObjName, ', '];
            for ii = 1:self.nInputs
                inputStr = sprintf( '%s%s, ', inputStr, self.inputParams{ii} );
            end
            
            % remove the final comma and the space and add back the space
            inputStr = [inputStr(1:end-2), ' '];
            
            firstLineStr = sprintf( 'function %s%s(%s)\n', outputStr, self.fnName, inputStr );
            fprintf( self.fid, firstLineStr );
            
        end
        
        function writeComments( self )
            
            % print first comments line
            fprintf( self.fid, '\t%% %s\n', upper( self.fnName ) );
            
            % print inputs information to comments
            fprintf( self.fid, '\t%% Number of inputs: %i\n', self.nInputs+1 );
            fprintf( self.fid, '\t%%\t Input 1: self.serialObj is an open serial port\n' );
            if self.nInputs ~=0 
                
                for jj = 1:self.nInputs
                    if regexp( self.inputParamTypes{jj}, '^[aeioAEIOFLHMNRSX]' )
                        article = 'an';
                    else
                        article = 'a';
                    end
                    
                    fprintf( self.fid, '\t%%\t Input %i: %s is %s %s\n', jj+1, self.inputParams{jj}, article, self.inputParamTypes{jj} );
                end
            else
                fprintf( self.fid, '\n' );
            end
            
            % print the context
            fprintf( self.fid, '\t%% For use in %s mode.\n', self.context );
            
            % print the number of bytes to be read
            if self.rxDataBytes ~= 0
                fprintf( self.fid, '\t%% %i bytes of rxData\n\n', self.rxDataBytes);
            else
                fprintf( self.fid, '\n' );
            end
            
            % print info
            fprintf( self.fid, '\t%% Generated automatically by functionFile.m class.\n' );
            fprintf( self.fid, '\t%% Source dictionary is at the end of SC2000 command reference document.\n\n' );
            fprintf( self.fid, '\t%% %s. James Clegg.\n\n\n', datestr( date, 'dd mmmm yyyy' ) );
            
        end
        
        function writeCommands( self )
            
            fprintf( self.fid, '%s = %s.%s; \n', self.serialObjName, self.communicatorObjName, self.serialObjName );
            fprintf( self.fid, '%s = %i; \n', self.commandBitName, self.decID );
            
            if self.rxDataBytes ~= 0
                fprintf( self.fid, '%s = %i; \n\n', self.rxBytesName, self.rxDataBytes );
            else
                fprintf( self.fid, '\n' );
            end
            
            strToWrite = [];
            % one bit to send for each input
            for kk = 1:self.nInputs
                
                fprintf( self.fid, 'b%i = hex2dec( reshape( dec2hex( %s, 4 ), 2, 2 ).'').'';\n' , kk, self.inputParams{kk});
                strToWrite = sprintf( '%s, b%i', strToWrite, kk );
            
            end
            fprintf( self.fid, '\n' );
            
            %remove first comma
            strToWrite = strToWrite(2:end);
            
            if self.nInputs ~= 0
                fprintf( self.fid, '%s = [ %s,%s ];\n\n', self.txDataName, self.commandBitName, strToWrite );
            else
                fprintf( self.fid, '%s = %s;\n\n', self.txDataName, self.commandBitName );
            end
            fprintf( self.fid, 'fwrite( %s, %s, %s ); \n\n', self.serialObjName, self.txDataName, self.bitMode );
             
            % if there is an output, read it from the serial port
            if self.rxDataBytes ~= 0
                fprintf( self.fid, '%s = fread( %s, %s ); \n\n', self.rxName, self.serialObjName, self.rxBytesName );
            end
            
        end
        
    end
    
end

