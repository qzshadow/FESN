load('SonyAIBORobotSurfaceII_TEST')
tag = unique(SonyAIBORobotSurfaceII_TEST(:,1));
[m, n]=size(SonyAIBORobotSurfaceII_TEST);
n = n-1;
color = {'-r','-b','-g','-y'};
for i = 1:length(tag)
    count = 0;
    figure(1)
    subplot(1,length(tag),i);
    for j = 1:m
        if SonyAIBORobotSurfaceII_TEST(j,1) == tag(i)
            count = count+1;
            plot(1:n,SonyAIBORobotSurfaceII_TEST(j,2:end),color{count})
            hold on
            if count == 3
                hold off
                break
            end
        end
    end
end
hold off
