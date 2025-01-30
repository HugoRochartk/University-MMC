% Exercício 5.26. alínea b)
 
function vdpodeRK(MU)
%VDPODERK  Parameterizable van der Pol equation (stiff for large MU).
%   For the default value of MU = 1000 the equation is in relaxation
%   oscillation, and the problems becomes very stiff.  The limit cycle has
%   portions where the solution components change slowly and the problem is
%   quite stiff, alternating with regions of very sharp change where it is
%   not stiff (quasi-discontinuities). The initial conditions are close to
%   an area of slow change so as to test schemes for the selection of the
%   initial step size.
%
%   The nested function J(T,Y) returns the Jacobian matrix dF/dY evaluated
%   analytically at (T,Y). By default, the stiff solvers of the ODE Suite
%   approximate Jacobian matrices numerically. However, if the ODE Solver
%   property Jacobian is set to @J with ODESET, a solver calls the function
%   to obtain dF/dY. Providing the solvers with an analytic Jacobian is not
%   necessary, but it can improve the reliability and efficiency of
%   integration.
%
%   L. F. Shampine, Evaluation of a test set for stiff ODE solvers, ACM
%   Trans. Math. Soft., 7 (1981) pp. 409-420.
%
%   See also ODE15S, ODE23S, ODE23T, ODE23TB, ODESET, FUNCTION_HANDLE.

%   Mark W. Reichelt and Lawrence F. Shampine, 3-23-94, 4-19-94
%   Copyright 1984-2014 The MathWorks, Inc.

% Problem parameter, shared with nested functions.
if nargin < 1
   MU = 1000;     % default
end

tspan = [0; max(20,3*MU)];   % several periods
y0 = [2; 0];
options = odeset('Jacobian',@J);

[t,y] = ode45(@f,tspan,y0,options);

figure;
plot(t,y(:,1));
title(['Solution of van der Pol Equation with ode45, \mu = ' num2str(MU)]);
xlabel('time t');
ylabel('solution y_1');

axis([tspan(1) tspan(end) -2.5 2.5]);

% -----------------------------------------------------------------------
% Nested functions -- MU is provided by the outer function.
%

   function dydt = f(t,y)
      % Derivative function. MU is provided by the outer function.
      dydt = [            y(2)
         MU*(1-y(1)^2)*y(2)-y(1) ];
   end
% -----------------------------------------------------------------------

   function dfdy = J(t,y)
      % Jacobian function. MU is provided by the outer function.
      dfdy = [         0                  1
         -2*MU*y(1)*y(2)-1    MU*(1-y(1)^2) ];
   end
% -----------------------------------------------------------------------

end  % vdpodeRK
