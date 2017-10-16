%{
# 
-> DATA.Trial
-> DATA.UnitExtracel
---
spike_times                 : longblob                      # spike times aligned to trial
%}


classdef TrialSpikes < dj.Imported
    
	methods(Access=protected)

		function makeTuples(self, key)
            global obj
            
            % Extracting spikes corresponding to this trial only
            
            unit_num = fetch1(DATA.UnitExtracel & key,'unit_num');
            trial_num = fetch1(DATA.Trial & key,'trial_num');
            spikes = obj.eventSeriesHash.value{unit_num}.eventTimes; %all spikes for this unit
            spikeTrials = obj.eventSeriesHash.value{unit_num}.eventTrials; % trial number during which each spike was recorded
            
            % take only spikes corresponding to this trial
            key.spike_times = spikes ( spikeTrials == trial_num); 
            
            % insert the key into self
            self.insert(key);
		end
	end

end