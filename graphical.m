clc 
clear all

C = [3 2];
A = [2 4;3 5];
B = [8;15];

fx = @(x1,x2)3*x1+2*x2;
x1 = 0:1:max(B);
x2 = (B(1)-A(1,1)*x1)/A(1,2);
x_2 = (B(2)-A(2,1)*x1)/A(2,2);

x2 = max(0,x2);
x_2 = max(0,x_2);

plot(x1,x2,x1,x_2);
legend('x2','x\_2')

cy = find(x1 == 0); %find index where it is zero because the y of this line will also be zero 
cx = find(x2 == 0); %find index where y of line1 is zero so that we can find it's x  
line1_cp = [x1([cx(1),cy]);x2([cx(1),cy])]';

cy1 = find(x1 == 0); %find index where it is zero because the y of this line will also be zero 
cx1 = find(x_2 == 0); %find index where y of line1 is zero so that we can find it's x  
line2_cp = [x1([cx1(1),cy1]);x_2([cx1(1),cy1])]';

points = unique([line1_cp;line2_cp],'rows');

intersection = [];

for i=1:size(A,1)
    A1 = A(i,:);
    B1 = B(1,:);
    for j=i+1:size(A,1)
        A2 = A(j,:);
        B2 = B(j,:);
        
        A3 = [A1;A2];
        B3 = [B1;B2];
        
        pt = A3\B3;
        
        intersection = [intersection ,pt];
    end
end

allPoints = [intersection';points];
allPoints = unique(allPoints,'rows');

const1 = [];
const2 = [];
for i=1:size(allPoints,1)
    const1(i) = A(1,1)*allPoints(i,1)+A(1,2)*allPoints(i,2)-B(1);
    const2(i) = A(2,1)*allPoints(i,1)+A(2,2)*allPoints(i,2)-B(2);
end
const1
const2
s1 = find(const1<0);
s2 = find(const2<0);

s = unique([s1 s2]);
allPoints(s,:) = [];
allPoints;

allPoints1 = find(allPoints(:,1)<0);
allPoints2 = find(allPoints(:,2)<0);

allPoints(allPoints2,:) = [];
allPoints(allPoints1,:) = [];

max = fx(allPoints(1,1),allPoints(1,2));

x = 0;

for i = 2:size(allPoints)
    if(fx(allPoints(i,1),allPoints(i,2))>max && allPoints(i,1)>= 0 && allPoints(i,2) >=0 )
        max = fx(allPoints(i,1),allPoints(i,2));
        x = i;
    end
end

fprintf('Objective Funtion maximized at (%f,%f) = %f',allPoints(x,1),allPoints(x,2),max);
