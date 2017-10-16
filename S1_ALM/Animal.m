%{
# Experiment subjects
animal_id                   : int                           # animal id
---
species                     : varchar(255)                  # 
date_of_birth               : date                          # 
-> DATA.StrainType
-> DATA.GeneModType

%}


classdef Animal < dj.Manual
end
