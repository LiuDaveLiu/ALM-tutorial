%{
# TrialOutcome
-> s1.Trial
-> s1.Outcome
-----
%}

classdef TrialOutcome < dj.Part

	properties(SetAccess=protected)
		master= s1.Trial
    end
    
    
    methods
        function makeTuples(self, key, obj, trial_idx)
            
            for trialTypeNum = 1:length(obj.trialTypeStr)
                if obj.trialTypeMat(trialTypeNum, trial_idx)
                    key.outcome = obj.trialTypeStr(trialTypeNum);
                    self.insert(key)
                end
            end
        end
    end

end