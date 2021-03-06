% Output:
% SMF spatial matched filter
%
% Input:
% x_coord = x coordinate for line to generate 
% useCaseParams
% transducerType
% crop threshold in dB, default = -20dB

function SMF = Generate_SMF_line(x_coord,resolution,useCaseParams,transducerType,cropdB)
if nargin < 5, cropdB = -20; end

y_tismin = useCaseParams.scanparams(1).windowtissueq.y_tismin;
if y_tismin<1/1000; y_tismin = 1/1000; end % Scatter cannot be at depth less than 1mm
z = linspace(y_tismin,...
             useCaseParams.scanparams(1).windowtissueq.y_tismax,...
             resolution)';
% Generate cellarray with positions for point scatteres
position = num2cell([x_coord*ones(size(z)) zeros(size(z)) z],2);
[filter,index] = cellfun( @(X) ...
    Generate_SMF_point(X,useCaseParams,transducerType,cropdB),...
    position,...
    'UniformOutput',false);
SMF = struct('filter',filter,'index',index);

% SMF = cell(resolution(1),1);
% parfor i = 1:resolution(1)
%    SMF(i) = { Generate_SMF_point(pos{i},useCaseParams,transducerType) };
% end

end

function [SMF,index] = Generate_SMF_point(position,useCaseParams,transducerType,cropdB)
% Creates filter for scatter located at position
media.phantom_positions = position;
media.phantom_amplitudes = 1;

f0 = useCaseParams.bfxmitparams(1).xmitfreq;
fs = 120e6;
xmt_impulse_response = sin(2*pi*f0*(0:1/fs:2/f0))';
xmt_impulse_response = xmt_impulse_response.*hanning(max(size(xmt_impulse_response)));
rcv_impulse_response = xmt_impulse_response;

excitation = (sin(2*pi*f0*(0:1/fs:2/f0)))';
excitation = excitation.*hanning(max(size(excitation)));

SMF = Data_Acquisition('usecaseparams',useCaseParams, ...
                      'transducertype',transducerType, ...
                      'xmt_impulse_response', xmt_impulse_response, ...
                      'xmt_impulse_response_fs',fs, ...
                      'rcv_impulse_response', rcv_impulse_response, ...
                      'rcv_impulse_response_fs',fs, ...
                      'excitation_waveform', excitation, ... 
                      'excitation_fs',fs, ...
                      'symmetric','symmetric',...
                      'media',media);

SMF = cropfilter(SMF,cropdB);
[SMF,index] = removezeros(SMF);

end
