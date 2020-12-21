for i=1:322
    a=max(CancerSym(:,i));
    if a~=0
        CancerSym(:,i)=CancerSym(:,i)/a;
    else
        CancerSym(:,i)=CancerSym(:,i);
    end
end
for i=1:210
    b=max(feature(:,i));
    if b~=0
        feature(:,i)=feature(:,i)/b;
    else
        feature(:,i)=feature(:,i);
    end
end
for i=1:166
    c=max(MACCSF(:,i));
    if c~=0
        MACCSF(:,i)=MACCSF(:,i)/c;
    else
        MACCSF(:,i)=MACCSF(:,i);
    end
end
r1=randperm(length(OO),length(OZ));
r2=randperm(length(ZO),length(OZ));
r3=randperm(length(ZZ),length(OZ));
OO2=OO(r1,:);
ZO2=ZO(r2,:);
ZZ2=ZZ(r3,:);
for i=1:length(OO2)
    T1(i,1:322)=CancerSym(OO2(i,1),:);
    T1(i,323:532)=feature(OO2(i,2),:);
    T1(i,533:698)=MACCSF(OO2(i,3),:);
    T1(i,699)=1;
    Index1(i,:)=OO2(i,:);
end
for i=1:length(OZ)
    T2(i,1:322)=CancerSym(OZ(i,1),:);
    T2(i,323:532)=feature(OZ(i,2),:);
    T2(i,533:698)=MACCSF(OZ(i,3),:);
    T2(i,699)=2;
    Index2(i,:)=OZ(i,:);
end
for i=1:length(ZO2)
    T3(i,1:322)=CancerSym(ZO2(i,1),:);
    T3(i,323:532)=feature(ZO2(i,2),:);
    T3(i,533:698)=MACCSF(ZO2(i,3),:);
    T3(i,699)=3;
    Index3(i,:)=ZO2(i,:);
end
for i=1:length(ZZ2)
    T4(i,1:322)=CancerSym(ZZ2(i,1),:);
    T4(i,323:532)=feature(ZZ2(i,2),:);
    T4(i,533:698)=MACCSF(ZZ2(i,3),:);
    T4(i,699)=4;
    Index4(i,:)=ZZ2(i,:);
end
Sample=[T1;T2;T3;T4];
Sample_Index=[Index1;Index2;Index3;Index4];
% for i=1:size(Sample,1)
%     for j=1:size(Sample,2)-1
%         Sample2(i,j)=(Sample(i,j)-min(Sample(i,:)))/(max(Sample(i,:))-min(Sample(i,:)));
%     end
% end
% Sample2(:,699)=Sample(:,699);
INDICES = crossvalind('Kfold',size(Sample,1),5);
for k=1:5
  test = (INDICES == k); 
  train = ~test;
  train_fea=Sample(train,1:698);
  train_labels=Sample(train,699);
  test_fea=Sample(test,1:698);
  test_target=Sample(test,699);
  mdl = TreeBagger(100, train_fea, train_labels,'NumPredictorsToSample',128);
  [pred_labels,score] = predict(mdl, test_fea);
  pred_labels=str2num(char(pred_labels'));
  C=confusionmat(test_target,pred_labels,'Order',[1 2 3 4]);
  acc(k)=(C(1,1)+C(2,2)+C(3,3)+C(4,4))/sum(sum(C));Cancer2
  pre1=C(1,1)/sum(C(:,1));
  pre2=C(2,2)/sum(C(:,2));
  pre3=C(3,3)/sum(C(:,3));
  pre4=C(4,4)/sum(C(:,4));
  pre(k)=(pre1+pre2+pre3+pre4)/4;
  R1=C(1,1)/sum(C(1,:));
  R2=C(2,2)/sum(C(2,:));
  R3=C(3,3)/sum(C(3,:));
  R4=C(4,4)/sum(C(4,:));
  Recall(k)=(R1+R2+R3+R4)/4;
  F1=(2*pre1*R1)/(pre1+R1);
  F2=(2*pre2*R2)/(pre2+R2);
  F3=(2*pre3*R3)/(pre3+R3);
  F4=(2*pre4*R4)/(pre4+R4);
  F(k)=(F1+F2+F3+F4)/4;
  [X,Y,T,auc]=perfcurve(test_target,score(:,1),1);
  [XP,YP,TP,~] = perfcurve(test_target,score(:,1),1,'xcrit','reca','ycrit','prec');
  YP(1)=YP(2);
  aucp=trapz(XP,YP);
  AUC(k)=auc;
  AUCP(k)=aucp;
end
Acctotal=sum(acc)/5;
Pretotal=sum(pre)/5;
Rtotal=sum(Recall)/5;
Ftotal=sum(F)/5;
AUCtotal=sum(AUC)/5;
AUCPtotal=sum(AUCP)/5;
Results=[Acctotal;Pretotal;Rtotal;Ftotal;AUCtotal;AUCPtotal];

