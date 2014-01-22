function testpattern(side)
%TESTPATTERN draws gratings onto the FLC SLM.
%   Draw binary gratings onto the FLC SLM (or an external screen).
%   side sets the pattern on the SLM. This can be L, R or Both.
%   if side = 'L' or 'R' then a grating is drawn on one half of the SLM.
%   if side = 'Both' then the grating extends across the whole SLM. The
%   user can set the phase shift between the gratings using the left and
%   right arrow keys. This can be adjusted in nbig increments (increment
%   size = 360 / nbig) or nsmall increments. User should press 'b' or 's'
%   to switch between these modes.
%   The code from KbDemo was used as a base.
%   
% 31 Jul 2012. JHC.
% 6 Aug 2012.
% 7 Aug 2012.
% 14 Aug 2012. Commented fully.

% unify the key names - this makes the code work on any platform.
KbName('UnifyKeyNames');

% numbers of divisions of 2*pi for the small and large phase steps.
nbig = 30;
nsmall = 180;

% size of SLM or external screen
scrsz = [1024 1280]; % second number is horizontal dimension

% number of fringes in each direction on hologram. the hologram counts as
% half of the screen.
nfr = [20 24];
%nfr2 = [0 24];
nfr2 = 2*nfr;

x = linspace(0,0.5,scrsz(2)/2); % this would break if scrsz(2) was odd.
y = linspace(0,1,scrsz(1));
[xg,yg] = meshgrid(x,y);

% Removes the blue screen flash and minimize extraneous warnings.
Screen('Preference', 'VisualDebugLevel', 3);
Screen('Preference', 'SuppressAllWarnings', 1);

% Open a new window on the second screen.
[window1,~] = Screen('OpenWindow', 2);

% set some key names as variables.
addphaseKey = KbName('RightArrow');
subphaseKey = KbName('LeftArrow');
smlKey = KbName('s');
bigKey = KbName('b');
escapeKey = KbName('ESCAPE');

% work out the phase pattern for the grating.
phase1 = xg*nfr(1)*2*pi/(max(x)-min(x))+yg*nfr(2)*2*pi/(max(y)-min(y));
% make it binary
binarypattern1 = mod(phase1,2*pi)>pi;

%
phase2 = xg*nfr2(1)*2*pi/(max(x)-min(x))+yg*nfr2(2)*2*pi/(max(y)-min(y));
% make it binary
binarypattern2 = mod(phase2,2*pi)>pi;

% the phase offset between left and right halves of the screen is initially
% 0.
phOffset = 0;

otherside = zeros(size(binarypattern1));

switch side
    case '2'
        fprintf('Different holograms on L and R\n')
        %toshow = [binarypattern2 binarypattern1];
    case 'L'
        fprintf('Hologram on left only. Right = 0\n')
        %toshow = [binarypattern1 otherside];
    case 'R'
        fprintf('Hologram on right only. Left = 0\n')
        %toshow = [otherside binarypattern1];
    case 'Both'
        fprintf('both holograms\n')
        fprintf('Use right arrow key to change phase difference\n')
        fprintf('Phase offset: \t %.1f degrees \n',0)
        %toshow = zeros(size(binarypattern1,1),size(binarypattern1,2)*2);
end

toshow = zeros(size(binarypattern1,1),size(binarypattern1,2)*2);

nsteps = nbig;

while 1 > 0
    
    switch side
        % If we have holograms on both sides of the screen, allow a phase
        % difference to be introduced
        case 'Both'
            binarypattern2 = mod(phase1+phOffset,2*pi)>pi;
            toshow = [binarypattern1 binarypattern2];
            
            [ keyIsDown, ~, keyCode ] = KbCheck;

            if keyIsDown
                if keyCode(addphaseKey)
                    if phOffset < 2 * pi
                        phOffset = phOffset + 2*pi/nsteps;
                    else
                        phOffset = 0;
                    end
                elseif keyCode(subphaseKey)
                    if phOffset > 0
                        phOffset = phOffset - 2*pi/nsteps;
                    else
                        phOffset = 2*pi;
                    end
                elseif  keyCode(smlKey)
                    nsteps = nsmall;
                    fprintf('Step size changed to %.1f degrees\n',360/nsteps)
                elseif keyCode(bigKey)
                    nsteps = nbig;
                    fprintf('Step size changed to %.1f degrees\n',360/nsteps)
                elseif keyCode(escapeKey)
                    break;
                end
            fprintf('Phase offset: \t %.1f degrees \n',phOffset*180/pi)
            end
        case 'L'
            toshow = [binarypattern1 otherside];
            [ ~, ~, keyCode ] = KbCheck;
            if keyCode(addphaseKey)
                otherside = double(xor(otherside,1));
                othersideval = unique(otherside);
                fprintf('Right side value: %i\n',othersideval)
            elseif keyCode(escapeKey)
                break;
            end    
        case 'R'
            toshow = [otherside binarypattern1];
            [ ~, ~, keyCode ] = KbCheck;
            if keyCode(addphaseKey)
                otherside = double(xor(otherside,1));
                othersideval = unique(otherside);
                fprintf('Left side value: %i\n',othersideval)
            elseif keyCode(escapeKey)
                break;
            end
        case '2'
            toshow = [binarypattern2 binarypattern1];
    end
    
    % toshow now contains 0s and 1s, but we want to change it so that it
    % represents the white index and the black index of the screen.
    toshow = double(toshow);
    toshow(toshow==0) = BlackIndex(window1);
    toshow(toshow==1) = WhiteIndex(window1);
    
    Screen('PutImage',window1,toshow);
    Screen('Flip', window1);

end

Screen('CloseAll')

end