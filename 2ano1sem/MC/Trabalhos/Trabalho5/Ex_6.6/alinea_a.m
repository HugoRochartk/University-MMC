% Exercício 6.6. alínea a)

help bvp4c;

% OUTPUT:

% bvp4c - Solve boundary value problem — fourth-order method
% This MATLAB function integrates a system of differential equations of
% the form y′ = f(x,y) specified by odefun, subject to the boundary
% conditions described by bcfun and the initial solution guess solinit.

% Syntax
% sol = bvp4c(odefun,bcfun,solinit)
% sol = bvp4c(odefun,bcfun,solinit,options)

% Input Arguments
% odefun - Functions to solve
% function handle
% bcfun - Boundary conditions
% function handle
% solinit - Initial guess of solution
% structure
% options - Option structure
% structure

% Output Arguments
% sol - Solution structure
% structure

% Examples
% Solve Second-Order BVP
% Compare bvp4c and bvp5c Solvers

% See also bvp5c, bvpget, bvpinit, bvpset, bvpxtend, deval

% Introduced in MATLAB before R2006a
% Documentation for bvp4c
