function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'DATA', 'arseny_s1alm'); %package database
end
obj = schemaObject;
end
