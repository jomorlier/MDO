
classdef Planform
    
    properties(Constant)
        Cr = 7.6863;     %Root chord[m]
        Sweep =25*pi/180;  %Quarter chord sweep angle[rad]
        tau = 0.24;    %Taper ratio(Ct/Cr)[-]
        b = 33.91;      %Wing span(total)[m]
        gamma = 8.3402  %Straight TE length of the first trapezoid(set)[m]
    end
    properties(Dependent)
        Chords          %Root, mid and tip chord in order[m]
        Coords          %Coordinates of root, mid and tip chord LE(x,y,z)[m]
        MAC             %Mean aerodynamic chord[m]
        S               %Wing planform area[m^2]
        
    end
    
    
    methods
        function a = get.S(obj)
            %Function for calculating the wing planform area
            cr = obj.Cr;
            g = obj.gamma;
            s = obj.Sweep;
            B = obj.b;
            t = obj.tau;
            
            a = g*(2*cr - (4/3)*g*tan(s)) + (0.5*B-g)*((1+t)*cr-(4/3)*...
                g*tan(s));
        end
        
        function b = get.Chords(obj)
            %Function for calculating the various wing chords
            b(1) = obj.Cr;
            b(2) = obj.Cr - (4/3)*obj.gamma*tan(obj.Sweep);
            b(3) = obj.tau*obj.Cr;
        end
        
        function c = get.Coords(obj)
            %Function for calculating the coordinates of the chord leading
            %edges
            x0 = 0;
            y0 = 0;
            z0 = 0;
            x1 = 0.25*obj.Cr + obj.gamma*tan(obj.Sweep);
            y1 = obj.gamma;
            z1 = 0;
            x2 = 0.25*obj.Cr + 0.5*obj.b*tan(obj.Sweep);
            y2 = 0.5*obj.b;
            z2 = 0;
            
            c = [x0, y0, z0;
                x1, y1, z1;
                x2, y2, z2];
        end
        
        function d = get.MAC(obj)
            %Function for calculating the mean aerodynamic chord
            cr = obj.Cr;
            g = obj.gamma;
            s = obj.Sweep;
            B = obj.b;
            t = obj.tau;
            cm = cr - (4/3)*g*tan(s);
            ct = t*cr;
            
            a = g*(2*cr - (4/3)*g*tan(s)) + (0.5*B-g)*((1+t)*cr-(4/3)*...
                g*tan(s));
            
            C1 = (1/(4*tan(s)))*(cr^3 -(cr-(4/3)*tan(s)*g)^3);
            C2 = (0.5*B - g)*(ct^3)/(3*(1-(ct/cm))*cm);
            d = 2*(C1 + C2)/a;
            
            
        end
        
        
        
        
        
       
        
        
    end
end

        
        
% x = [34.10, 6.07, 25*pi/180, -25*pi/180, 0.247, 4.47];
% 
% b = x(1);
% Cr = x(2);
% S1 = x(3);
% S2 = x(4);
% tau = x(5);
% g = x(6);
% 
% Cm = Cr-(4*g/3)*tan(S1);
% Ct = tau*Cr;
% 
% A = g*tan(S1) - 0.25*Cm;
% B = g*tan(S1) + (0.5*b - g)*tan(S2) - 0.25*Ct;
% C = 3*Cr/4;
% D = g*tan(S1) + (0.5*b-g)*tan(S2) +(3*Ct/4);
% 
% 
% Le_1 = @(y) (((Cr - Cm)/(4*g)) + tan(S1)).*y - 0.25*Cr;
% Le_2 = @(y) ((A-B).*y + g*B -0.5*b*A)./(g - 0.5*b);
% Te_1 = @(y) (3*Cr/4)*ones(1,length(y));
% Te_2 = @(y) ((C-D).*y + g*D - 0.5*b*C)./(g - 0.5*b);
% 
% y1 = linspace(0, g, 20);
% y2 = linspace(g, 0.5*b, 20);
% 
% wline = 2;
% figure
% plot([0, 0], [-Cr/4, 3*Cr/4],'LineWidth',wline)
% hold on
% plot([g, g], [A, C],'LineWidth',wline)
% hold on
% plot([0.5*b 0.5*b],[B,D],'LineWidth',wline)
% hold on
% plot([0, g], [0, g*tan(S1)],'LineWidth',wline)
% hold on
% plot([g, 0.5*b], [g*tan(S1), g*tan(S1) + (0.5*b-g)*tan(S2)],'LineWidth',wline)
% hold on
% plot(y1, Le_1(y1),'LineWidth',wline)
% hold on
% plot(y1, Te_1(y1),'LineWidth',wline)
% hold on
% plot(y2, Le_2(y2),'LineWidth',wline)
% hold on
% plot(y2, Te_2(y2),'LineWidth',wline)
% 
% legend('Root chord', 'Mid chord', 'Tip chord', 'First quarter chord'...
%     ,'Second quarter chord', 'First leading edge','First trailing edge'...
%     ,'Second leading edge','Second trailing edge','Location','southeast')
% 

