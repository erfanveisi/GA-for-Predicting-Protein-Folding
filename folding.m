clear all
figure;
hold on;
grid on 
grid minor
hold on
 %____________________________________________plot the sequance
 %1=blue and 0=red
 x=[0 0 1;0 1 0;0 2 0;1 2 1;2 2 0;2 1 1;1 1 1;1 0 0;2 0 0;3 0 0;3 1 1];
 hold on;
 plot(x(1,1),x(1,2),'og','markerfacecolor','g')
 hold on
 plot(x(2,1),x(2,2),'or','markerfacecolor','r')
 plot([x(1,1) x(2,1)],[x(1,2) x(2,2)])
 n=11;
 for i=3:n
     fprintf('%c\n',(i))
     if x(i,3)==1;
         plot(x(i,1),x(i,2),'og','markerfacecolor','g')
     end
     if x(i,3)==0;
        plot(x(i,1),x(i,2),'or','markerfacecolor','r') 
     end
     plot([x(i,1) x(i-1,1)],[x(i,2) x(i-1,2)])
 end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 b=zeros(n,1);
 if(( x(1,1)==0) && (x(1,2)==0))
 b(2,1)='X';   
 end
 for i=3:n
     if x(i,1)==x(i-1,1) && x(i,2)==x(i-1,2)+1
         b(i,1)='X';
     end
     if x(i,1)==x(i-1,1) && x(i,2)==x(i-1,2)-1
         b(i,1)='Y';
     end    
     if x(i,1)==x(i-1,1)+1 && x(i,2)==x(i-1,2)
         b(i,1)='M';
     end    
     if x(i,1)==x(i-1,1)-1 && x(i,2)==x(i-1,2)
         b(i,1)='N';
     end    
 end
 r_adja=zeros(n-1,3);
 l_adja=zeros(n-1,3);
 up_adja=zeros(n-1,3);
 down_adja=zeros(n-1,3);
 hh=[0 0 1;1 0 0;2 0 0; 3 0 0;0 1 0;1 1 1;2 1 1; 3 1 1; 0 2 0;1 2 1; 2 2 0;];
 r_adja(1,:)=hh(2,:);
 l_adja(1,:)=[':' ':' ':' ];
 up_adja(1,:)=hh(5,:);
 down_adja(1,:)=[':' ':' ':' ];

 for z=(2:n-1)
      fprintf('%d\n',z)
      
            if hh(z+1,1)==hh(z,1)+1 && hh(z+1,2)==hh(z,2)
                
                r_adja(z,:)=[hh(z+1,1) hh(z+1,2) hh(z+1,3)];
              
            else
                r_adja(z,:)=[':' ':' ':' ]; 
            end
 end
      
        for z=(2:n)
          if hh(z,1)==hh(z-1,1)+1 && hh(z,2)==hh(z-1,2)
                
                l_adja(z,:)=[hh(z-1,1) hh(z-1,2) hh(z-1,3)];
            else
              l_adja(z,:)=[':' ':' ':' ]; 
          end
        end
         down_adja(1,:)=[':' ':' ':' ]; 
         down_adja(2,:)=[':' ':' ':' ]; 
         down_adja(3,:)=[':' ':' ':' ]; 
         down_adja(4,:)=[':' ':' ':' ]; 
        for z=(5:n)     
           if hh(z,1)==hh(z,1) && hh(z,2)==hh(z,2)+1
                
               down_adja=[hh(z,1) hh(z,2) hh(z+1,3)];
            else
                down_adja(z,:)=[':' ':' ':' ];  
           end
        end
                   
 
 

 
 
