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
        readback
        
    end
    
    properties (Access = private)
        
        subDir = 'dictionary/';
        
        serialObjName = 'serialObj';
        outputName = 'rxData';
        commandBitName = 'commandBit';
        bitMode = '''uint8''';
        txDataName = 'txData';

    end
    
    methods
        function self = writeFile( self )
            
            %open the file
            fid = fopen( sprintf( '%s%s.m', self.subDir, self.fnName ) , 'w' );
            
            if self.readback == 0
                outputStr = '';
            else
                outputStr = sprintf( '%s = ', self.outputName );
            end
            
            %%%%%%%%%%%%%%%%%%%%
            % print function name
            inputStr = [ ' ', self.serialObjName, ', '];
            for ii = 1:self.nInputs
                inputStr = sprintf( '%s%s, ', inputStr, self.inputParams{ii} );
            end
            
            % remove the final comma and the space and add back the space
            inputStr = [inputStr(1:end-2), ' '];
            
            firstLineStr = sprintf( 'function %s%s(%s)\n', outputStr, self.fnName, inputStr );
            fprintf( fid, firstLineStr );
            
            %%%%%%%%%%%%%%%%%%%%
            % print comments
            
            % print first comments line
            fprintf( fid, '\t%% %s\n', upper( self.fnName ) );
            
            % print inputs information to comments
            fprintf( fid, '\t%% Number of inputs: %i\n', self.nInputs+1 );
            fprintf( fid, '\t%%\t Input 1: serial port object in open state\n' );
            if self.nInputs ~=0 
                
                for jj = 1:self.nInputs
                    if regexp( self.inputParamTypes{jj}, '^[aeioAEIOFLHMNRSX]' )
                        article = 'an';
                    else
                        article = 'a';
                    end
                    
                    fprintf( fid, '\t%%\t Input %i: %s is %s %s\n', jj+1, self.inputParams{jj}, article, self.inputParamTypes{jj} );
                end
            else
                fprintf( fid, '\n' );
            end
            
            % print the context
            fprintf( fid, '\t%% For use in %s mode.\n', self.context );
            
            % print the number of bytes to be read
            if self.readback ~= 0
                fprintf( fid, '\t%% %i bytes of rxData\n\n', self.readback);
            else
                fprintf( fid, '\n' );
            end
            
            % print info
            fprintf( fid, '\t%% Generated automatically using functionFile.m class.\n' );
            fprintf( fid, '\t%% Source dictionary is at the end of SC2000 command reference document.\n\n' );
            fprintf( fid, '\t%% %s. James Clegg.\n\n\n', datestr( date, 'dd mmmm yyyy' ) );
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%
            % print the commands
            
            fprintf( fid, '%s = %i; \n\n', self.commandBitName, self.decID );
            
            strToWrite = [];
            % one bit to send for each input
            for kk = 1:self.nInputs
                
                fprintf( fid, 'b%i = hex2dec( reshape( dec2hex( %s, 4 ), 2, 2 )).'';\n' , kk, self.inputParams{kk});
                strToWrite = sprintf( '%s, b%i', strToWrite, kk );
            
            end
            fprintf( fid, '\n' );
            %remove first comma
            strToWrite = strToWrite(2:end);
            
            if self.nInputs ~= 0
                fprintf( fid, '%s = [ %s,%s ];\n\n', self.txDataName, self.commandBitName, strToWrite );
            else
                fprintf( fid, '%s = %i;\n\n', self.txDataName, self.decID );
            end
            fprintf( fid, 'fwrite( %s, %s, %s ); \n\n', self.serialObjName, self.txDataName, self.bitMode );
             
            % if there is an output, read it from the serial port
            if self.readback ~= 0
                fprintf( fid, '%s = fread( %s, %i ); \n\n', self.outputName, self.serialObjName, self.readback);
            end
            
            
            fprintf( fid, 'end' );
            
            fclose( fid );
        end
    end
    
end

