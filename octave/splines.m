

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              TESTFUNKSJON (IKKE BRUK DETTE)                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function splines()
    x = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0];
    y = [1.0, 0.6, 0.5, 0.45, 0.5, 0.6];
    cs = height(x, y);
    
    % Evaluer i set sett med pukter ved bruk av ppval
    x_interp = linspace(0.0, 1.0, 40);
    figure(1);
    hold on;
    plot(x_interp, ppval(cs, x_interp));
    xlabel("x posisjon (cm)");
    ylabel("y posisjon (cm)");
    
    % Evaluer stigning
    alpha = slope(cs, x_interp);
    figure(2);
    plot(x_interp, alpha*180/pi);
    xlabel("x posisjon (cm)")
    ylabel("Hellningsvinkel (grader)");
    
    % Evaluer krumining
    kappa = curvature(cs, x_interp);
    figure(3);
    plot(x_interp, kappa)
    xlabel("x posisjon (cm)")
    ylabel("Krumning $cm^{-1}$")
   
    
endfunction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                     NYTTIGE FUNKSJONER                            %%
%%               KOPIER DISSE TIL FILA DU JOBBER MED                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function cs = height(x, y)
    cs = interp1(x, y, 'spline', 'pp');
endfunction


function alpha = slope(cs, x)
    dydx = ppder(cs);
    y = ppval(dydx, x);
    alpha = -atan(y);
endfunction


function kappa = curvature(cs, x)
    dydx = ppder(cs);
    dy2dx2 = ppder(dydx);
    dydx_sq = ppval(dydx, x).^2;
    kappa = ppval(dy2dx2, x)./((1.0 + dydx_sq).^1.5);
endfunction


