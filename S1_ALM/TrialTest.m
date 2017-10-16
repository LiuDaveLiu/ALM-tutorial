%{
#
-> Trial
---
hit_r                       : tinyint                      #
hit_l                       : tinyint                      #
err_r                       : tinyint                      #
err_l                       : tinyint                      #
no_lick_r                   : tinyint                      #
no_lick_l                   : tinyint                      #
lick_early                  : tinyint                      #
left_licks_times = null     : longblob                     # Time stamps for all left licks, relative to the beginning of each trial
right_licks_times = null    : longblob                     # Time stamps for all right licks, relative to the beginning of each trial
%}

classdef TrialTest < dj.Part
    properties
        master = DATA.Trial
    end
    
    methods
        
        function makeTuples(self, key)
            
            global obj
            
            trial_num = fetch1(DATA.Trial & key,'trial_num');
            trial_idx = find(obj.trialIDs == trial_num);
            
            %extracting trial outcomes
            outcomes_vec = double(obj.trialTypeMat(:,trial_idx));
            key.hit_r = outcomes_vec (strcmp(obj.trialTypeStr,'HitR'));
            key.hit_l = outcomes_vec (strcmp(obj.trialTypeStr,'HitL'));
            key.err_r = outcomes_vec (strcmp(obj.trialTypeStr,'ErrR'));
            key.err_l = outcomes_vec (strcmp(obj.trialTypeStr,'ErrL'));
            key.no_lick_r = outcomes_vec (strcmp(obj.trialTypeStr,'NoLickR'));
            key.no_lick_l = outcomes_vec (strcmp(obj.trialTypeStr,'NoLickL'));
            key.lick_early = outcomes_vec (strcmp(obj.trialTypeStr,'LickEarly'));
            key.left_licks_times = obj.trialPropertiesHash.value{6}{trial_idx};
            key.right_licks_times = obj.trialPropertiesHash.value{7}{trial_idx};
            
            % insert the key into self
            self.insert(key);
        end
    end
    
end