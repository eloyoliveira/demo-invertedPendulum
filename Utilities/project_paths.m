function folders = project_paths()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: project_paths()
% Goal    : Defines the folders that will be added to the MATLAB path when
%           the Simulink Project is opened, and removed from the path when
%           it is closed. Edit the definition of folders below to add paths
%           to the current project.
% IN      : -
% IN/OUT  : -
% OUT     : - folders : List of the needed folders to add to the path
%
% Author  : Sebastien Dupertuis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % folders is a cell-array of paths relative to the project root. 
  folders = { ...
    'Data', ...
    'Images', ...
    'Identification',...
    'Libraries', ...
    'Libraries\S_Functions',...
    'Models', ...
    'Utilities', ...
    'Work' ...
    };
end
