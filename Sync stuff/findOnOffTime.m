function [onTime, offTime, stepUpTimes, stepDnTimes] = findOnOffTime( timeVector, digitalValues )
%
%
% 20th Feb 2014. JHC.


ddV = diff( digitalValues );

stepUpTimes = timeVector( (ddV == 1) );
stepDnTimes = timeVector( (ddV == -1) );

% find minimum number of steps
minSteps = min( [numel(stepUpTimes), numel(stepDnTimes)] );

sU = stepUpTimes( 1:minSteps );
sD = stepDnTimes( 1:minSteps );

if digitalValues(1) == 0
    onTimes = sU(2:end) - sD(1:end-1);
    offTimes = sD - sU;
else
    onTimes = sU - sD;
    offTimes = sD(2:end) - sU(1:end-1);
end

onTime = mean( onTimes );
offTime = mean( offTimes );

end