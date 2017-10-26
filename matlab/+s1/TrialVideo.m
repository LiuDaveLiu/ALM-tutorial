%{
# TrialVideo  if there are more than one camera, each camera would have a separate entry
-> s1.Trial
video_id                  : double              # video_id unique across sessions
-----
video_flag = 0            : tinyint             # flag indicating if there is a video or not
camera_id = null          : tinyint             # camera id
video_file_name = null    : varchar(255)        # video file

%}

classdef TrialVideo < dj.Part
    
    properties(SetAccess=protected)
        master= s1.Trial
    end
    
    
    methods
        
        function makeTuples(self, key, obj, iTrials)
            if isempty(obj.ephysVideoTrials)
                key.video_id = size(fetch(s1.TrialVideo),1) + 1;
%               key.video_flag = 0;
                self.insert(key)
            else
                for iCam = 1:1:size(obj.ephysVideoTrials.Cam,2) %insert this for every camera
                    key.video_id = size(fetch(s1.TrialVideo),1) + 1;
                    Cam = obj.ephysVideoTrials.Cam {iCam};
                    key.camera_id = iCam-1;
                    key.video_flag = Cam.flags(iTrials);
                    key.video_file_name = Cam.fileName{iTrials};
                    self.insert(key)
                end
            end
        end
        
    end
    
end

