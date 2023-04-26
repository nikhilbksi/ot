clc
clear all

c=[2 4 7];
a=[5 -7 9; -2 -6 0; 6 2 1];
b=[5; 2; 6];
s = eye(size(a,1));

A = [a s b];
c = [c zeros(1,size(a,1)) 0];

basic = size(a,2)+1:1:size(A,2)-1;

zjcj =  c(:,basic)*A(:,1:size(A,2))-c(:,:);

zcj = [zjcj;A];
array2table(zcj,"VariableNames",{'x1','x2','x3','s1','s2','s3','sol'})

while(min(zjcj(1,1:size(A,2)-1)) < 0)
    
    [val,minIndexzjcj] = min(zjcj(1,1:size(A,2)-1));
    pivotColumn = A(:,minIndexzjcj);

    if(max(pivotColumn) <= 0)
        fprintf("Unbounded Solution");
        break;
    else
    
        pivotColumn = max(0,pivotColumn);
       
        [miVal,minRatioIndex] = min(b./pivotColumn);

        %update basic variables
        basic(minRatioIndex) = minIndexzjcj;

        %update A
        pvt_key = A(minRatioIndex,minIndexzjcj);
        A(minRatioIndex,:) = A(minRatioIndex,:)/pvt_key;
        for i=1:size(A,1)
            if i ~= minRatioIndex
              A(i,:) = A(i,:) - A(i,minIndexzjcj)*A(minRatioIndex,:);
            end
        end

        %update zjcj
        zjcj = zjcj-zjcj(1,minIndexzjcj)*A(minRatioIndex,:);

        %get solution
        if(min(zjcj(1,1:size(A,2)-1)) >= 0)
            bfs = zeros(1,size(A,2));
            bfs(basic) = c(basic);
            sol = zjcj(:,size(A,2));
            fprintf("Max = %f",sol);
            break;
        end
    end
end