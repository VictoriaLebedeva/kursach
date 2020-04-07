a = 4;
b = 3;
T = 6;
m = 5;
p = 15;

state = m + T + 1;
B = zeros(state, T);
u = zeros(state, T);

for i = 1:state
    B(i,1) = a*(i - 1) + b;
end

for k = 2:T - 1
    state = state - 1
    for y = 1:state       
        if (y < state) && (a*(y - 1) + b + B(y + 1, k - 1)) <= (a*(y - 1)+ b + p + B(1, k - 1))
            B(y, k) = a*(y - 1) + b + B(y + 1, k - 1);
        else
             B(y, k) = a*(y - 1) + b + p + B(1, k - 1);
             u(y, k) = 1;             
        end        
    end   
end

for j = 1: m + 2
    if (j < m + 2) && (B(j + 1, T - 1) <= p + B(1, T - 1))
        B(j,T) = B(j + 1, T -1);
    else 
        B(j,T) = p + B(1, T - 1);
         u(j, T) = 1;     
    end
end

equipment_cost = B(m, T)
year_counter = 1;
while T >= 1
    if(u(m,T)== 0)
        disp(['Year: ', num2str(year_counter), ' � equipment is not replaced']);        
        m = m + 1;    
    else
        disp(['Year: ', num2str(year_counter), ' � equipment is replaced']);  
        m = 1;      
    end
    T = T - 1;
    year_counter = year_counter + 1;
end
