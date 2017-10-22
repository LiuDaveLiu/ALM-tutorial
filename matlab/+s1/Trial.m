%{
#
-> s1.Behavior
trial_id                    : int              # trial_id unique across sessions
---
trial_num                   : smallint         # trial number within a session (not unique across sessions). If behavior is aquired together with ephys recording, only trials with ephys recording would be saved (to think if we want to change it and get all trials, even those for each the ephys is missing)
-> s1.InstructionType
trial_type_name             : varchar(64)      # trial type name  (e.g. r_s_Stim1700Eps2600)
start_time                  : double           # relative to beginning of the data aquisition for the entire session
cue_time = null             : double           # relative to the beginning of each trial
%}


classdef Trial < dj.Imported
    
    methods(Access=protected)
        
        function makeTuples(self, key)
            obj = s1.getObj(key);
            key_child = key;
            for iTrials = 1:1:numel(obj.trialIDs)
                
                key.trial_id = size(fetch(s1.Trial),1) + 1;
                trial_num = obj.trialIDs(iTrials);
                trial_idx = find(obj.trialIDs == trial_num);
                
                
                %extracting trial_type_name
                stimEpochFlags = cell2mat(obj.trialPropertiesHash.stimEpochFlags);
                key.trial_type_name = obj.trialPropertiesHash.stimEpochNames {stimEpochFlags (iTrials,:)};
                key.instruction = key.trial_type_name(1);
                key.start_time = obj.trialStartTimes(iTrials);
                key.cue_time = obj.trialPropertiesHash.value{3}(iTrials);
                
                key.trial_num = trial_num;
                
                % insert the key into self
                self.insert(key)
                
                key_child.trial_id = key.trial_id;
                makeTuples(s1.TrialOutcome, key_child, obj, trial_idx)
                makeTuples(s1.TrialLicks, key_child, obj, trial_idx)
                makeTuples(s1.TrialS1Stim, key_child, obj, trial_idx)

            end
            sprintf('Populated %d trials recorded from animal %d  on %s', iTrials, key.animal_id, fetch1(s1.Session & key,'session_date'));
            
        end
    end
    
end