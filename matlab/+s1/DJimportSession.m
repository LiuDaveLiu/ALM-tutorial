function DJimportSession
close all; clear all;

dir_data = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\ProcessedData\';
global obj

DJconnect; %connect to the database using stored user credentials

%% Initialize lookup tables
s1.StrainType; 
s1.GeneModType; %initialize lookup table
s1.ExperimentType; %initialize lookup table
s1.TrainingType; %initialize lookup table
s1.TaskType; %initialize lookup table
s1.InstructionType; %initialize lookup table
s1.OutcomeType; %initialize lookup table
s1.S1StimType; %initialize lookup table

%% Insert/Populate tables
allFiles = dir(dir_data); %gets  the names of all files and nested directories in this folder
allFileNames = {allFiles(~[allFiles.isdir]).name}; %gets only the names of all files
for iFile = 1:1:numel (allFileNames)
    
    currentFileName = allFileNames{iFile};
    currentAnimal = str2num(currentFileName(19:24));
    currentSessionDate = currentFileName(26:35);
    currentSessionSuffix = currentFileName(36);
    if currentSessionSuffix == '.'
        currentSessionSuffix ='a';
    end
    
    
    % Insert Animal table
    exisitingAnimal = fetchn(s1.Animal,'animal_id');
    % inserts animal only if it was not inserted before
    if isempty(exisitingAnimal) ||  sum(currentAnimal == exisitingAnimal)<1
        insert(s1.Animal, {currentAnimal, 'mouse', '2000-01-01','C57BL/6','Scnn1a X Ai93'} );
    end
   %%  inserti - insertreplace
   
   
    %% Insert into Session table and into dependent tables
    exisitingSessionAnimal = fetchn(s1.Session,'animal_id');
    exisitingSession = fetchn(s1.Session,'session_id');
    exisitingSessionDate = fetchn(s1.Session,'session_date');
    
    flagInsertSession = 0; % by default don't insert a new session, unless the following conditions are met:
    % 1) if the session table is empty
    if isempty(exisitingSession)
        flagInsertSession = 1;
        % 2) if this animal/date combination *does not* exist
    elseif sum(exisitingSessionAnimal ~= currentAnimal)<1  || ~sum(contains(exisitingSessionDate,currentSessionDate))
        flagInsertSession = 1;
        % 3) if this animal/date combination *does* exist, but has a different suffix (i.e. if multiple sessions were recorded on this day for the same animal)
    elseif sum(exisitingSessionAnimal ~= currentAnimal)<1  && ~sum(contains(exisitingSessionDate,currentSessionDate))
        rel = s1.Session & sprintf('session_date = "%s"',currentSessionDate);
        exisitingSessionsuffix = rel.fetch1('session_suffix');
        if currentSessionSuffix ~= exisitingSessionsuffix
            flagInsertSession = 1;
        end
    end
    
    % Only if either of the 1-3 conditions above are met - insert a new session and populate the dependent tables
    if flagInsertSession == 1
        % load obj structure
        load([dir_data currentFileName])
        currentSessionNumber = size (exisitingSession,1) +1;
        
        % Insert Session
        insert(s1.Session, {currentAnimal, currentSessionNumber, currentSessionDate, currentSessionSuffix, dir_data, currentFileName});
        insert(s1.SessionType, {currentAnimal, currentSessionNumber, 'behavior'});
        insert(s1.SessionType, {currentAnimal, currentSessionNumber, 'ephys'});

        % Insert Behavior
        insert(s1.Behavior,{currentAnimal,currentSessionNumber,'S1_stim_task', obj.task, obj.training_type});
        
        % Insert Video
        insert(s1.Video,{currentAnimal,currentSessionNumber});
        
        % Insert ExtracelProbe
        insert(s1.ExtracelProbe,{currentAnimal,currentSessionNumber,...
            obj.location(1), obj.location(3:end), obj.position_ML, obj.position_AP, obj.depth, obj.probeType, obj.probeName, 'Yes', obj.neural_daq_freq});
        
        % Populate Trial and its part table TrialOutcome
        populate(s1.Trial);
                
        % Populate UnitExtracel
        populate(s1.UnitExtracel);
        
        % Populate TrialSpikes
        populate(s1.TrialSpikes);
        
        clear obj;
    end
    
end

%         fetch(s1.Session & sprintf('session_date = "%s"',currentSessionDate))

s1.Animal
s1.Session
s1.ExtracellularProbe