%{
# Type of tasks
task_name                    : varchar(40)                         # task type
---
%}


classdef TaskType < dj.Lookup
    properties
       contents = {'S1_stim_task'
          'Sound_task'
          'Pole_task'}
    end
end