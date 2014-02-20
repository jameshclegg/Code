%
%
% 20th Feb 2014. JHC.

clear
close all

fileName = 'putty2.log';
fid = fopen( fileName, 'r' );

[header, p] = textscan( fid, '%s', 1, 'Delimiter', '\n' );
data = textscan( fid, '%f %*c %s', 'Delimiter', '\n');
fclose( fid );

d = str2double(data{2});
t = data{1}/1e3; %time in ms

[ tOn, tOff, tSU, tSD ] = findOnOffTime( t, d );

plot( t, d, 'LineWidth', 2 )
hold on
plot( t, d, 'k+' )
plot( tSU, 0.5*ones(size(tSU)) , 'go' )
plot( tSD, 0.5*ones(size(tSD)) , 'ro' )
hold off
ylim( [-0.1, 1.1] )

title( sprintf( 'On: %.3f ms, Off: %.3f ms', tOn, tOff ) );

figure()
dTus = 1e3*diff(t);
plot( t(1:end-1), dTus, 'k' )
xLims = get(gca,'XLim');
meanSampleTime = mean( dTus );
line( xLims, meanSampleTime*[1 1], 'LineStyle', '-.', 'Color', 'r', 'LineWidth', 2 )
xlabel( 'time / ms' )
ylabel( 'time between samples / \mus' )
title( sprintf( 'Mean sample time: %.1f us', meanSampleTime ) )