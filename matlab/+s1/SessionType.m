%{
# SessionType
-> s1.Session
-> s1.ExperimentType
-----
%}

classdef SessionType < dj.Part
    properties(SetAccess=protected)
        master= s1.Session
    end
end