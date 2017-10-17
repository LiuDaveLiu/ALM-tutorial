%{
# A recording session
-> s1.Animal
session_id                     : tinyint                    # session id
---
session_date                : date                          # date on which the session was begun
session_suffix              : char(1)                       # suffix distinguishing sessions on the same date
session_file                : varchar(255)                  # the session data directory
%}


classdef Session < dj.Manual
    methods
        function fill(self)
            self.insert({
                353936 1 '2017-05-19'  ''  '/Users/dimitri/vathes/ALM-tutorial/arseny/data/data_structure_anm353936_2017-05-19.mat' 
                359856 1 '2017-02-19'  ''  '/Users/dimitri/vathes/ALM-tutorial/arseny/data/data_structure_anm359856_2017-02-19.mat' 
                })
        end
    end
end