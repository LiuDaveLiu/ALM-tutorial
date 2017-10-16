%{
# A recording session
-> DATA.Animal
session_id                     : tinyint                    # session id 
---
session_date                : date                          # date on which the session was begun
session_suffix              : char(1)                       # suffix distinguishing sessions on the same date
session_file                : varchar(255)                  # the session data directory
-> DATA.ExperimentType
%}


classdef Session < dj.Manual
end