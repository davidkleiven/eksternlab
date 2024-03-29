

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
   
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                     NYTTIGE FUNKSJONER                            %%
%%               KOPIER DISSE TIL FILA DU JOBBER MED                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function cs = height(x, y)
  %% Funksjon for å tilpasse en kubisk spline til et sett med punkter
  %% 
  %% Parametre
  %% x - array med horisontale koordinater
  %% y - array med vertikale koordinater
  %%
  %% Eksempel
  %% x = [0.0, 0.2, 0.3]
  %% y = [1.0, 0.5, 1.0]
  %% cs = height(x, y)
  %%
  %% For å evaluere splinetilpasningen i vilkårlige punkter
  %% 
  %% x_interp = linspace(0.0, 0.3, 10)
  %% y_interp = ppval(cs, x_interp)
  
    cs = interp1(x, y, 'spline', 'pp');
end


function alpha = slope(cs, x)
  %% Funksjon for å evaluere hellningsvinkelen i et sett med punkter
  %%
  %% Parametre
  %% cs - Stykkevis polynom (f.eks. det som returneres fra height)
  %% x - array med punkter for hvor hellningsvinkelen skal evaluers
  %%
  %% Eksempel
  %% x = [0.0, 0.2, 0.3]
  %% y = [1.0, 0.5, 1.0]
  %% cs = height(x, y)
  %% x_interp = linspace(0.0, 0.3, 10)
  %% alpha = slope(cs, x_interp) 
    dydx = fnder(cs, 1);
    y = ppval(dydx, x);
    alpha = -atan(y);
end


function kappa = curvature(cs, x)
  %% Funksjon for å beregne krumingen til banen
  %%
  %% Parametre
  %% cs - Stykkevis polynom (f.eks. det som returneres fra height)
  %% x - array med verdier hvor krumningen skal evalueres
  %% Eksempel
  %% x = [0.0, 0.2, 0.3]
  %% y = [1.0, 0.5, 1.0]
  %% cs = height(x, y)
  %% x_interp = linspace(0.0, 0.3, 10)
  %% kappa = curvature(cs, x_interp) 
  
    dydx = fnder(cs, 1);
    dy2dx2 = fnder(dydx, 2);
    dydx_sq = ppval(dydx, x).^2;
    kappa = ppval(dy2dx2, x)./((1.0 + dydx_sq).^1.5);
end


