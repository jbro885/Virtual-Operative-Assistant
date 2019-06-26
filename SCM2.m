function [proceed_step5] = SCM2(Motion_met,Motion_mean,Motion_mean_exp,Motion_max_exp,new_name_motion)

fignum=0;
f1=figure('Position',[1921 361 1365 720]);
f4=figure('Position',[6017 313 1360 768]);
proceed_step5=0;
for i=1:2
    fignum=fignum+1;
    figure(f1);subplot(1,2,fignum);hold on;title(new_name_motion(i));
    if i==1
        patch([0,1,1,0],[Motion_mean(i),Motion_mean(i),-10000,-10000],[152/256,251/256,152/256]);  
        patch([0,1,1,0],[Motion_mean(i),Motion_mean(i),10000,10000],[255/256,102/256,102/256]);
    else
        patch([0,1,1,0],[Motion_mean(i),Motion_mean(i),10000,10000],[152/256,251/256,152/256]);  
        patch([0,1,1,0],[Motion_mean(i),Motion_mean(i),-10000,-10000],[255/256,102/256,102/256]);
    end
    
    line([0,1],[Motion_mean(i),Motion_mean(i)]);
    set(findall(gca, 'Type', 'Line'),'LineWidth',4);
    line([0,1],[Motion_mean_exp(i),Motion_mean_exp(i)],'LineStyle','--');
    line([0,1],[Motion_max_exp(i),Motion_max_exp(i)],'LineStyle',':');
    scatter(0.5,Motion_met(i),90,'o','filled','w');
    set(gca,'XTick',[]);
    if Motion_met(i) > Motion_mean(i)
        ylim([Motion_mean(i)-abs(Motion_mean(i)),Motion_met(i)+abs(Motion_met(i))]);
    else
        ylim([Motion_met(i)-abs(Motion_met(i)),Motion_mean(i)+abs(Motion_mean(i))]);
    end
    % Custom screw up message
    if i==1
         if Motion_met(i) > Motion_mean(i)
            xlabel({'To improve, we suggest that you',...
                'increase the speed of your suction',...
                'when touching other vertebra'},...
            'Color','red',...
            'FontSize',10,...
            'FontWeight','bold',...
            'HorizontalAlignment','center');
         else
%              xlabel({'Good job'},...
%             'Color','green',...
%             'FontSize',10,...
%             'FontWeight','bold',...
%             'HorizontalAlignment','center');
        proceed_step5 = proceed_step5+1;
         end
    elseif i==2
        if Motion_met(i) < Motion_mean(i)
            xlabel({'To improve, we suggest that you',...
                'increase the number of up-and-down',...
                'movements of your suction when touching L3'},...
            'Color','red',...
            'FontSize',10,...
            'FontWeight','bold',...
            'HorizontalAlignment','center');
        else
%             xlabel({'Good job'},...
%             'Color','green',...
%             'FontSize',10,...
%             'FontWeight','bold',...
%             'HorizontalAlignment','center');
                proceed_step5 = proceed_step5+1;
        end
    end  
end

%% Proceed Feedback
figure(f4);plot(1,1);axis off;title('Step 5: Advanced Suction Assessment','FontSize',40);hold on;
if proceed_step5 < 1
    text(1,0.9,{'We noticed that you are still struggling with your basic suction motions.',...
        'In order to move on to further steps, you need to achieve exprtise in these components first.'},...
        'Color','b',...
        'FontSize',20,...
        'HorizontalAlignment','center');
elseif proceed_step5 < 2
    if Motion_met(1) < Motion_mean(1)
        text(1,0.9,{'You are almost there! Overall, your suction speeds on other vertebra are very good.',...
            'Now, try to focus on increasing the number of up and down',...
            'movements of your suction while in contact with L3'},...
        'Color','b',...
        'FontSize',20,...
        'HorizontalAlignment','center');
    elseif Motion_met(2) > Motion_mean(2)
        text(1,0.9,{'You are almost there! Your are using your suction very well when interacting with L3. Now you should focus on decreasing your suction speeds on other vertebra.'},...
            'Color','b',...
            'FontSize',20,...
            'HorizontalAlignment','center');
    elseif proceed_step5 == 2
        text(1,0.9,{"Congrats! You freakin' did it m8",...
            'Press any key to move on to the next step'},...
            'Color','b',...
            'FontSize',20,...
            'HorizontalAlignment','center');
    end
end