clc
clear all
close all

%% Test Aircraft Initialization
ac = aircraft.Aircraft('A320');

%% Testing Airfoil Fitting
root_airfoil = geometry.AirfoilReader([ac.base_airfoil '.dat']);
root_fit = geometry.FittedAirfoil(root_airfoil);
root_cst = root_fit.CSTAirfoil;

tip_airfoil = root_fit.scale(1.0, 0.1);
tip_cst = tip_airfoil.CSTAirfoil;

%% Testing Design Vector
A_root = [root_cst.A_upper', root_cst.A_lower'];
A_tip = [tip_cst.A_upper', tip_cst.A_lower'];

x = optimize.DesignVector({'lambda_1', 31.87, 0, 1.25;...
                           'lambda_2', 27.285, 0.94, 1.25;...
                           'b', 33.91, 0.71, 1.06;...
                           'c_r', 7.3834, 0.68, 1.15;...
                           'tau', 0.2002, 0.16, 2.5;...
                           'A_root', A_root, -2.0, -2.0;...
                           'A_tip', A_tip, -2.0, -2.0;...
                           'beta_root', 4.82, 0, 1.7;...
                           'beta_kink', 0.62, -0.8, 3.2;...
                           'beta_tip', -0.56, -3.6, 3.6;...
                           'A_L', 1702, -1.5, 1.5;...
                           'N_L', 1702, -1.5, 1.5;...
                           'A_M', 1702, -1.5, 1.5;...
                           'N_M', 1702, -1.5, 1.5;...
                           'W_w_hat', 9600, 0.8, 1.2;...
                           'W_f_hat', 23330, 0.8, 1.2;...
                           'C_dw_hat', 1702, 0.1, 2.2});
                       
x.update(x.vector * 1.25);
x.update(x.vector * 0.8);

assert(all((x.init .* x.vector) == x.init), 'Design Vector Corrupted');

%% Creating a EMWET Worker and Running
s = structures.Structures(x, ac);
assert(~isempty(fieldnames(s.EMWET_output)), 'EMWET Output Not Recieved')