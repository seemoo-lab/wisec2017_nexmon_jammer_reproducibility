function [z,fs,fc,header] = iqtread(filename,first,last)
% function [z,fs,fc,header] = iqtread(filename,first,last)
% This function reads a binary .iqt file from the 
% Tektronix RSA3408A Real-Time Spectrum Analyzer and 
% performs amplitude and phase correction.
% If filename is not specified or is empty, 
% the user is prompted for the filename. 
% A subset of the recording can be returned by specifying the first and
% last element numbers indexed from 1.
% If first is not specified or is empty, it defaults to 1.
% If last is not specified or is empty, it defaults to the length of the
% recording.
%
% filename (string) name of .iqt file (optional)
% first (scalar) first element to return indexed from 1 (optional)
% last (scalar) last element to return indexed from 1 (optional)
% z (complex column vector) RF baseband signal
% fs (scalar) sampling frequency in Hz
% fc (scalar) center frequency in Hz
% header (string) ASCII header from .iqt file

% Written by Joseph Hoffbeck 8/7/06
% Version 1.5 (added first and last inputs)
% Version 1.6 (included subroutines in this file) 12/16/07

FrameHeaderLength = 12; % number of bytes in the frame header
FrameLength = 1024;     % number of samples in each frame

inputdir = [];

z=[];   % initialize outputs to avoid error if user cancels
fs=[];
fc=[];
header=[];

if nargin < 1,
    filename = [];
end
if nargin < 2,
    first = 1;
end
if nargin < 3,
    last = [];
end

if isempty(filename),
    % prompt for the filename
    [filename,inputdir] = uigetfile('*.iqt','Select Input .iqt file');
    if filename == 0,
        disp('iqtread.m: user canceled operation')
        return; % no error if user canceled, but bail out
    end
end

fid = fopen([inputdir, filename]);
if fid == -1,
    error('iqtread.m: Could not open %s for reading\n',[inputdir, filename]);
end

fprintf('iqtread.m: opening %s for reading\n',[inputdir, filename]);

% read ASCII header
% first character in header tells how many characters are in the header size
[ch, count] = fread(fid,1,'uchar');  
if count ~= 1,
    error('iqtread.m: Could not read first character in header');
end

% read in header size
num_char = str2num(char(ch));       % convert ASCII char to a number
[header_size_str, count] = fread(fid,num_char,'uchar');  
if count ~= num_char,
    error('iqtread.m: Could not read header size');
end

