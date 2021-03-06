%{
# S1StimType 
stim_type = 'nostim'              : varchar(12)   # sample or distractor or no-stim
%}

classdef S1StimType < dj.Lookup
    properties
        contents = {
            'nostim'
            'stim'
            'distractor'
            }
    end
end