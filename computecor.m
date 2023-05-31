function domainmeet = computecor(refseq,possint,domainMat)

%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
u = 0; sigma =1;
seq = sort(refseq);
%计算每个意图的主物体个数
num_domain = sum(domainMat(possint,:) == 1,2);
%计算各个意图的主物体出现次数
num_statisfy = zeros(length(possint),1);
for i = 1:1:length(seq)
    submat = domainMat(possint,seq(i));
    main_int = find(submat == 1);
    num_statisfy(main_int) = num_statisfy(main_int)+1;
end
domainmeet = (num_statisfy+0.1)./num_domain;


end


