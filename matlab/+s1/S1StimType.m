%{
# S1StimType - i.e full stim or ministim
stim_type : varchar(12)   # outcome code, non-mutually exclusive
%}

classdef S1StimType < dj.Lookup
    properties
        contents = {
            'full'
            'mini'
            'other'
            }
    end
end