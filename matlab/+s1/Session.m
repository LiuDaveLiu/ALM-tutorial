%{
# A recording session
-> s1.Animal
session_id                     : tinyint                   # session id
---
session_date                : date                         # date on which the session was begun
session_suffix              : char(1)                      # suffix distinguishing sessions on the same date
processed_dir               : varchar(255)                 # processed session data directory
session_file                : varchar(255)                 # the session file name
video_dir                   : varchar(255)                 # video file
%}


classdef Session < dj.Manual
end