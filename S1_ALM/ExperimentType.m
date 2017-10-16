%{
# Possible types of experiment (e.g. behavior, ephys, etc)
experiment_type             : varchar(40)                   # 
---
%}


classdef ExperimentType < dj.Lookup
    properties
      contents = {'behavior'
          'ephys'}
    end
end