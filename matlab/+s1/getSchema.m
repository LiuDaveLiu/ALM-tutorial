function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 's1', 'arsenyf_s1alm');  % package database
end
obj = schemaObject;
end
