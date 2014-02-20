%
%   reads in data from the arduino scope file and plots it
% 19th feb 2014. JHC.
clear
close all

fileName = 'BitSequence1.txt';
fid = fopen( fileName, 'r' );
data = textscan( fid, '%s' ,'Delimiter','\n');

fclose( fid );

dataCell = data{1};

findSampleRate = strfind( dataCell, 'sampleRate' );

findSampleRateTF = ~cellfun('isempty',findSampleRate);

rowOfSampleRate = find( findSampleRateTF, 1 );

sampleRateRow = dataCell{ rowOfSampleRate };

sampleRate = str2double( sampleRateRow(  regexp( sampleRateRow, '[0-9]' ) ) );

t = 1/sampleRate*1000;

startV = 18;
stopV = 250;

for ii = 1:(stopV-startV+1)
    
    vstr = dataCell{ ii+startV };
    
    v(ii) = str2double( vstr(  regexp( vstr, '[0-9]' ) ) );

end

v = v.';
v = v/max(v(:));
tv = ((1:numel(v))*t).';

plot(tv,v, 'LineWidth',2)
xlabel('time / ms')

% convert to digital

digV = v>.5;

hold on
plot(tv,digV,'k')
hold off
ylim( [-0.1, 1.1] )

ddV = diff(digV);

stepUpTimes = tv( (ddV == 1) );
stepDnTimes = tv( (ddV == -1) );

hold on
plot( stepUpTimes, 0.5*ones( size( stepUpTimes ) ), 'ro' )
plot( stepDnTimes, 0.5*ones( size( stepDnTimes ) ), 'go' )
hold off

ledOnTimes = stepUpTimes - stepDnTimes;
ledOffTimes = stepDnTimes(2:end) - stepUpTimes(1:end-1);

ledOnTime = mean( ledOnTimes );
ledOffTimes = mean( ledOffTimes );

title( sprintf( 'On: %.3f ms, Off: %.3f ms', ledOnTime, ledOffTimes ) );