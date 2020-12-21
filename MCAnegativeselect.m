
n=0;
T=0.9;
for i=1:size(MCAunlabel,1)
   ass=MCA2(:,MCAunlabel(i,2));
   a=find(ass==1);
   sim=mirSim(MCAunlabel(i,1),a);
   if isempty(sim)==0
       if max(sim)<T
           n=n+1;
           MCAneg(n,1)=MCAunlabel(i,1);
           MCAneg(n,2)=MCAunlabel(i,2);
       end
   end
end
