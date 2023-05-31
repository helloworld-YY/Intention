clear; clc;
%%

%列表示意图  行表示目标

%%
P_i=load('P_i.txt');
P_io=load('P_io.txt');
w = load('w.mat');
w=w;
weight = struct2array(w)
% Pi=table2array(struct2array(P_i))';
% Pio=table2array(struct2array(P_io));
Pi = P_i';
Pio1 = P_io;
Pio0 = 1-Pio1;

%%
Pio = Pio1;
Pio_sum = sum(Pio,2);
%%
% Pio = Pio./Pio_sum;
num_object = size(Pio,1);
num_intent = size(Pi,2);
intention = [1 2 3 4 5 6 7 8 9 10];
object = [1 2 3 4 5 6 7 8 9 10];
domainMat = [1 2 2 0 0 0 0 0 0 0;
    2 2 2 1 0 0 0 0 0 0;
    2 2 2 0 0 1 0 0 0 0;
    2 2 2 0 0 0 1 0 0 0;
    2 2 2 0 0 1 1 0 0 0;
    0 2 2 0 1 0 0 0 0 0;
    0 0 2 0 0 0 0 0 1 0;
    0 0 2 0 0 0 0 1 0 0;
    0 0 2 0 1 2 0 1 1 0;
    0 0 0 0 0 0 0 0 0 1;
    ]
test_data = xlsread('data_test.xlsx');

AA = [];
%%

%%


for mm = 1:1:10

side = randperm(330,99);
index1 = sort(side);
test_x = test_data(1:10,index1)';
test_y = test_data(11,index1)';
%%

intention3 = [];
for k =1 : 1 : size(test_x,1)
    objseq = find(test_x(k,:) ~= 0);
    L = Pio & ones(10,10);
    use = max(sum(L,2)); %找到知识库中最大的意图长度
    [refinedseq, poss_Int] = RMM(objseq, Pi, Pio)
    cor = computecor(refinedseq,poss_Int,domainMat);
    %cor = cor + 0.1
    refinedseq_new = sort(refinedseq);
    %Pio_ex = Pio(poss_Int,refinedseq_new);
    Pio_ex = ExtractPioEx(objseq,poss_Int,Pio1,Pio0);
    Pi_ex = Pi(poss_Int);
    sub_weight = weight(:,poss_Int);
    P = Pi_ex'; 
    P_w = Pi_ex';
    Pio_new = Pio_ex.^(sub_weight);
    for j = 1:1:size(Pio_ex,2)
        P = P.*Pio_ex(:,j);
    end
    for j = 1:1:size(Pio_ex,2) %加权朴素贝叶斯
        P_w = P_w.*Pio_new(:,j);
    end
    P1 = P.*cor;
    P2 = P_w.*cor;

    intention3 = [intention3; poss_Int(find(P2 == max(P2)))];
    
    %%?
    %测试部分
    %poss_Int
    %%
    
end

accuracy3 = sum((intention3 == test_y))/length(test_y)  %含惩罚项的加权朴素贝叶斯模型
A = accuracy3

AA = [AA A];

end

acc = mean(AA,2)


