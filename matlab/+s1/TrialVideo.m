%{
# TrialVideo  if there are more than one camera, each camera would have a separate entry
-> s1.Trial
video_id                  : int                 # video_id unique across sessions
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
            if ~isempty(obj.ephysVideoTrials)
                tuples = [];
                video_id = fetch1(s1.TrialVideo, 'max(video_id) -> mx');
                if isnan(video_id)
                    video_id = 0;
                end
                for iCam = 1:size(obj.ephysVideoTrials.Cam,2) %insert this for every camera
                    video_id = video_id + 1;
                    key.video_id = video_id;
                    Cam = obj.ephysVideoTrials.Cam {iCam};
                    key.camera_id = iCam-1;
                    key.video_flag = Cam.flags(iTrials);
                    key.video_file_name = Cam.fileName{iTrials};
                    tuples = [tuples; key]; %#ok<AGROW>
                end
                self.insert(tuples)
            end
        end
        
    end
    
end

