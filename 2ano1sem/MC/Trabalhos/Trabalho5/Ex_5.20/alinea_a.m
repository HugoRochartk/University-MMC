% Exercício 5.20. alínea a)

help ode23t
help ode23tb
help ode113

% ode23t - Solve moderately stiff ODEs and DAEs — trapezoidal rule
%    This MATLAB function, where tspan = [t0 tf], integrates the system of
%    differential equations y'=f(t,y) from t0 to tf with initial conditions
%    y0.
%
%    Syntax:
%      [t,y] = ode23t(odefun,tspan,y0)
%      [t,y] = ode23t(odefun,tspan,y0,options)
%      [t,y,te,ye,ie] = ode23t(odefun,tspan,y0,options)
%      sol = ode23t(___)
%
%    Input Arguments:
%      odefun - Functions to solve (function handle)
%      tspan  - Interval of integration (vector)
%      y0     - Initial conditions (vector)
%      options - Option structure (structure array)
%
%    Output Arguments:
%      t  - Evaluation points (column vector)
%      y  - Solutions (array)
%      te - Time of events (column vector)
%      ye - Solution at time of events (array)
%      ie - Index of triggered event function (column vector)
%      sol - Structure for evaluation (structure array)
%
%    Examples:
%      - ODE with Single Solution Component
%      - Solve Stiff ODE
%      - Pass Extra Parameters to ODE Function
%      - Compare Stiff ODE Solvers
%
%    See also ode15s, odeset, odeget, deval
%
%    Introduced in MATLAB before R2006a
%    Documentation for ode23t

% ode23tb - Solve stiff differential equations — trapezoidal rule + backward differentiation formula
%    This MATLAB function, where tspan = [t0 tf], integrates the system of
%    differential equations y'=f(t,y) from t0 to tf with initial conditions
%    y0.
%
%    Syntax:
%      [t,y] = ode23tb(odefun,tspan,y0)
%      [t,y] = ode23tb(odefun,tspan,y0,options)
%      [t,y,te,ye,ie] = ode23tb(odefun,tspan,y0,options)
%      sol = ode23tb(___)
%
%    Input Arguments:
%      odefun - Functions to solve (function handle)
%      tspan  - Interval of integration (vector)
%      y0     - Initial conditions (vector)
%      options - Option structure (structure array)
%
%    Output Arguments:
%      t  - Evaluation points (column vector)
%      y  - Solutions (array)
%      te - Time of events (column vector)
%      ye - Solution at time of events (array)
%      ie - Index of triggered event function (column vector)
%      sol - Structure for evaluation (structure array)
%
%    Examples:
%      - ODE with Single Solution Component
%      - Solve Stiff ODE
%      - Pass Extra Parameters to ODE Function
%      - Compare Stiff ODE Solvers
%
%    See also ode15s, odeset, odeget, deval
%
%    Introduced in MATLAB before R2006a
%    Documentation for ode23tb

% ode113 - Solve nonstiff differential equations — variable order method
%    This MATLAB function, where tspan = [t0 tf], integrates the system of
%    differential equations y'=f(t,y) from t0 to tf with initial conditions
%    y0.
%
%    Syntax:
%      [t,y] = ode113(odefun,tspan,y0)
%      [t,y] = ode113(odefun,tspan,y0,options)
%      [t,y,te,ye,ie] = ode113(odefun,tspan,y0,options)
%      sol = ode113(___)
%
%    Input Arguments:
%      odefun - Functions to solve (function handle)
%      tspan  - Interval of integration (vector)
%      y0     - Initial conditions (vector)
%      options - Option structure (structure array)
%
%    Output Arguments:
%      t  - Evaluation points (column vector)
%      y  - Solutions (array)
%      te - Time of events (column vector)
%      ye - Solution at time of events (array)
%      ie - Index of triggered event function (column vector)
%      sol - Structure for evaluation (structure array)
%
%    Examples:
%      - ODE with Single Solution Component
%      - Solve Nonstiff Equation
%      - Pass Extra Parameters to ODE Function
%      - ODE with Stringent Error Tolerances
%
%    See also ode45, ode78, ode89, ode23, odeset, odeget, deval, odextend
%
%    Introduced in MATLAB before R2006a
%    Documentation for ode113