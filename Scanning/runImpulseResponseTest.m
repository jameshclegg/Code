%
%
% 14 Feb 2014. JHC.
clear
close all

i1 = impulseResponseTester();
i1.cam1 = i1.cam1.setSqROI( 250, 25, 0 );
i1.stepSizes = 1000;

i1 = i1.testAll();

i1.data = i1.data.plot();

i1.data.saveFigures();

i1.data.saveData();