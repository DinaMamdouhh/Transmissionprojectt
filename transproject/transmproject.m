Pb=0.005; %blocking probability

%initialization
sensitivity=10^(-12);
CI=3;
TotalArea=450;

Pin=1; %inner power
Pout=2; %outer power

Ctotal=100; %total number of channels
Auser=1/144; %load of a user 

user_density=2; %user density

CarrierFrequency=1.8*(10^9); %fc
C=3*(10^8); %speed of light
lamda=C/CarrierFrequency; %wavelength

[Nin,Nout,numberOfCells,Cin,Cout,Din,Dout ] = transout(sensitivity,CI,TotalArea,Pout,Pin,Ctotal,Auser,Pb,user_density);

              display("Diameter of inner cell :" + Din)
              display("Diameter of outer cell :" + Dout)

              display("Number of channels used for inner cell  : "+ Cin)
              display("Number of channels used for outer cell  : "+ Cout)

              display("Reuse Factor of inner Cell : "+ Nin)
              display("Reuse Factor of Outer Cell : "+ Nout);
              
              display("Number of cells : " + numberOfCells);
