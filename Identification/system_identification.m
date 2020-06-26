%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script : system_identification
% Goal   : Non linear fit of a set of data coming from a real pendulum.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load '.\..\Data\Measurements';

% Constants declaration
TS = Time(2)-Time(1);
FIRST_SAMPLES = 2500;
% Parameters of the non linear fit
GRAVITY  = 9.807; % In the Simulink model, g is defined as negative.
MASS     = 1;     % The sign of g is reversed here and in the equations
LENGTH   = 1.05;
FRICTION = 0.13;

% Definition of the complete set of data
data = iddata(Theta,Torque,TS,'Name','Pendulum');
data.OutputName = 'Pendulum position';
data.OutputUnit = 'rad';
data.InputName  = 'Torque';
data.Tstart     = 0;
data.TimeUnit   = 's';

% Take the 10 first periods of oscillations for the non linear fit
Torque = Torque(1:FIRST_SAMPLES);
Theta  = Theta(1:FIRST_SAMPLES);
Time   = Time(1:FIRST_SAMPLES);
% Definition of the selected set of data to apply to the non linear fit
z = iddata(Theta,Torque,TS,'Name','Pendulum');
z.OutputName = 'Pendulum position';
z.OutputUnit = 'rad';
z.InputName  = 'Torque';
z.Tstart     = 0;
z.TimeUnit   = 's';

% Non linear fit definition
FileName      = 'pendulum_m';     % File describing the model structure
Order         = [1 1 2];          % Model orders [ny nu nx]
Parameters    = [GRAVITY; LENGTH;...
                 FRICTION; MASS]; % Initial parameters
InitialStates = [-pi; 0];         % Initial initial states
Ts            = 0;                % Time-continuous system
nlgr = idnlgrey(FileName,Order,Parameters,InitialStates,Ts);
nlgr.OutputName = 'Pendulum position';
nlgr.OutputUnit = 'rad';
nlgr.TimeUnit   = 's';
nlgr = setinit(nlgr,'Name',{'Pendulum position' 'Pendulum velocity'});
nlgr = setinit(nlgr,'Unit',{'rad' 'rad/s'});
nlgr = setpar (nlgr,'Name',{'Gravity constant' 'Length' ...
                    'Friction coefficient' 'Mass'});
nlgr = setpar (nlgr,'Unit',{'m/s^2' 'm' 'Nms/rad' 'kg'});
nlgr = setpar (nlgr,'Minimum',{eps(0) eps(0) eps(0) eps(0)}); % All parameters > 0

% Estimate LENGTH and FRICTION, but do not estimate GRAVITY and MASS
nlgr = setpar(nlgr, 'Fixed', {true false false true});
nlgr = pem(z,nlgr,'Display','Full');

% Save non linear fit object
save('.\..\Data\Ident_nlgr.mat','nlgr');

% Estimated parameters
disp(['Pendulum length: ' num2str(nlgr.parameters(2).Value)]);
disp(['Fluid friction : ' num2str(nlgr.parameters(3).Value)]);
% Comparison of the fit with data used for identification
compare(z,nlgr);
% Comparison of the fit with the full set of data
% compare(data,nlgr);
