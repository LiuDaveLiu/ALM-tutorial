%{
#
-> DATA.Behavior
trial_id                    : int              # trial_id unique across sessions
---
trial_num                   : smallint         # trial number within a session (not unique across sessions). If behavior is aquired together with ephys recording, only trials with ephys recording would be saved (to think if we want to change it and get all trials, even those for each the ephys is missing)
trial_type_name             : varchar(64)      # trial type name  (e.g. r_s_Stim1700Eps2600)
start_time                  : double           # relative to beginning of the data aquisition for the entire session
cue_time = null             : double           # relative to the beginning of each trial
%}


classdef Trial < dj.Imported
    
    methods(Access=protected)
        
        function makeTuples(self, key)
            global obj
            
            for iTrials = 1:1:numel(obj.trialIDs)
                key.trial_id = size(fetch(DATA.Trial),1) + 1;
                key.trial_num = obj.trialIDs(iTrials);
                
                %extracting trial_type_name
                stimEpochFlags = cell2mat(obj.trialPropertiesHash.stimEpochFlags);
                key.trial_type_name = obj.trialPropertiesHash.stimEpochNames {stimEpochFlags (iTrials,:)};
                
                key.start_time = obj.trialStartTimes(iTrials);
                key.cue_time = obj.trialPropertiesHash.value{3}(iTrials);   
                
                % insert the key into self
                self.insert(key);
            end
            sprintf('Populated %d trials recorded from animal %d  on %s', iTrials, key.animal_id, fetch1(DATA.Session & key,'session_date'));
            
        end
    end
    
end