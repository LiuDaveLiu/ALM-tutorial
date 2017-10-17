%{
# Mouse strain
strain                      : varchar(30)                   # mouse strain
%}


classdef StrainType < dj.Lookup
    properties
        contents = {'?'
            'C57BL/6'}
    end
end