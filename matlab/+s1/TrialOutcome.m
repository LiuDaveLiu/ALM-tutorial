%{
# TrialOutcome
-> s1.Trial
-> s1.OutcomeType  # we have it as a primary key because the same Trial might have more than one outcome (i.e. LickEarly & Hit)
-----
%}

classdef TrialOutcome < dj.Part
    
    properties(SetAccess=protected)
        master= s1.Trial
    end
    
    
    methods
        function makeTuples(self, key, obj, iTrials)
            persistent outcome_types
            if isempty(outcome_types)
                outcome_types = fetchn(s1.OutcomeType,'outcome');
            end
            tuples = [];
            for iOutcome = 1:length(outcome_types) % loop through outcomes (e.g. Hit, Err, LickEarly, NoLick)
                % the original data contains instruction and outcomes mixed (i.e. HitR) but we want outcomes only, regardless of the instruction
                % (e.g. if we look for a Hit - the relevant_outcomes would be ei HitR and HitL would be )
                relevant_outcomes_names = (strfind(obj.trialTypeStr,outcome_types{iOutcome}));
                outcomes_vec = obj.trialTypeMat(:,iTrials); % a boolean vector with instruction-outcomes for this trial                
                if sum(outcomes_vec(~cellfun(@isempty,relevant_outcomes_names))) >0 % if this particular outcome occured - insert it into the table
                    key.outcome = outcome_types{iOutcome};
                    tuples = [tuples; key]; %#ok<AGROW>
                end
            end
            self.insert(tuples)  % insert all at once
        end
    end
end

