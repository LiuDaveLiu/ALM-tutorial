%{
# TrialLicks
-> s1.Trial
lick_side   : enum('left', 'right')
---
lick_times : longblob
%}

classdef TrialLicks < dj.Part
    
    properties(SetAccess=protected)
        master= s1.Trial
    end
    
    methods
        
        function makeTuples(self, key, obj, trial_idx)
            
            key.lick_side = 'left';
            key.lick_times = obj.trialPropertiesHash.value{6}{trial_idx};
            self.insert(key)
            
            key.lick_side = 'right';
            key.lick_times = obj.trialPropertiesHash.value{7}{trial_idx};
            self.insert(key)
            
        end
    end
    
end