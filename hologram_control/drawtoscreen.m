function drawtoscreen(image ,screenid)
%DRAWTOSCREEN   draw the matrix image on the screen.
%
% 25 July 2012. Lionel Fafchamps gave me the original version. Now
% modified.

window = Screen(screenid, 'OpenWindow');  %replace 0 with 1 for external screen

image=image*WhiteIndex(window);
Screen(window,'FillRect',BlackIndex(window));
Screen(window,'PutImage',image);

Screen(window,'Flip');
%KbWait;
%Screen('CloseAll');

end

