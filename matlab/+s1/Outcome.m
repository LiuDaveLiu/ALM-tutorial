%{
# Outcome
outcome : varchar(12)   # outcome code, non-mutually exclusive
%}

classdef Outcome < dj.Lookup
    properties
        contents = {
            'HitR'
            'HitL'
            'ErrR'
            'ErrL'
            'NoLickR'
            'NoLickL'
            'LickEarly'
            'StimTrials'
            }
    end
end