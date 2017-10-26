%{
# TrialS1Photostim
-> s1.Trial
stim_onset : decimal(6,3)      # onset of the stimulation relative to the go-cue (s)
-----
-> s1.S1StimType
-> s1.S1StimPowerType
stim_power = null             : double      # laser power (mW)
stim_total_durat = null       : double      # total stimulation duration (s)
stim_pulse_num   = null       : tinyint     # number of pulses
stim_pulse_durat = null       : double      # pulse duration (s)

%}

classdef TrialS1Photostim < dj.Part
    
    properties(SetAccess=protected)
        master= s1.Trial
    end
    
    
    methods
        
        function makeTuples(self, key, obj, iTrials)
            offset = - 4.2;
            primary_key = key;
            
            trial_type_name = fetchn(s1.Trial,'trial_type_name');
            stim_onsets = cellfun(@str2num,regexp(trial_type_name{iTrials},'\d*','Match'));
            if ~isempty(stim_onsets) %if there is no stimulation (neither stim nor distractor)
                for iStim = 1:length(stim_onsets) % loop through the stimulation onsets
                    key = primary_key;
                    key.stim_onset = (stim_onsets(iStim))/1000 + offset;
                    if contains(trial_type_name{iTrials},'Stim1700') %if stimulus (i.e. full stimulus occurs during sample period)
                        key.stim_type = 'stim';
                        key.stim_power = obj.laser_power.stimulus.pow(iTrials);
                        key.stim_pulse_num = obj.laser_power.stimulus.num_pulses(iTrials);
                        key.stim_pulse_durat = obj.laser_power.stimulus.pulse_dur_in_ms(iTrials);
                        key.stim_total_durat = key.stim_pulse_num * key.stim_pulse_durat;
                        if contains(trial_type_name{iTrials},'Stim1700intermed') || contains(trial_type_name{iTrials},'Stim1700double')
                            key.stim_power_type = 'other';
                        else % if it's a regular stimulus
                            key.stim_power_type = 'full';
                        end
                    else % if it's a distractor
                        key.stim_type = 'distractor';
                        key.stim_power = obj.laser_power.distractor.pow(iTrials);
                        key.stim_pulse_num = obj.laser_power.distractor.num_pulses(iTrials);
                        key.stim_pulse_durat = obj.laser_power.distractor.pulse_dur_in_ms(iTrials);
                        key.stim_total_durat = key.stim_pulse_num * key.stim_pulse_durat;
                        if key.stim_power == mode(obj.laser_power.stimulus.pow) %if distractor power equals to the typical stimulus power
                            key.stim_power_type = 'full';
                        elseif  (contains(trial_type_name{iTrials},'Eps1700intermedL') || ...
                                contains(trial_type_name{iTrials},'Eps1700weak') || ...
                                contains(trial_type_name{iTrials},'Eps1700intermedR') || ...
                                contains(trial_type_name{iTrials},'Eps1700strong') || ...
                                contains(trial_type_name{iTrials},'Eps1700strongR') )
                                key.stim_power_type = 'other';
                        else
                            key.stim_power_type = 'mini';
                        end
                    end
                    tuples = [tuples; key]; %#ok<AGROW>
                end
                self.insert(tuples)                
            end
            
        end
        
    end
end
