%{
#
-> s1.ExtracelProbe
unit_id                     : smallint                   # unit_id unique across sessions
---
unit_num                    : smallint                   # unit_num within a session (not unique across sessions) - corresponds to the cluster number from the spikesorting
unit_hemisphere             : varchar(8)                 #
unit_brain_area             : varchar(32)                #
unit_x          = null      : float                      # unit coordinate Medio-Lateral
unit_y          = null      : float                      # unit coordinate Posterior-Anterior
unit_z          = null      : float                      # unit depth
unit_quality    = null      : float                      # unit quality; 2 - single unit; 1 - probably single unit; 0 - multiunit
unit_channel    = null      : float                      # channel on the probe for each the unit has the largest amplitude (verify that its based on amplitude or other feature)
avg_waveform    = null      : longblob                   # unit average waveform, each point corresponds to a sample. (what are the amplitude units?)  To convert into time use the sampling_frequency.

%}


classdef RecordedUnit < dj.Imported
    
    methods(Access=protected)
        
        function makeTuples(self, key)
            obj = s1.getObj(key);
            
            for iUnits = 1:size(obj.eventSeriesHash.value,2)
                
                key.unit_id = size(fetch(s1.RecordedUnit),1) + 1;
                key.unit_num = iUnits;
                key.unit_hemisphere =  fetch1(s1.ExtracelProbe & key, 'recording_hemisphere');
                key.unit_brain_area =  fetch1(s1.ExtracelProbe & key, 'recording_brain_area');
                key.unit_x = obj.eventSeriesHash.value{iUnits}.position_ML;
                key.unit_y = obj.eventSeriesHash.value{iUnits}.position_AP;
                key.unit_z = obj.eventSeriesHash.value{iUnits}.depth;
                key.unit_quality = obj.eventSeriesHash.value{iUnits}.quality;
                key.unit_channel = obj.eventSeriesHash.value{iUnits}.channel;
                key.avg_waveform = obj.eventSeriesHash.value{iUnits}.waveforms;
             
                self.insert(key)
            end
            fprintf('Populated %d units recorded from animal %d  on %s', iUnits, key.animal_id, fetch1(s1.Session & key,'session_date'))
        end
    end
    
end