function cam1 = takeImpulseResponsePicture()
%TAKEIMPULSERESPONSEPICTURE
%
% 12 Feb 2014. JHC.

t = 300;
tus = t*23;

shutterMult = 20;

laserSetting = 0.57;

sweepSize = 8000;
stepSize = 5200;

%make shutter a few times t
shutterTime = tus*1e-6*shutterMult;

cam1 = cameraController( 'orca' );
cam1 = cam1.initialiseCamera();

set( cam1.src, 'ExposureTime', shutterTime );
set( cam1.vid, 'ROIPosition', [562 390 250 250]);

    function im1 = testOneAxis( testAxis )
        
        comm1 = impulseResponseRaster( testAxis, t, sweepSize, stepSize );

        pause(2)
        
        im1 = cam1.takePic();
        
        comm1.exitPgm();
        comm1.close();
        
    end

imx = testOneAxis( 'x' );
imy = testOneAxis( 'y' );

fileNameNoCounter = sprintf( 'impulse response data %s' , datestr( today, 'yyyymmdd' ) );

matchedFiles = ls( strcat( fileNameNoCounter, '*' ) );
nMatchedFiles = size( matchedFiles, 1 );

save( sprintf('%s %02.0f', fileNameNoCounter, nMatchedFiles+1 ), 'imx', 'imy', 't', 'shutterTime', 'sweepSize', 'stepSize', 'laserSetting' )

end

