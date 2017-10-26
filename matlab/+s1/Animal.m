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
end


