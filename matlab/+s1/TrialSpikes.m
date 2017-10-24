%{
#
-> s1.Trial
-> s1.UnitExtracel
---
spike_times                 : longblob                      # spike times for each trial (relative to the beginning of the trial)
%}


classdef TrialSpikes < dj.Imported
    
    methods(Access=protected)
        
        function makeTuples(self, key)
            obj = s1.getObj(key);
            
            % Extracting spikes corresponding to this trial only
            unit_num = fetch1(s1.UnitExtracel & key,'unit_num');
            trial_num = fetch1(s1.Trial & key,'trial_num');
            spikes = obj.eventSeriesHash.value{unit_num}.eventTimes; %all spikes for this unit
            spikeTrials = obj.eventSeriesHash.value{unit_num}.eventTrials; % trial number during which each spike was recorded
            
            % take only spikes corresponding to this trial
            key.spike_times = spikes(spikeTrials == trial_num);
            
            % insert the key into self
            self.insert(key)
        end
    end
    
end