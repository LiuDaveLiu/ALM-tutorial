%{
# TrialS1Stim
-> s1.Trial
-----
-> s1.S1StimType
stim_onset         : double      # onset of the stimulation relative to the go-cue
stim_pulse_number  : tinyint     # number of pulses
stim_duration      : double      # stimulation duration

%}

classdef TrialS1Stim < dj.Part
    
    properties(SetAccess=protected)
        master= s1.Trial
    end
    
    
    methods
        
        function makeTuples(self, key, obj, trial_idx)
            trial_type_name = fetchn(s1.Trial,'trial_type_name');
            stim_onsets = cellfun(@str2num,regexp(trial_type_name{trial_idx},'\d*','Match'));

            for iStim = 1:length(stim_onset) % loop through the stimulation onsets
                key.stim_type = 'full';
                key.stim_onset = stim_onsets(iStim);
                key.stim_pulse_number = 4;
                key.stim_duration = 0.1;
            end
            
        end
        
    end
    
end

