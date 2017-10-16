%{
# Behavior
-> DATA.Session
-> DATA.TaskType
task_subtype                     : tinyint                    # task
---
-> DATA.TrainingType
%}


classdef Behavior < dj.Manual
end