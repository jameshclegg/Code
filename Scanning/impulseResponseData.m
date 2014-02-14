classdef impulseResponseData
    %IMPULSERESPONSEDATA
    %   5
    %
    % 14 Feb 2014. JHC.
    
    properties
        
        nStepSizes
        
        xImages
        yImages
        
        stepSizes
        
        
    end
    
    properties (Access = private)
        fileNameNoCounter = sprintf( 'impulse response data %s' , datestr( today, 'yyyymmdd' ) );
        
        figs
    end
    methods
        function self = impulseResponseData( nStepSizes )
            
            self.nStepSizes = nStepSizes;
            
            self.stepSizes = zeros( 1, nStepSizes );
            
        end
        
        function saveFigures( self )
            
            fn = self.fileNameNoCounter;
            
            matchedFiles = ls( strcat( fn, '*.png' ) );
            nMatchedFiles = size( matchedFiles, 1 );
            
            for ii = 1:self.nStepSizes
                
                self.figs(ii);

                thisFile = sprintf( '%s %02.0f', fn, nMatchedFiles+ii);
                plotfordoc_s( [12 5], 11, thisFile, 'png' );
                
            end
            
        end
        
        function saveData( self )
            
            fn = self.fileNameNoCounter;
            
            matchedFiles = ls( strcat( fn, '*.mat' ) );
            nMatchedFiles = size( matchedFiles, 1 );
            
            data = self;
            
            save( sprintf( '%s %02.0f', fn, nMatchedFiles+1 ), 'data' );
            
        end
        
        function plotOne( self, ii )
            subplot( 1, 2, 1 )
            makeSubplot( self.xImages(:,:,ii), 'x' )
                
            subplot( 1, 2, 2 )
            makeSubplot( self.yImages(:,:,ii), 'y' )
        end
        
        function self = plot( self )
            
            for ii = 1:self.nStepSizes
                self.figs(ii) = figure('Name',sprintf('Step size = %i',self.stepSizes(ii)));
                plotOne( self, ii )
            end
            
        end
            
    end
    
end

function makeSubplot( im , testAxis )
    range = [0 2^12];
    imshow( im, range )
    %colormap gray
    %axis equal off ij
    title( sprintf( '%s response', testAxis ) )
end

