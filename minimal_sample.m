clc
clear all
data=load ('example1kinect.mat');
field=fieldnames(data);
cloud = data.(field{3});

max_inliers = 0;
i=0;
N-30;
while(i<N)
%%%%%sampling
y1 = datasample(cloud,1,1);
y2 = datasample(cloud,1,1);
y3 = datasample(cloud,1,1);
sample1 = datasample(y1,1,2);
sample2 = datasample(y2,1,2);
sample3 = datasample(y3,1,2);

sample=zeros(3,3);
sample(1,:) = sample1(1,1,:);
sample(2,:) = sample2(1,1,:);
sample(3,:) = sample3(1,1,:);

b=[1;
   1;
   1;];
%%%%model
model=linsolve(sample,b);
%%%%%distances
size(cloud)
cloud=reshape(cloud,[],3);
size(cloud)
indices=find(cloud(:,3)==0);
cloud(indices,:)=[];


distance=cloud*model;
%%%%inliers
for i:size(distance)
    if distance(i)<0.1;
        n_inliers=+1;
        
    end
end


%%%Best model

if n_inliers>max_inliers
	max_inliers=n_inliers;

end
i=+1;

end

