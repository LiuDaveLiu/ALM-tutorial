%{
# Mouse training
training_type                      : varchar(40)                   # mouse training
---
%}


classdef TrainingType < dj.Lookup
    properties
        contents = {'no_training'
            'basic_task'
            'full_distractor'}
    end
end