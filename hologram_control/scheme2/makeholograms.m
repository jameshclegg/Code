function [p1, p2] = makeholograms(npix,i1c,i2c)
%MAKEHOLOGRAMS
%   creates circular holograms.
%
% 25 Jul 2012. JHC.
% 31 July 2012. Edited for desktop.
addpath('D:\Documents\flc_schemes\scheme2')

Screen('CloseAll')
close all

% unify the key names - this makes the code work on any platform.
KbName('UnifyKeyNames');

%% hologram calculation
% number of fringes in each direction on each hologram
nfr1 = [20 24];
nfr2 = nfr1;

%1-DoubleD. 2-Trilobite. 3-AlienB. 4-AlienA.
schemeid = 3;

% phase change. ForthDD document says that the design wavelength is 550nm.
phi = 550/533*pi;

% angle between FLC states. ForthDD document says switching angle is 34.5
% deg at 25 degrees C. This changes to 34.75 at 20 C and 34.25 at 30 C.
dtheta = 33.5/180*pi;

% this is a standard function for setting up amplitude profiles.
% string can be radial, linearx, lineary, linear45, helicalx, helicalcp
[a1 a2 p1 p2] = setuphologram(npix,'radial');
% now work out the holograms
% using the full scheme
%[~,~,~,~,h1,h2] = scheme2a(npix,a1,a2,p1,p2,phi,dtheta,0,0,nfr1,nfr2,schemeid);

% or assuming special theta and phi.
%[~,~,~,~,h1,h2] = scheme2a(npix,a1,a2,p1,p2,pi,pi/4,0,0,nfr1,nfr2,schemeid);

% with the flip
[~,~,~,~,h1,h2] = scheme2aflip(npix,a1,a2,p1,p2,pi,dtheta,0,0,nfr1,nfr2,schemeid);


%h1=h1/2+1; h2=h2/2+1;
% size of second screen is: 


%% display section

scrsz = [1024 1280]; % second number is horizontal dimension

% step sizes
bgstep = 5;
smstep = 1;

% set some key names as variables.
upKey = KbName('UpArrow');
dnKey = KbName('DownArrow');
rKey = KbName('RightArrow');
lKey = KbName('LeftArrow');
lhKey = KbName('l');
rhKey = KbName('r');
escapeKey = KbName('ESCAPE');
bgKey = KbName('b');
smKey = KbName('s');

% index for the top left of hologram 1.
%i1c = [scrsz(1)/2-npix/2 100];
% and hologram 2
%i2c = scrsz-i1c-npix;

% Removes the blue screen flash and minimize extraneous warnings.
Screen('Preference', 'VisualDebugLevel', 3);
Screen('Preference', 'SuppressAllWarnings', 1);

% Open a new window on the second screen.
[window1,~] = Screen('OpenWindow', 2);
[window0,~] = Screen('OpenWindow', 1);

ds = bgstep;
side = 1;
fprintf('adjusting LH hologram \n step size %i pix \n',ds);
dpos = [0 0];


function topleftout = checkedge(topleftin)

    topi = topleftin(1);
    boti = topleftin(1)+npix-1;
    lefti = topleftin(2);
    righti = topleftin(2)+npix-1;

    topleftout = topleftin;

    if topi<1
        topleftout(1)=1;
    elseif boti>scrsz(1)
        topleftout(1)=scrsz(1)-npix;
    elseif lefti<1
        topleftout(2)=1;
    elseif righti>scrsz(2)
        topleftout(2)=scrsz(2)-npix;
    end

end

while 1>0

    [ keyIsDown, ~, keyCode ] = KbCheck;
    
    if keyIsDown
        
        if keyCode(lhKey)
            fprintf('adjusting LH hologram \n')
            side = 1;
        elseif keyCode(rhKey)
            fprintf('adjusting RH hologram \n')
            side = 2;
        elseif keyCode(upKey)
            dpos(1) = dpos(1)-ds;
        elseif keyCode(dnKey)
            dpos(1) = dpos(1)+ds;
        elseif keyCode(rKey)
            dpos(2) = dpos(2)+ds;
        elseif keyCode(lKey)
            dpos(2) = dpos(2)-ds;
        elseif keyCode(bgKey)
            ds = bgstep;
            fprintf('Step size changed to %i pix\n',bgstep)
        elseif keyCode(smKey)
            ds = smstep;
            fprintf('Step size changed to %i pix\n',smstep)
        elseif keyCode(escapeKey)
            break;
        end
    end
    
    if side==1
        i1c = i1c+dpos;
        i1c = checkedge(i1c);
    elseif side==2;
        i2c = i2c+dpos;
        i2c = checkedge(i2c);
    end
    
    dpos = [0 0];
    
    % variable for both holograms
    toshow1 = zeros(scrsz);
    toshow2 = zeros(scrsz);

    toshow1(i1c(1):i1c(1)+npix-1,i1c(2):i1c(2)+npix-1) = h2;
    toshow2(i2c(1):i2c(1)+npix-1,i2c(2):i2c(2)+npix-1) = h1;

    toshow= toshow1+toshow2;
    
    toshow(toshow==0) = BlackIndex(window1);
    toshow(toshow==1) = WhiteIndex(window1);

    Screen('PutImage',window1,toshow);
    Screen('PutImage',window0,toshow);
    
    Screen('Flip', window1);
    Screen('Flip', window0);
    
    %imshow(toshow,[])
    %,'InitialMagnification',30,'Border','tight')

end

Screen('CloseAll')
close all

p1 = i1c;
p2 = i2c;
end

