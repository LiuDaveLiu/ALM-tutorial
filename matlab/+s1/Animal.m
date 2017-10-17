%{
# Experiment subjects
animal_id                   : int                           # animal id
---
species                     : varchar(255)                  # 
date_of_birth               : date                          # 
-> s1.StrainType
-> s1.GeneModType

%}


classdef Animal < dj.Manual

methods
    function fill(self)
        self.insert({
            % !!! fake data
            353936  'mus musculus'  '2017-09-01'  'C57BL/6' 'Scnn1a X Ai93'
            359856  'mus musculus'  '2017-09-03'  'C57BL/6' 'Scnn1a X Ai93'
            })
    end
end

end


