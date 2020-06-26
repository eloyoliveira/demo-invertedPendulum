function [dx,y] = pendulum_m(t,x,u,g,l,k,m,varargin) %#ok<INUSL>
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: pendulum_m()
% Goal    : Definition of a non linear equations system of a real pendulum.
%
% IN      : - t  : current time, mendatory for idnlgrey() but not used here
%           - x  : state vector at time t containing the angular position
%                  x(1) and velocity x(2)
%           - u  : input vector at time t containing the injected torque
%           - g  : gravity parameter
%           - l  : pendulum length parameter
%           - k  : fluid friction parameter
%           - m  : pendulum mass parameter
% IN/OUT  : -
% OUT     : - dx : right side vector of the state-space equation
%           - y  : right side of the output equation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Output equation giving the angular position
  y = x(1);
  % State equations with dx = [dtheta; ddtheta]
  dx = [ x(2);                           ... % Angular velocity
        u+(g/l)*sin(x(1))-k/(m*l^2)*x(2) ... % Angular acceleration
       ]; % Change g sign to positive and change sign here as well
end
