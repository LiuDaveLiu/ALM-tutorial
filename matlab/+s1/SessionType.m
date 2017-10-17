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
    
    methods
        function fill(self)
            self.insert({
                353936  1 'ephys'
                353936  1 'behavior'
                359856  1 'ephys'
                359856  1 'behavior'
                })
        end
    end
    
end