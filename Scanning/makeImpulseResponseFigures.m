function makeImpulseResponseFigures
%
%
% 12 Feb 2014. JHC.

fileNameNoCounter = sprintf( 'impulse response data %s' , datestr( today, 'yyyymmdd' ) );

matchedFiles = ls( strcat( fileNameNoCounter, '*' ) );
nMatchedFiles = size( matchedFiles, 1 );

f1 = figure( 'Name', 'Impulse Response' );

for ii = 1:nMatchedFiles

    thisFile = sprintf('%s %02.0f', fileNameNoCounter, ii );
    load( thisFile )

    subplot( 1,2,1 )
    makeSubplot( imx, 'x' )
    
    subplot( 1,2,2 )
    makeSubplot( imy, 'y' )
    
    plotfordoc_s( [12 5], 11, thisFile, 'png' )
    
end

close( f1 );
end

function makeSubplot( im , testAxis )
    
    range = [0 2^12];
    imagesc( im, range )
    imshow( im, range )
    %colormap gray
    %axis equal off ij
    title( sprintf( '%s response', testAxis ) )
end