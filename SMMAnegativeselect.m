
n=0;
T=0.3;
for i=1:size(SMMAunlabel,1)
   ass=SMMA2(:,SMMAunlabel(i,2));
   a=find(ass==1);
   sim=mirSim(SMMAunlabel(i,1),a);
   if isempty(sim)==0
       if max(sim)<T
           n=n+1;
           SMMAneg(n,1)=SMMAunlabel(i,1);
           SMMAneg(n,2)=SMMAunlabel(i,2);
       end
   end

end