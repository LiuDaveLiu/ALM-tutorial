%{
# TrialS1Stim
-> s1.Trial
-> s1.S1StimType
stim_time
stim_durat
-----
%}

classdef TrialS1Stim < dj.Part
    
    properties(SetAccess=protected)
        master= s1.Trial
    end
    
    
    methods
        function makeTuples(self, key, obj, trial_idx)
            outcome_types = fetchn(s1.OutcomeType,'outcome');
            for iOutcome = 1:length(outcome_types) % loop through outcomes (e.g. Hit, Err, LickEarly, NoLick)
                % the original data contains instruction and outcomes mixed (i.e. HitR) but we want outcomes only, regardless of the instruction
                % (e.g. if we look for a Hit - the relevant_outcomes would be ei HitR and HitL would be )
                relevant_outcomes_names = (strfind(obj.trialTypeStr,outcome_types{iOutcome}));
                outcomes_vec = obj.trialTypeMat(:,trial_idx); % a boolean vector with instruction-outcomes for this trial
                
                if sum(outcomes_vec(~cellfun(@isempty,relevant_outcomes_names))) >0 % if this particular outcome occured - insert it into the table
                    key.outcome = outcome_types{iOutcome};
                    self.insert(key)
                end
            end
            
        end
        %             key.err_r = outcomes_vec (strcmp(obj.trialTypeStr,'ErrR'));
        %             key.no_lick_r = outcomes_vec (strcmp(obj.trialTypeStr,'NoLickR'));
        %             key.lick_early = outcomes_vec (strcmp(obj.trialTypeStr,'LickEarly'));
        %
        %             for trialTypeNum = 1:length(obj.trialTypeStr)-1 % I am leaving the last row, because all the trial are marked as StimTrials for historic reasons, and we are not inerested in it
        %                 if obj.trialTypeMat(trialTypeNum, trial_idx) %if it has 1 in this field (i.e HitL == 1)
        %                     key.outcome = obj.trialTypeStr{trialTypeNum};
        %                     self.inserti(key)
        %                 end
        %             end
    end
end

