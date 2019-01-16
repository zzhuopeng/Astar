%% A*·���滮�㷨Matlabʵ�֡��ο����ϣ�http://www.huqj.top/article?id=24��

function [open,close]=Astar(map)
    %% 1.��ʼ��
    [row,col]=size(map);%����rowΪ�У�colΪ��
    close=struct('row',-1,'col',-1,'g',0,'h',0); %�����б��ṹ������
    closelen=1;
    open=struct('row',-1,'col',-1,'g',-1,'h',-1); %�ر��б��ṹ������
    openlen=0;
    
    %�ҵ��ϰ���
    bindex=1;
    for k=1:row
        for j=1:col
            if map(k,j)==1
                barrierrow(bindex)=-k;
                barriercol(bindex)=j;
                bindex=bindex+1;
            end
        end
    end
    
    %�ҵ��յ�
    for i=1:row
        for j=1:col
            if map(i,j)==2
                endrow=i;
                endcol=j;
                break;
            end
        end
    end
    
    %�ҵ���㣬�����ӵ�close�б�
    for i=1:row
        for j=1:col
          if map(i,j)==5
              startrow=i;
              startcol=j;
              close(1).row=i;
              close(1).col=j;
              break;
          end
        end
    end
    
    %open�б����ӽڵ�
%     direct=[0 -1; 0 1; -1 0; 1 0];%ֱ������4�����൱��ֻ��ֱ�ߣ�����б���ߣ�
    direct=[-1 0; 1 0; -1 -1; 1 1; -1 1; 1 -1;];%����6���񣨲���ֱ�������ߣ�
    for i=1:6
        if all( [close(1).row,close(1).col]+direct(i,:)>0 ) ...
        && close(1).row+direct(i,1)<=row && close(1).col+direct(i,2)<=col ...
        && map(close(1).row+direct(i,1),close(1).col+direct(i,2))~=1
            open(openlen+1).row=close(1).row+direct(i,1);
            open(openlen+1).col=close(1).col+direct(i,2);
            openlen=openlen+1;
            %���������ӽڵ��Ӧ��g���������Ĵ��ۣ���h�������յ�Ĵ��ۣ�
            open(openlen).g=1;
            open(openlen).h=abs(endrow-open(openlen).row)+abs(endcol-open(openlen).col);%����ʹ���������پ���
        end
    end
    
    %% 2.��ʼѰ·
    while openlen>0
        %�ҵ�open�б���F����Сֵ��Ӧ�Ľڵ㣬����F=G+H
        min = realmax; %���ؼ�������ܱ�ʾ���������˫���ȣ���������
        for i=1:openlen
            if open(i).g+open(i).h<=min
                min=open(i).g+open(i).h;
                sindex=i;
            end
        end

        %��F��Сֵ��Ӧ�ڵ���Ϊ��һ���ڵ㣬��open�б���ɾ��&���ӵ�close�б���
        close(closelen+1).row=open(sindex).row;
        close(closelen+1).col=open(sindex).col;
        close(closelen+1).g=open(sindex).g;
        close(closelen+1).h=open(sindex).h;
        closelen=closelen+1;
        
%         open(sindex)=[]; %zzp����
%         openlen=openlen-1;
        
%         openlen=openlen-1;
%         for i=sindex:openlen
%             open(i)=open(i+1);
%         end
%         open(openlen+1)=[];

        openlen=0;

        %�������¸�����ԭ��ͼ
        pause(0.1)%��ͣ0.1s
        img = zeros(row,col);
        %�ҵ���Ӧ�����
        img(startrow,startcol)=10;
        %�ҵ���Ӧ���ϰ���
        for k=1:row
            for j=1:col
                if map(k,j)==1
                    img(k,j)=5;
                end
            end
        end
        %�ҵ���Ӧ��close�б�
        for k=2:closelen
            img(close(k).row,close(k).col)=3;
        end
        %�ҵ���Ӧ���յ�
        img(endrow,endcol)=10;
        imagesc(img*10);%��ͼ����

        %��������յ���ֹͣ
        if close(closelen).row == endrow && close(closelen).col==endcol
            break;
        end

        %open�б����ӽڵ�
        for i=1:6
            if all([close(closelen).row,close(closelen).col]+direct(i,:)>0) ...
            && close(closelen).row+direct(i,1)<=row && close(closelen).col+direct(i,2)<=col ...
            && map(close(closelen).row+direct(i,1), close(closelen).col+direct(i,2))~=1
               %�жϸýڵ��Ƿ��Ѿ�����close�б���
               flag=false;
               for m=1:closelen
                   if close(m).row==close(closelen).row+direct(i,1) ...
                   && close(m).col==close(closelen).col+direct(i,2)
                       flag=true;
                       break;
                   end
               end
               %�Ѿ�����close�еĻ������˳���ǰѭ��
               if flag
                    continue;
               end

               %�жϸýڵ��Ƿ��Ѿ�����open�б���
               flag=false;
               for m=1:openlen
                   if open(m).row==close(closelen).row+direct(i,1) ...
                   && open(m).col==close(closelen).col+direct(i,2)
                       flag=true;
                       break;
                   end
               end
               %�Ѿ�����open�еĻ������˳���ǰѭ��
               if flag
                    continue;
               else  %�������ӵ�open��
                    open(openlen+1).row=close(closelen).row+direct(i,1);
                    open(openlen+1).col=close(closelen).col+direct(i,2);
                    openlen=openlen+1;
                    %���������ӽڵ��Ӧ��g���������Ĵ��ۣ���h�������յ�Ĵ��ۣ�
                    open(openlen).g=close(closelen).g+1;
                    open(openlen).h=abs(endrow-open(openlen).row)+abs(endcol-open(openlen).col);
                    h=open(openlen).h;
               end
            end
        end
    end