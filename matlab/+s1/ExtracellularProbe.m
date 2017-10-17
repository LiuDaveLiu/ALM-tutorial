%{
# ExtracellularProbe recording info
-> s1.Session
---
recording_hemisphere        : varchar(8)                    #
recording_brain_area        : varchar(32)                   #
recording_coords_x = null   : float                         # Medio-Lateral
recording_coords_y = null   : float                         # Posterior-Anterior
recording_coords_z = null   : float                         # depth (Dorsal-Ventral)
probe_type                  : varchar(60)                   #
probe_id                    : varchar(60)                   #
spike_sorting               : varchar(16)                   #
sampling_fq                 : float                    # DAQ sampling frequeny 

%}


classdef ExtracellularProbe < dj.Manual
end