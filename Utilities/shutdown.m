%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script  : shutdown
% Goal    : Clean up the environment for the current project. This script
%           undoes the settings applied at the project's setup. It should
%           be called by a shutdown shortcut linked to its Simulink Project.
%
% Author  : Sebastien Dupertuis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Begin the termination of the project...');

% Use Simulink Project API to get the current project
p = slproject.getCurrentProject;
projectRoot = p.RootFolder;

% Remove paths added for this project. Get the single definition of the
% folders to add to the path:
folders = project_paths();

% Remove these from the MATLAB path:
for k=1:1:numel(folders)
  rmpath(fullfile(projectRoot, folders{k}));
end

% Reset the location of slprj.
Simulink.fileGenControl('reset');
% To use in script mode only with the function line commented
cd ..
disp('Project closed.');
pause(2); clear all; clc;
