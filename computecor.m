function domainmeet = computecor(refseq,possint,domainMat)

%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
u = 0; sigma =1;
seq = sort(refseq);
%����ÿ����ͼ�����������
num_domain = sum(domainMat(possint,:) == 1,2);
%���������ͼ����������ִ���
num_statisfy = zeros(length(possint),1);
for i = 1:1:length(seq)
    submat = domainMat(possint,seq(i));
    main_int = find(submat == 1);
    num_statisfy(main_int) = num_statisfy(main_int)+1;
end
domainmeet = (num_statisfy+0.1)./num_domain;


end