% convert header size to a number
[header_size,ok]=str2num(char(header_size_str)');
if ok == 0,
    error('iqtread.m: Could not convert header size to a numerical value');
end

% read in the rest of the ASCII header
[header_str, count] = fread(fid,header_size,'uchar');  
if count ~= header_size,
    error('iqtread.m: Could not read ASCII header');
end

header = char(header_str');

fc = getParameterValueFromStr('CenterFrequency',header);
span = getParameterValueFromStr('Span',header,1);
fs = sampling_frequency_lookup(span);
ValidFrames = getParameterValueFromStr('ValidFrames',header);
MaxInputLevel = getParameterValueFromStr('MaxInputLevel',header);
GainOffset = getParameterValueFromStr('GainOffset',header);
LevelOffset = getParameterValueFromStr('LevelOffset',header);
IOffset = getParameterValueFromStr('IOffset',header);
QOffset = getParameterValueFromStr('QOffset',header);

% Check bounds on first and last element.
if first < 1,
    error('iqtread: first must be >= 1')
end
if isempty(last),
    last = ValidFrames*FrameLength; % set to default (end of recording)
end
if last > ValidFrames*FrameLength,
    fprintf('iqtread: warning, specified value of last is too large.\n')
    fprintf('Replacing specified value of last with recording length.\n')
    last = ValidFrames*FrameLength;
end
if last < first,
    error('iqtread: value of last must be greater than or equal to first')
end

% calculate first frame
FirstFrame = ceil(first/FrameLength);
LastFrame = ceil(last/FrameLength); 

% read extra frame because of overlap in the correction process
LastFrame = min(LastFrame + 1,ValidFrames);

% skip to first frame
status = fseek(fid,2*(FirstFrame-1)*(2*FrameLength + FrameHeaderLength),'cof');
if status ~= 0,
    error('iqtread.m: Could not skip to first frame');
end

x = zeros((LastFrame-FirstFrame+1)*FrameLength,1);
y = zeros((LastFrame-FirstFrame+1)*FrameLength,1);
for i = 1:(LastFrame-FirstFrame+1), 
    [frame_header, count] = fread(fid,FrameHeaderLength,'short');    % read frame header
    if count ~= FrameHeaderLength,
        error('iqtread.m: error reading frame header');
    end

    [frame_data, count] = fread(fid,2*FrameLength,'short');         % read in iq data
    if count ~= 2*FrameLength,
        error('iqtread.m: error reading frame header');
    end
    
    % separate I and Q samples (the first sample of each pair is Q and second is I)
    in = (1:FrameLength) + FrameLength*(i-1);          % calculate index for next frame
    x(in) = frame_data(2:2:end);     % In-phase sample (often called I)
    y(in) = frame_data(1:2:end);     % Quadrature sample (often called Q)
end

% skip to end of last frame
status = fseek(fid,2*(ValidFrames-LastFrame)*(2*FrameLength + FrameHeaderLength),'cof');
if status ~= 0,
    error('iqtread.m: Could not skip to end of last frame');
end

% apply offsets to I and Q samples (see RSA3408A User's Manual p. 3-205)
x = x - IOffset;  
y = y - QOffset;

% calculate power (see RSA3408A User's Manual p. 3-205)
% Amplitude = 10*log(x.^2 + y.^2)/log(10) + GainOffset + MaxInputLevel + LevelOffset;

% calculate I and Q signals (see RSA3408A User's Manual p. 3-205)
IQScale = sqrt(10^((GainOffset + MaxInputLevel + LevelOffset)/10)/20*2);
x = x * IQScale;  
y = y * IQScale;

% calculate complex baseband signal (raw signal, before correction)
z = x + j*y;

% read correction data block
% read Correction Data Block header
[frame_header, count] = fread(fid,FrameHeaderLength,'short');    % read frame header
if count ~= FrameHeaderLength,
    error('iqtread.m: error reading frame header in Correction Data Block');
end

% read Correction Data Block
[correction_data, count] = fread(fid,2*FrameLength,'short');         % read in iq data
if count ~= 2*FrameLength,
    error('iqtread.m: error reading Correction Data Block');
end

a = correction_data(1:2:end);   % first value is amplitude correction (see RSA3408A User's Manual p. 3-206)
p = correction_data(2:2:end);   % second value is phase correction

% read dummy header (should be ASCII characters '40000')
[dummy_header, count] = fread(fid,5,'uchar');         % read in iq data
if count ~= 5,
    error('iqtread.m: error reading dummy header');
end
if ~all(dummy_header' == '40000'),
    error('iqtread.m: value of dummy header is incorrect');
end

% read Extended Correction Data Block
[correction_data, count] = fread(fid,2*FrameLength,'uchar');         % read in iq data
if count ~= 2*FrameLength,
    error('iqtread.m: error reading Extended Correction Data Block');
end

ae = correction_data(1:1024);       % first 1024 samples are amplitude correction
pe = correction_data(1025:2048);    % second 1024 samples are phase correction

% Calculate amplitude and phase corrections (see RSA3408A User's Manual p. 3-206)
Amplitude_Correction_dB = (a*2^8 + ae)/(128*256);
Phase_Correction_Degrees = (p*2^8 + pe)/(128*256);

% Convert amplitude correction to a voltage gain
Amplitude_Correction = 10.^(-1*Amplitude_Correction_dB/20);
Correction_Factor = Amplitude_Correction .* exp(j*Phase_Correction_Degrees*pi/180);

% Apply corrections to the data (see IQTRead.doc from Tektronix)
i = 1;
in = 256:767;         % we will drop first 256 samples and last 256 samples of each frame
for k = 1:2*(LastFrame-FirstFrame+1)-1,
    z_tmp = z(i:i+FrameLength-1);    % Get 1024 samples of IQ data
    Z_tmp = fft(z_tmp);                 % take FFT
    Z_tmp = Z_tmp .* Correction_Factor; % apply correction factor
    z_tmp = ifft(Z_tmp);
    
    z(i+in-256) = z_tmp(in);    % Write back into SAME vector to save memory, 
                                % but shift left by 256 samples so we don't 
                                % overwrite samples that we need in the
                                % next iteration. This is equivalent to 
                                % dropping the first 256 samples
                                
    i = i + 512;            % shift by 512 samples
end

z(end-512+1:end) = [];  % drop last 512 samples

fclose(fid);    % close file

%  Drop unwanted samples
z(1:first-(1024*(FirstFrame-1)+1)) = [];
z(last-first+2:end) = []; 



% -----------------------------------------------------------------

function y = getParameterValueFromStr(parameter_name,input_string,leave_as_string)
% function y = getParameterValueFromStr(parameter_name,string,leave_as_string)
% This function searches for a parameter in a string that contains the
% ASCII header from an .iqt file and returns the value of the parameter.
% parameter_name (string) the name of the parameter
% input_string (string) the input string
% leave_as_string (scalar) if this flag is zero, empty, or missing, the number is 
%           converted to a numerical value.  If this flag is 1, the output
%           is left as an ASCII string. (default = [])

% written by Joseph Hoffbeck 5/23/06

if nargin < 3,
    leave_as_string = 0;
end
if isempty(leave_as_string),
    leave_as_string = 0;
end

value_str = 'CenterFrequency';
k = findstr(parameter_name,input_string);
[str, count] = sscanf(input_string(k:end),[parameter_name,'=%s\n'],1);
if count ~= 1,
    error(['getParameterValueFromStr.m: Could not find %s in the input string'],parameter_name);
end

if leave_as_string,
    y = str;
else
    y = convertIQTReadValues(str);
end


% -----------------------------------------------------------------

function fs = sampling_frequency_lookup(span)
% function fs = sampling_frequency_lookup(span)
% Look up the sampling frequency based on the span for 
% the Tektronix RSA3408A Real-Time Spectrum Analyzer
% span (string) span from the .iqt header file
% fs (scalar) sampling rate in Hz

% written by Joseph Hoffbeck 5/23/06

% Calculate the sampling frequency. The value of span is looked
% up in a table to determine the sampling frequency.
% SpanList is list of possible values of the variable span from .iqt file
SpanList = cellstr(char('40M','36M','20M','10M','5M','2M','1M',  ...
    '500k','200k','100k','50k','20k','10k','5k','2k','1k', ...
    '500','200','100'));
% FsList is list of corresponding Sample Rates (in Hz) which was taken
% from the RSA3408A Spec Sheet
FsList = [51.2e6; 51.2e6; 25.6e6; 12.8e6; 6.4e6; 2.56e6; 1.28e6; ...
        640e3; 256e3; 128e3; 64e3; 25.6e3; 12.8e3; 6.4e3; 2.56e3; 1.28e3; ...
        640; 256; 128 ];
in = strcmp(span,SpanList);    % find value of span in SpanList
if any(in),
    fs = FsList(in);                % lookup corresponding value of sample frequency (in Hz)
else
    error('sampling_frequency_lookup.m: unknown value of span, cannot determine sampling rate fs')
end



% ---------------------------------------------------------------

function y = convertIQTReadValues(s)
% function y = convertIQTReadValues(s)
% This function converts the values from the IQTRead program
% into numbers.  The IQTRead program outputs values 
% such as 1.19M, 50k, and 16m.  This program converts these strings
% to numbers such as 1.19e6, 50e3, and 16e-3 respectively.

% written by Joe Hoffbeck, 12/26/05

in = find(isletter(s));
if length(in) > 1,
    error('convertIQTReadValues: more than one letter in this string %s\n',s)
end

if length(in) == 1,
    switch s(in),
        case 'G',
            s = strrep(s,'G','e9'); 
        case 'M',
            s = strrep(s,'M','e6');
        case 'k',
            s = strrep(s,'k','e3');
        case 'm',
            s = strrep(s,'m','e-3');
        case 'u',
            s = strrep(s,'u','e-6');
        case 'n',
            s = strrep(s,'n','e-9');
        case 'E',
            % don't change exponent character
        case 'e',
            % don't change exponent character
        otherwise
            error('convertIQTReadValues: Unknown character %s\n',s)
    end
end

y = str2num(s);
