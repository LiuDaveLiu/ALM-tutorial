function [obj, hash] = getObj(key)
%  read object file with memoization
%  s1.getObj('clear')  -- clears the store
%  obj = s1.getObj(key)  -- returns the object for a given session key

persistent store session pkey
if isempty(store) || strcmp(key, 'clear')
    store = containers.Map;
    session = s1.Session;
    pkey = session.header.primaryKey;
end


if ~strcmp(key, 'clear')
    hash = strjoin(cellfun(@(k) sprintf('%g', key.(k)), pkey, 'uni', false), '-');
    if ~store.isKey(hash)
        s = load([fetch1(s1.Session & key, 'processed_dir') fetch1(s1.Session & key, 'session_file')]);
        store(hash) = s.obj;
    end
    obj = store(hash);
end
end