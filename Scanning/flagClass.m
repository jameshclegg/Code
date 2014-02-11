classdef flagClass
    %FLAGCLASS
    %
    % 11 Feb 2014. JHC.
    
    properties
    end
    
    properties (SetAccess = private)
        statusB
    end
    properties (Access = private)
        on = 'on';
        off = 'off';
    end
    
    methods
        function self = flagClass( initialStatus )
            self.statusB = word2bin( self, initialStatus );
        end
        
        function self = switchOn( self )
            self.statusB = 1;
        end
        
        function self = switchOff( self )
            self.statusB = 0;
        end
        
        function s = statusW( self )
            s = bin2word( self, self.statusB );
        end
       
    end
    
    methods (Access = private)
        function bin = word2bin( self, word )
            switch word
                case self.on
                    bin = 1;
                case self.off
                    bin = 0;
                otherwise
                    error( 'Word must be %s or %s', self.on, self.off )
            end
        end
        
        function word = bin2word( self, bin )
            if bin
                word = self.on;
            else
                word = self.off;
            end
        end
    end
    
    
end