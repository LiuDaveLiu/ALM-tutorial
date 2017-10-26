%{
# Instruction
instruction : varchar(12)   # instruction - where to lick (e.g. lick right) mutually exclusive
%}

classdef InstructionType < dj.Lookup
    properties
        contents = {
            'l'
            'r'
            }
    end
end