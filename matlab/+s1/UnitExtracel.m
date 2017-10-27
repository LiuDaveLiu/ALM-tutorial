%{
#
-> s1.ExtracelProbe
unit_id                     : smallint                   # unit_id unique across sessions
---
unit_num                    : smallint                   # unit_num within a session (not unique across sessions) - corresponds to the cluster number from the spikesorting
unit_x          = null      : float                      # unit coordinate Medio-Lateral
unit_y          = null      : float                      # unit coordinate Posterior-Anterior
unit_z          = null      : float                      # unit depth
unit_quality    = null      : float                      # unit quality; 2 - single unit; 1 - probably single unit; 0 - multiunit
unit_channel    = null      : float                      # channel on the probe for each the unit has the largest amplitude (verify that its based on amplitude or other feature)
avg_waveform    = null      : longblob                   # unit average waveform, each point corresponds to a sample. (what are the amplitude units?)  To convert into time use the sampling_frequency.
%}


classdef UnitExtracel < dj.Imported
    
    methods(Access=protected)
        
        function makeTuples(self, key)
            obj = s1.getObj(key);
            
            tuples = [];
            for iUnits = 1:size(obj.eventSeriesHash.value,2)
                key.unit_id = size(fetch(s1.UnitExtracel),1) + iUnits;
                key.unit_num = iUnits;
                key.unit_x = obj.eventSeriesHash.value{iUnits}.position_ML;
                key.unit_y = obj.eventSeriesHash.value{iUnits}.position_AP;
                key.unit_z = obj.eventSeriesHash.value{iUnits}.depth;
                key.unit_quality = obj.eventSeriesHash.value{iUnits}.quality;
                key.unit_channel = mode(obj.eventSeriesHash.value{iUnits}.channel);
                key.avg_waveform = obj.eventSeriesHash.value{iUnits}.waveforms;
                tuples = [tuples; key]; %#ok<AGROW>
            end
            self.insert(tuples)
            fprintf('Populated %d units recorded from animal %d  on %s', ...
                iUnits, key.animal_id, fetch1(s1.Session & key,'session_date'));
            
        end
    end
    
end