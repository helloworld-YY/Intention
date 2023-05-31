function pio_ex = ExtractPioEx(objseq, poss_int, pio1, pio0)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
intentionsize = size(pio1,2);
pio_ex = pio0;
for i = 1:1:length(objseq)
    test_pio = pio1(:,objseq(i));
    pio_ex(:,objseq(i)) = test_pio;
end

pio_ex = pio_ex(poss_int,:);

