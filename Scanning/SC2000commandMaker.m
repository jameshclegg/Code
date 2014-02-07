classdef SC2000commandMaker
    %SC2000COMMANDMAKER
    %
    % 31st January 2014. JHC.
    
    properties
        fileName = 'SC2000 Command Reference rev2.0.txt';
        wholeFile
        commandList
        commandTable
        newNameList
        nCommands
    end
    
    methods
        function self = SC2000commandMaker()
            
            self = readInFile( self );
            self = getCommandList( self );
            self = getNewFnNames( self );
            
        end
        
        function self = makeFunctionFiles( self )
            
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
            unSplitTable = fullCommandTable( nonEmpties );
            
            self.nCommands = numel( unSplitTable );
            
            self.commandList = cellfun( @(c) regexp( c, ':', 'split' ), unSplitTable , 'UniformOutput', 0);
            
            self.commandTable = cat(1, self.commandList{:} );
        end
        
        function fnFile = getFnParams( self, ii )
            
            f = functionFile;
            
            % get function names
            f.fnName = self.newNameList{ii};
            
            f.nInputs = str2double( cell2mat( self.commandList{ii}(2) ) );
            f.decID = str2double( cell2mat( self.commandList{ii}(3) ));
            
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
        
        function self = getNewFnNames( self )
            
            self.newNameList = cell( numel(self.commandList), 1 );
            
            for ii=1:numel(self.commandList)
            
                % get function name
                oldName = cell2mat( self.commandTable(ii,1) );
            
                newName = oldName;
                % if the name contains a symbol, remove this
                newName( regexp( newName, '[^\w]' ) ) = [];
            
                % if the name already exists as a file, built in function,
                % class etc (see doc exist) then change its name
                if exist( lower(newName) ) >= 2
                    newName = strcat( 'pgm', newName );
                end
            
                % make the first letter lower case
            	newName(1) = lower( newName(1) );

                self.newNameList{ii} = newName;
            end

        end
        
        
    end
end