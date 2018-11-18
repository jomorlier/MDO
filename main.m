% Copyright 2018 San Kilkis, Evert Bunschoten
% 
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
% 
%    http://www.apache.org/licenses/LICENSE-2.0
% 
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.

%% Setting Optimization Options for fmincon

options.Display             = 'iter-detailed';  % Display in Command Win.
options.Algorithm           = 'sqp';
options.FunValCheck         = 'off';            % Obj. Function Checking 
options.DiffMinChange       = 1e-4;             % Min. Delta for Gradient
options.DiffMaxChange       = 1e-2;             % Max. Delta for Gradient
options.TolCon              = 1e-3;             % Constraint Tolerance
options.TolFun              = 1e-3;             % Obj. Function Tolerance
options.TolX                = 1e-3;             % Step Tolerance
options.MaxIter             = 1e5;              % Maximum Iterations
options.PlotFcns            = {@optimplotx,...
                               @optimplotfval,...
                               @optimplotfirstorderopt};         
                       
%% Initializing a Run-Case for the A320 from data\aircraft\A320.mat
% Additional aircraft can be supplied by the user w/ template.m

run_case = optimize.RunCase('A320', options);
run_case.aircraft.planform.plot();
run_case.aircraft.CST.root.plot();
run_case.aircraft.CST.tip.plot();

%% Running Optimization w/ fmincon
run_case.optimize();

%% Plotting Final Result

run_case.aircraft.planform.plot();
run_case.aircraft.CST.root.plot();
run_case.aircraft.CST.tip.plot();
% TODO implement way to plot into the same object
