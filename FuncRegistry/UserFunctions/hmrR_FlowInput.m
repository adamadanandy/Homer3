% SYNTAX:
% dod = hmrR_FlowInput( intensity )
%
% UI NAME
% Relative Flow Change
%
% DESCRIPTION:
%
% INPUTS:
% intensity - SNIRF data structure with intensity data 
%             (#time points x #data channels)
%
% OUTPUTS:
% dod - SNIRF data structure with delta OD data (intensity divided by the mean)
%
% USAGE OPTIONS:
% Intensity_to_Delta_OD: dod = hmrR_Intensity2OD(data)
%
function dod = hmrR_FlowInput(intensity)

% intensity is a handle object, make sure we don't change 
% it - we work only with a copy. 
dod = DataClass(intensity);

for ii=1:length(intensity)
    d = intensity(ii).GetD();
    for i = 1:size(d,2);
        lst = find(isnan(d(:,i)));
        d(lst,i) = nanmean(d(:,i));
        clear lst
    end
    
    % percent change
    dm = mean(abs(d),1);
    nTpts = size(d,1);
    
    if ~isempty(find(d(:)<=0))
        warning( 'WARNING: Some data points in d are zero or negative.' );
    end
    dod(ii).SetD((abs(d)./(ones(nTpts,1)*dm)));
    dod(ii).SetDataType(1000, 1);
end

