function [ output_args ] = check_tk( tk )
%check_tk 
%   Fixes the over/under GPS week

if(tk > 302400)
    tk = tk - 604800
elseif(tk < -302400)
    tk = tk + 604800
end

output_args = tk;

end

