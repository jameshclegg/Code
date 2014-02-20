nfrH = 20;
nfrV = 8;

res = [1280 1024];

x = 1:res(1);
y = 1:res(2);

[xG yG] = meshgrid( x, y );

phase = 2*pi*(nfrH*xG/res(1) + nfrV*yG/res(2));
wave = exp( 1i*phase );

imshow( sign( cos( phase ) ), [])
