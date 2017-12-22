clc
clear all
data=load ('example1kinect.mat');
field=fieldnames(data);
cloud = data.(field{3});

max_inliers = 0;
n_inliers=0;
i=0;
N=40;
threshold=0.05;
m=size(cloud,1);
n=size(cloud,2);
cloud=reshape(cloud,[],3);
indices=find(cloud(:,3));
clean_cloud=cloud(indices,:);

best_model=zeros(3,1);

while(n_inliers<105000)
    %%%%%sampling

    sample = datasample(clean_cloud,3);
    sample = transpose(sample);

    %%%%model
    model=cross(sample(:,2)-sample(:,1),sample(:,3)-sample(:,1));
    model=model/norm(model);
    
    %%%%%distances

    fuckthis(:,1)=clean_cloud(:,1)-sample(1,1);
    fuckthis(:,2)=clean_cloud(:,2)-sample(2,1);
    fuckthis(:,3)=clean_cloud(:,3)-sample(3,1);
    distance=abs(fuckthis*model);
   
    %%%%inliers
    n_inliers=sum(distance<threshold);
    

    %%%Best model

    if n_inliers>max_inliers
        max_inliers=n_inliers;
        best_model=model;
    end
    i=i+1;
    
end
fuck(:,1)=cloud(:,1)-sample(1,1);
fuck(:,2)=cloud(:,2)-sample(2,1);
fuck(:,3)=cloud(:,3)-sample(3,1);
dist=abs(fuck*model);
planeindices=find(dist<threshold);
newCind=find(dist>threshold);
plane=cloud(planeindices,:);
NewCloud=cloud;
NewCloud(planeindices,:)=NaN;
cloud=reshape(cloud,[m,n,3]);
NewCloud=reshape(NewCloud,[m,n,3]);



