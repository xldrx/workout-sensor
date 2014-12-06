% bef = dir('./data/BEF*.mat');
% bea = dir('./data/BEA*.mat');
% 
% nBEF = {bef.name};
% nBEA = {bea.name};
% 
% [~,idBEF] = sort([bef.bytes]);
% [~,idBEA] = sort([bea.bytes]);
% 
% nBEF = nBEF(idBEF);
% nBEA = nBEA(idBEA);

[stt,cmdout] = system(sprintf('qsub -N BEFcleanSH-%d-1 classifyLMA.pbs',1),'-echo');
disp(stt)

for i = 2:50
    [stt,cmdout] = system(sprintf('qsub -W depend=after:%s -N BEFcleanSH-%d-1 classifyLMA.pbs',cmdout,i),'-echo');
    disp(stt)
end

for i = 1:50
    [stt,cmdout] = system(sprintf('qsub -W depend=after:%s -N BEAcleanSH-%d-2 classifyLMA.pbs',cmdout,i),'-echo');
    disp(stt)
end