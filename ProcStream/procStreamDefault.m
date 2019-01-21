function [func, param] = procStreamDefault(type)

param = struct([]);
func = repmat(InitProcFunc(),0,1);
switch(type)
    case 'group'
        [~, filecontents_str] = procStreamDefaultFileGroup();
    case 'subj'
        [~, filecontents_str] = procStreamDefaultFileSubj();        
    case 'run'
        [~, filecontents_str] = procStreamDefaultFileRun();        
end

S = textscan(filecontents_str,'%s');
[func, param] = parseSection(S{1});
func = procStreamSetHelp(func);

