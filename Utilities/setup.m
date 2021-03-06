function setup()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: setup()
% Goal    : Set-up the environment for this Simulink Project. This function
%           should be called by a startup shortcut linked to its Simulink
%           Project.
% IN      : -
% IN/OUT  : -
% OUT     : -
%
% Author  : Sebastien Dupertuis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  disp('Begin the initialization of the project...');

  % Use Simulink Project API to get the current project
  project = simulinkproject;

  % Set the path for this project
  folders = project_paths();
  for k=1:1:numel(folders)
    addpath(fullfile(project.RootFolder,folders{k}));
  end

  % Set the location of the folder slprj to be the "Work" folder of the
  % current project
  cache_folder = fullfile(project.RootFolder,'Work');
  if (~exist(cache_folder,'dir'))
    mkdir(cache_folder)
  end
  Simulink.fileGenControl('set','CacheFolder',cache_folder,...
                          'CodeGenFolder',cache_folder);

  % Go to the working directory
  cd(cache_folder)

  disp('Initialization of the project done.');
end
