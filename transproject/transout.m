function [Nin,Nout,numberOfCells,Cin,Cout,Din,Dout] = transout(sensitivity,CI,TotalArea,Pout,Pin,Ctotal,Auser,Pb,user_density)

data= xlsread('ErlangB.xlsx'); %Erlang B Table
probRow = data(1,:); %Blocking probability row
probColumn=data(:,1); % Blocking probability column

CarrierFrequency=1.8*(10^9);
C=3*(10^8); %speed of light
lamda=C/CarrierFrequency; %wavelength
numberOfCells=0;
Din=0;
Dout=0;

 for Nin=3:13

 for Nout=3:13

if Nin<Nout

  for k=1:99
    Cin=k;%number of inner channels
    Cout=Ctotal-k;%number of outer channels
    
    columnIndex=find(probRow==Pb);%get the index of the given Pb in the ErlangB table
    display("pb index :"+columnIndex)
    rowIndexIn=find(probColumn==floor(Cin/Nin));%get the index of the row for Cin/Nin
    display("in trunks "+rowIndexIn)
    rowIndexOut=find(probColumn==floor(Cout/Nout));%get the index of the row for Cout/Nout
    display("out trunks "+rowIndexOut)

    fatooma=data(rowIndexIn,:);%get the whole row
    Ain=fatooma(columnIndex);%get the Load for Inner cell
    display("in "+Ain)
    dondon=data(rowIndexOut,:);%get the whole row
    Aout=dondon(columnIndex);%get the load for the outer cell
    display("out "+ Aout)
    
    rin=sqrt(Ain/(user_density*Auser*pi)); %inner radius
    rout=sqrt(((Aout/user_density*Auser)+(pi*(rin).^2))*(2/(3*sqrt(3)))); %outer radius
    
    Psens_in=Pin*((lamda/(4*pi*rin)).^2);%sensitivity of inner cell
    Psens_out=Pout*((lamda/(4*pi*rout)).^2);%sensitivity of outer cell
    
    %check if values violate the required C/I & sensitivity
    if Psens_out>=sensitivity 
      if Psens_in>=sensitivity
      xin=(3*Nin)/6;
      xout=(3*(rout^2)*Nout)/(6*(rin)^2);
         if CI>=xin 
            if CI>=xout
               Din=2*rin; %diameter for inner cell
               Dout=2*rout;%diameter for outer cell
               numberOfCells=ceil(TotalArea/(3*sqrt(3)*rout*rout/2)); %total number of wireless cells 
              return;
            end
          end
      end 
    end 
  end
end
end
end
end

