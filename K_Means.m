
function [miu ind]=K_Means(data,K,lampda,limit)   
   [m n]=size(data);   % n is the number of feature; m is the number of sample
   miu=zeros(K,n);       
%random initialization
%     ma=zeros(n);        
%     mi=zeros(n);        
%     for i=1:n
%        ma(i)=max(data(:,i));    
%        mi(i)=min(data(:,i));    
%        for j=1:N
%             miu(j,i)=ma(i)+(mi(i)-ma(i))*rand(); 
%        end      
%     end

% Furthest first
for i=1:m
for j=1:m
furt1(i,j)=norm(data(i,:)-data(j,:));
end
end
[ind1,ind2]=find(furt1==max(max(furt1)));
miu(1,:)=data(ind1(1),:);
miu(2,:)=data(ind1(2),:);
% if more than 3 clusters
if K>=3
for ki=3:K
% caculate the distance from data point to the previous centers      
for j=1:ki-1
for i=1:m
    furt2(i,j)=norm(data(i,:)-miu(j,:));
end
end
% caculate the sum of the distance to all the previous centers  
sumfurt2=sum(furt2,2);
[junk,index]=max(sumfurt2);
miu(ki,:)=data(index,:);
end
end

num=1; 
    while 1
        num=num+1;
        pre_u=miu;            %the previous center
        for i=1:K
            tmp{i}=[];      
            for j=1:m
                tmp{i}=[tmp{i};data(j,:)-miu(i,:)];% caculate the distance from m sample to the ith cluster center 
            end
        end
        
        
        
        z=zeros(m,K);
        for i=1:m      
            c=[];
            for j=1:K
%                 c=[c norm(tmp{j}(i,1:2))^2+lampda*norm(tmp{j}(i,3:4))^2];
                  c=[c norm(data(i,1:2)-miu(j,1:2))^2+lampda*norm(data(i,3:4)-miu(j,3:4))^2];
            end
            [junk index]=min(c);% the index returns the nearest center 
            z(i,index)=1;       % then set the weight of ith sample to 1 at 'index' center      
        end
        
        for i=1:K           
           for j=1:n
                miu(i,j)=sum(z(:,i).*data(:,j))/sum(z(:,i));
           end           
        end
        
        if norm(pre_u-miu)<limit %iteration to convergence
            break;
        end
        if num>10000 
            break;
        end
    end
    
    re=[];
    for i=1:m
        tmp=[];
        for j=1:K
%             tmp=[tmp norm(data(i,:)-miu(j,:))];
            tmp=[tmp norm(data(i,1:2)-miu(j,1:2))^2+lampda*norm(data(i,3:4)-miu(j,3:4))^2]
        end
        [junk index]=min(tmp);
        ind(i)=index;
        re=[re;data(i,:) index];
    end
    
end