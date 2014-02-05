classdef SC2000commandMaker
    %SC2000COMMANDMAKER
    %
    % 31st January 2014. JHC.
    
    properties
        fileName = 'SC2000 Command Reference rev2.0.txt';
        wholeFile
        commandList
        commandTable
        nCommands
    end
    
    methods
        function self = readInFile( self )
            
            f1 = fopen( self.fileName, 'r' );
            
            self.wholeFile =  textscan(f1,'%s','Delimiter','\n');
            
            % make one cell element per new line in the file.
            self.wholeFile = self.wholeFile{:};
            
            fclose( f1 );
            
        end
        
        function self = getCommandList( self )
            
            % this gets the list of commands from the back of the command
            % reference document
            fullCommandTable = self.wholeFile( 5743:5805 );
            
            % this indicates which elements are empty (blank rows)
            nonEmpties = ~cellfun( @isempty, fullCommandTable );
            
            % the command list is the non empty values from fullCommandList
            self.commandTable = fullCommandTable( nonEmpties );
            
            self.nCommands = numel( self.commandTable );
            
            self.commandList = cellfun( @(c) regexp( c, ':', 'split' ), self.commandTable , 'UniformOutput', 0);
            
        end
       
        function makeFunctionFiles( self )
            
            for ii = 1:self.nCommands

            f = getFnParams( self, ii );
            
                switch f.fnName
                    case 'status'
                        warning( 'status has not been written because it requires manual changes' )
                    otherwise
                        f.writeFile();
                end
            
            end
            
        end
    end
    
    methods (Access = private)
        function fnFile = getFnParams( self, ii )
            
            f = functionFile;
            
            % get function names
            f.fnName = cell2mat( self.commandList{ii}(1) );
            
            % if the name contains a symbol, remove this
            f.fnName( regexp( f.fnName, '[^\w]' ) ) = [];
            
            % if the name already exists as a file, built in function,
            % class etc (see doc exist) then change its name
            if exist( lower(f.fnName) ) >= 2
                f.fnName = strcat( 'pgm', f.fnName );
            end
            
            % make the first letter lower case
            f.fnName(1) = lower( f.fnName(1) );
            
            f.nInputs = str2double( cell2mat( self.commandList{ii}(2) ) );
            f.decID = str2double(cell2mat( self.commandList{ii}(3) ));
            
            % get the input variable names
            nameList = cell2mat( self.commandList{ii}(4) ); 
            
            % split into a cell array for each input variable
            nameListCell = regexp( nameList, ' ', 'split' );
            % remove first and last double quotes
            nameListCell{1} = nameListCell{1}(2:end);
            nameListCell{end} = nameListCell{end}(1:end-1);
            % positions of each percentage sign.
            percentagePosns = strfind( nameListCell, '%' );
            
            %check that number of elements in cell array is equal to number
            %of input parameters
            if f.nInputs ~= 0
                if ~isequal( f.nInputs, numel(nameListCell) )
                    error( 'Not all inputs have been found' )
                end
            end
            % for each element in the cell array,
            f.inputParams = cell( f.nInputs, 1 );
            f.inputParamTypes = cell( f.nInputs, 1 );
            p = percentagePosns;
            for jj = 1:f.nInputs
                
                f.inputParams{jj} = nameListCell{jj}(1:p{jj}(1)-1);
                f.inputParamTypes{jj} = nameListCell{jj}(p{jj}(1)+1:p{jj}(2)-1);
                
            end
            
            % if more than one of inputParams is the same
            uIPs = unique( f.inputParams );
            for kk = 1:numel( uIPs )
                % find where the kkth unique input parameter occurs in the
                % input parameters list. This returns 1 for each element
                % found, and 0 if it is not found
                indices = strcmp( f.inputParams, uIPs{kk} );
                % need to multiply this by 1:n
                %counter = 1:f.nInputs;
                counter = 1:numel( f.inputParams );
                counter = counter( indices );
                
                if numel( counter ) == 2
                    
                    f.inputParams{ counter(1) } = strcat('x', f.inputParams{ counter(1) } );
                    f.inputParams{ counter(2) } = strcat('y', f.inputParams{ counter(2) } );
                    
                elseif numel( counter ) ~= 1
                    % uh oh, 3 or more inputs with the same name
                    warning( '3 or more inputs with the same name for function %s', f.fnName )
                end
                
            end
            
            % now get the context
            context = cell2mat(self.commandList{ii}(5));
            contR = strfind( context, 'ASMR' );
            contV = strfind( context, 'ASMV' );
            
            if isempty( contR )
                if isempty( contV )
                    %neither vector nor raster
                    f.context = 'N/A';
                else
                    % vector
                    f.context = 'vector';
                end
            else
                if ~isempty( contV )
                    % raster or vector
                    f.context = 'vector and raster';
                else
                    %raster
                    f.context = 'raster';
                end
            end
            
            % get the number of bytes to read back
            f.rxDataBytes = str2double( cell2mat(self.commandList{ii}(6)) );
            
            fnFile = f;
        end
    end
end