classdef functionWriter
    % FUNCTIONWRITER
    % A class for automatic generation of function files that allow sending
    % of two byte commands to the SC2000 scan controller board.
    % 
    % 31st January 2014. JHC.
    % Edits until 11 Feb 2014. JHC.
    
    properties
        
        fnName          % name of function
        nInputs         % number of inputs
        decID           % decimal two byte command value
        inputParams     % names of input variablss
        inputParamTypes % types of input variables
        context         % for use in vector or raster mode
        rxDataBytes     % number of bytes of data to read back
        
    end
    
    properties (Access = private)
        
        % directory containing methods for SC2000Communicator class
        subDir = '@SC2000Communicator/';
        
        % variable names for printing to file
        communicatorObjName = 'self';
        serialObjName = 'serialObj';
        rxDataName = 'rxData';
        rxBytesName = 'rxBytes';
        commandBitName = 'commandBit';
        bitMode = '''uint8''';
        txDataName = 'txData';
        leConverterName = 'convert2leWord';
        meConverterName = 'convert2meWord';
        txrxOptName = 'txrxOpt';
        
        % file ID
        fid

    end
    
    methods
        function self = writeFile( self )
            % write the function file. To be called after all properties
            % have been set.
            
            %open the file
            self.fid = fopen( sprintf( '%s%s.m', self.subDir, self.fnName ) , 'w' );
            
            % write each element of the file
            writeTopLine( self )
            writeComments( self )
            writeCommands( self )
            
            fprintf( self.fid, 'end' );
            
            fclose( self.fid );
        end
    end
    
    methods (Access = private)
        function writeTopLine( self )
            % write the top line of the function
            
            % write the return values - transmitted and received data
            outputStr = sprintf( '[ %s, %s ] = ', self.txDataName, self.rxDataName );
                       
            % print function inputs to string with a comma between each
            inputStr = [ ' ', self.communicatorObjName, ', ' ];
            for ii = 1:self.nInputs
                inputStr = sprintf( '%s%s, ', inputStr, self.inputParams{ii} );
            end
            
            % remove the final comma and the space and add back the space
            inputStr = [inputStr(1:end-2), ' '];
            
            firstLineStr = sprintf( 'function %s%s(%s)\n', outputStr, self.fnName, inputStr );
            
            % print to file
            fprintf( self.fid, firstLineStr );
            
        end
        
        function writeComments( self )
            % print the comments block at the top of the file.
            
            % print first comments line
            fprintf( self.fid, '\t%% %s\n', upper( self.fnName ) );
            
            k = 1;
            
            % print inputs information to comments
            fprintf( self.fid, '\t%% Number of inputs: %i\n', self.nInputs + k );
            fprintf( self.fid, '\t%%\tInput 1: %s.%s is an open serial port\n', self.communicatorObjName, self.serialObjName );
            %fprintf( self.fid, '\t%%\tInput 2: %s specifies if you want to transmit and receive data. \n', self.txrxOptName );
            
            if self.nInputs ~=0 
                
                for jj = 1:self.nInputs
                    if regexp( self.inputParamTypes{jj}, '^[aeioAEIOFLHMNRSX]' )
                        article = 'an';
                    else
                        article = 'a';
                    end
                    
                    fprintf( self.fid, '\t%%\tInput %i: %s is %s %s\n', jj+k, self.inputParams{jj}, article, self.inputParamTypes{jj} );
                end
            else
                fprintf( self.fid, '\n' );
            end
            
            % print the context
            fprintf( self.fid, '\t%% For use in %s mode.\n', self.context );
            
            % print the number of bytes to be read
%             if self.rxDataBytes ~= 0
%                 fprintf( self.fid, '\t%% %i bytes of rxData\n\n', self.rxDataBytes);
%             else
%                 fprintf( self.fid, '\n' );
%             end
            
            % print info
            fprintf( self.fid, '\t%% Generated automatically by functionWriter class.\n' );
            fprintf( self.fid, '\t%% Source dictionary is at the end of SC2000 command reference document.\n\n' );
            fprintf( self.fid, '\t%% %s. James Clegg.\n\n', datestr( date, 'dd mmmm yyyy' ) );
            
        end
        
        function writeCommands( self )
            % write the commands to file.
            
            % set command bit 
            fprintf( self.fid, '%s = %i; \n', self.commandBitName, self.decID );
            
            % set number of bytes of rxData
            fprintf( self.fid, '%s = %i; \n\n', self.rxBytesName, self.rxDataBytes );
            
            % set command bits for each input 
            strToWrite = [];
            % call the converter function for each input and return a
            % variable name like b1, b2 etc        
            for kk = 1:self.nInputs
                switch self.inputParamTypes{kk}
                    case 'LEWORD'
                        converterFcn = self.leConverterName;
                    case 'LEDBLWORD'
                        converterFcn = self.meConverterName;
                    case 'BEDBLWORD'
                    case 'BEWORD'
                end
                fprintf( self.fid, 'b%i = %s.%s( %s );\n' , kk, self.communicatorObjName, converterFcn, self.inputParams{kk} );
                strToWrite = sprintf( '%s, b%i', strToWrite, kk );
            end
            
            %remove first comma
            strToWrite = strToWrite(2:end);
            
            % deal with the special cases
            switch self.fnName
                case 'getStatus'
                    fprintf( self.fid, '%s = repmat( %s, 1, 9 );\n\n', self.txDataName, self.commandBitName );
                case 'end'
                    % perhaps I should implement the checksum properly?
                    fprintf( self.fid, '%s = [ %s, 255, 255, 255, 255];\n\n', self.txDataName, self.commandBitName );
                otherwise
                    % now assign the command bit and the b1, b2 etc to txData
                    if self.nInputs ~= 0
                        fprintf( self.fid, '%s = [ %s,%s ];\n\n', self.txDataName, self.commandBitName, strToWrite );
                    else
                        fprintf( self.fid, '%s = %s;\n\n', self.txDataName, self.commandBitName );
                    end
            end
            % if self.transmit is on then transmit the data and read back
            fprintf( self.fid, 'if self.transmit.statusB \n' );
            %  then transmit the data to the serial device
            fprintf( self.fid, '\t%s = %s.%s; \n', self.serialObjName, self.communicatorObjName, self.serialObjName );
            fprintf( self.fid, '\tfwrite( %s, %s, %s ); \n', self.serialObjName, self.txDataName, self.bitMode );
              
            % if there is an output, read it from the serial port
            if self.rxDataBytes == 0
                fprintf( self.fid, '\t%s = []; \n', self.rxDataName );
            else
                fprintf( self.fid, '\t%s = fread( %s, %s ); \n', self.rxDataName, self.serialObjName, self.rxBytesName );
            end
            
            % if self.transmit is off...
            fprintf( self.fid, 'else\n' );
            % then just return return rxData as empty. txData is already
            % set.
            fprintf( self.fid, '\t%s = []; \n', self.rxDataName );
            fprintf( self.fid, 'end \n\n' );
            
        end
        
    end
    
end

