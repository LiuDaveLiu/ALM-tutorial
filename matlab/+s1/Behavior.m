%{
# Behavior
-> s1.Session
---
-> s1.TaskType
task_subtype                     : tinyint                    # task
-> s1.TrainingType
%}


classdef Behavior < dj.Manual
end