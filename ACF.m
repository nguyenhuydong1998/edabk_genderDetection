function [R, R0] = ACF(x,k1,k2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Description: Calculate Auto-correlation R(0)and R(k1->k2)
%                
%   x - data input
%   0 <= k1 < k2 <= length(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R = zeros(1,k2-k1+1);
R0 = 0;
for i = k1:k2
    for j = i:length(x)
        if (x(j-i+1) == 0)||(x(j) == 0)
            R(i-k1+1) = R(i-k1+1);
        elseif x(j-i+1) == x(j)
            R(i-k1+1) = R(i-k1+1) + 1;
        else
            R(i-k1+1) = R(i-k1+1) - 1;
        end
    end
end
for i = 1:length(x)
        if x(i) == 0

        else
            R0 = R0 + 1;
        end
end

