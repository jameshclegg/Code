function [p1 p2 ERR] = alignment(npix,i1c,i2c)
%alignment used to align holograms
addpath('D:\Documents\flc_schemes\scheme2')

Screen('CloseAll')
close all

% unify the key names - this makes the code work on any platform.
KbName('UnifyKeyNames');

%% hologram calculation
% number of fringes in each direction on each hologram
nfr = [10 10];

x = linspace(-1,1,npix); % this would break if scrsz(2) was odd.
y = linspace(-1,1,npix);
[xg,yg] = meshgrid(x,y);

circmask = double(hypot(xg,yg)<1);

defocus = (2*(xg.^2+yg.^2)-1);

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
uKey = KbName('u');
iKey = KbName('i');
oKey = KbName('o');
pKey = KbName('p');

% index for the top left of hologram 1
if i1c==0
    i1c = [scrsz(1)/2-npix/2 100];
end
if i2c==0
% and hologram 2
    i2c = scrsz-i1c-npix;
end

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
toshow = zeros(scrsz);
rs = 0.7;
stepmask = circmask-2*double(hypot(xg,yg)<rs);
df = 0;

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

try
while 1>0

    [ keyIsDown, ~, keyCode ] = KbCheck;
    
    if keyIsDown
        
        if keyCode(lhKey)
            toshow = zeros(scrsz);
            fprintf('adjusting LH hologram \n')
            side = 1;
        elseif keyCode(rhKey)
            toshow = zeros(scrsz);
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
        elseif keyCode(uKey)
            rs = rs-0.05;
            stepmask = circmask-2*double(hypot(xg,yg)<rs);
        elseif keyCode(iKey)
            rs = rs+0.05;
            stepmask = circmask-2*double(hypot(xg,yg)<rs);
        elseif keyCode(oKey)
            df = df+2*pi/30;
        elseif keyCode(pKey)
            df = df-2*pi/30;
        elseif keyCode(escapeKey)
            break;
        end
    end
    
   
    % work out the phase pattern for the grating.
    phase1 = stepmask.*...
    (xg*nfr(1)*2*pi/(max(x)-min(x))+...
    yg*nfr(2)*2*pi/(max(y)-min(y)) +df*defocus);
    % make it binary
    bh = mod(phase1,2*pi)>pi;


    if side==1
        i1c = i1c+dpos;
        i1c = checkedge(i1c);
        toshow(i1c(1):i1c(1)+npix-1,i1c(2):i1c(2)+npix-1) = bh;
    elseif side==2;
        i2c = i2c+dpos;
        i2c = checkedge(i2c);
        toshow(i2c(1):i2c(1)+npix-1,i2c(2):i2c(2)+npix-1) = bh;
    end
    
    dpos = [0 0];
    
    toshow(toshow==0) = BlackIndex(window1);
    toshow(toshow==1) = WhiteIndex(window1);

    Screen('PutImage',window1,toshow);
    Screen('PutImage',window0,toshow);
    
    Screen('Flip', window1);
    Screen('Flip', window0);
    
    %imshow(toshow,[])
    %,'InitialMagnification',30,'Border','tight')
    ERR=0;
end
catch ERR
    Screen('CloseAll')
    close all
end

Screen('CloseAll')
close all

p1 = i1c;
p2 = i2c;

end

