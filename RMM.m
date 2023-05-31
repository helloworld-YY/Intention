function [refinedseq, poss_Int] = RMM(objseq, Pi, Pio)
%Reverse maximum matching
%   refindseq为逆向提取序列
L = Pio & ones(10,10);
use = max(sum(L,2)); %找到知识库中最大的意图长度
len = length(objseq);
if len > use
    use_obj = objseq(end-use+1:end);
    len = use;
else
    use_obj = objseq;
end
%序列反向，便于推理处理
seq = fliplr(use_obj);
[~, i, ~] = unique(seq);
useobj = seq(sort(i));
len = length(useobj);
flag = 1; %%匹配控制参数
while flag
    para = sum((Pio(:,useobj)~=0),2);
    if max(para) ~= length(useobj)
        useobj = useobj(1:end-1);
        flag = 1;
    else
        refinedseq = useobj;
        poss_Int = find(para == length(refinedseq));
        flag = 0;
    end
end
end

