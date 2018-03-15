function [Xk_op, Yk_op] = orb_plane(Rk, Uk)
Xk_op = Rk.*cos(Uk);
Yk_op = Rk.*sin(Uk);
end