function [XkC1, XkP1, XkP2, YkC1, YkP1, YkP2, ZkC1, ZkP1, ZkP2] =...
    e_fix_coor(IkC1, IkP1, IkP2, Xk_op, Yk_op, omega_kC1, omega_kP1, omega_kP2)

XkC1 = Xk_op.*cos(omega_kC1)-Yk_op.*cos(IkC1).*sin(omega_kC1);
XkP1 = Xk_op.*cos(omega_kP1)-Yk_op.*cos(IkP1).*sin(omega_kP1);
XkP2 = Xk_op.*cos(omega_kP2)-Yk_op.*cos(IkP2).*sin(omega_kP2);

YkC1 = Xk_op.*sin(omega_kC1)-Yk_op.*cos(IkC1).*cos(omega_kC1);
YkP1 = Xk_op.*sin(omega_kP1)-Yk_op.*cos(IkP1).*cos(omega_kP1);
YkP2 = Xk_op.*sin(omega_kP2)-Yk_op.*cos(IkP2).*cos(omega_kP2);

ZkC1 = Yk_op.*sin(IkC1);
ZkP1 = Yk_op.*sin(IkP1);
ZkP2 = Yk_op.*sin(IkP2);
end