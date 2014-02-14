classdef impulseResponseTester
    %IMPULSERESPONSETESTER
    %   Class for testing the impulse response of the scanning system.
    %
    % 14 Feb 2014. JHC.
    
    properties
        
        %camera controller
        cam1
        
        %SC2000 communicator
        comm1
        
        %
        t = 300;
        
        % size of sweep in tic
        sweepSize = 8000;
        
        % step sizes to test
        stepSizes = [ 1000, 2400, 5200 ];
        
        % shutterMult = the shutter time in multiples of the scan rount
        % trip time
        shutterMult = 20;
        
        nPix = 250;
        
        % make new class of impulse response data
        data
    end
    
    properties (SetAccess = private)
        fileNameNoCounter = sprintf( 'impulse response data %s' , datestr( today, 'yyyymmdd' ) );
    end
    
    properties (Access = private)
        nameRepeat = 'r';
        nameStep = 's';
        pauseTime = 2; %seconds
    end
    
    properties (Constant)
        ticTime = 23; %us
    end
    
    methods
        function self = impulseResponseTester()
            
            self = setupCamera( self );
            
            self = setupScanner( self );
            
        end
        
        function self = setupCamera( self )
            
            self.cam1 = cameraController( 'orca' );
            
            %make shutter a few times t
            shutterTime = get_tus( self )*1e-6*self.shutterMult;
            
            self.cam1 = cameraController( 'orca' );
            self.cam1 = self.cam1.initialiseCamera();
            
            set( self.cam1.src, 'ExposureTime', shutterTime );
            
            self.cam1 = self.cam1.setSqROI( 250, 25, 0 );
            
        end
        
        function self = setupScanner( self )
            
            self.comm1 = SC2000Communicator();          
            
        end
                
        function self = testAll( self )
            
            d = impulseResponseData( numel( self.stepSizes ) );
            
            for ii = 1:numel( self.stepSizes )
                
                s = self.stepSizes( ii );
                
                d.stepSizes( ii ) = s;
                
                d.xImages( :,:, ii ) = testOneAxis( self, 'x', s );
                d.yImages( :,:, ii ) = testOneAxis( self, 'y', s );
                
            end
            
            self.data = d;
            
        end
        
        function im1 = testOneAxis( self, testAxis, stepSize )
            
            self.comm1.open();
            
            sendSweepPGM( self );
            sendStepPGM( self, stepSize );
            
            switch testAxis
                case 'x'
                    arg1 = self.nameStep;
                    arg2 = self.nameRepeat;
                case 'y'
                    arg1 = self.nameRepeat;
                    arg2 = self.nameStep;
            end
            
            self.comm1.enable( 3 );
            self.comm1.executeRasterPgm( arg1, arg2 );
            
            pause( self.pauseTime )
            
            im1 = self.cam1.takePic();
            
            self.comm1.exitPgm();
            self.comm1.close();
            
        end
%         
%         function save( self )
%             
%             fn = self.fileNameNoCounter;
%             
%             matchedFiles = ls( strcat( fn, '*.mat' ) );
%             nMatchedFiles = size( matchedFiles, 1 );
%             
%             save( '%s %02.0f', fn, nMatchedFiles + 1 )
%             
%         end
        
        function t1 = get_t1( self )
            t1 = round( self.t / 3 );
        end
        
        function t2 = get_t2( self )
            t2 = self.t - get_t1( self );
        end
        
        function tWait = get_tWait( self )
            tWait = round( self.t / 10 );
        end
        
        function tus = get_tus( self )
            tus = self.t * self.ticTime;
        end
        
        
        function sendSweepPGM( self )
            
            self.comm1.createPgm( 0, self.nameRepeat );
            self.comm1.wait( get_tWait( self ) );
            self.comm1.slew( self.sweepSize, self.t );
            self.comm1.wait( get_tWait( self ) );
            self.comm1.slew( -self.sweepSize, self.t );
            self.comm1.repeat();
            self.comm1.end();
            
        end
        
        function sendStepPGM( self, stepSize )
            
            self.comm1.createPgm( 0, self.nameStep );
            self.comm1.wait( get_tWait( self ) );
            self.comm1.position( -stepSize );
            self.comm1.wait( get_t1( self )-1 );
            self.comm1.position( stepSize );
            self.comm1.wait( get_t2( self )-1 );
            self.comm1.wait( get_tWait( self ) );
            self.comm1.wait( get_t1( self ) );
            self.comm1.position( -stepSize );
            self.comm1.wait( get_t2( self )-1 );
            self.comm1.repeat();
            self.comm1.end();
            
        end
        
    end
    
end

