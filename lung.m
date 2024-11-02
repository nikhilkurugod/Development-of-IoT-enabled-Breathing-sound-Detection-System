% Read the recorded WAV file
filename = 'withpaper.wav';
[y, Fs] = audioread(filename);

% Define the bandpass filter parameters
f_low = 20;   % Lower cutoff frequency in Hz
f_high = 200;  % Upper cutoff frequency in Hz
order = 4;      % Filter order

% Design the bandpass filter
Wn = [f_low f_high] / (Fs/2);
[b, a] = butter(order, Wn, 'bandpass');

% Calculate the duration and number of frames in the WAV file
duration = size(y, 1) / Fs;
numFrames = ceil(duration / 0.5);

% Initialize arrays to store the frequency values and filtered audio
f_hz = cell(numFrames, 1);
filteredAudio = zeros(size(y));

% Process the audio in 0.5-second segments
for i = 1:numFrames
    % Calculate the start and end indices for the current segment
    startIdx = round((i-1) * 0.5 * Fs) + 1;
    endIdx = min(round(i * 0.5 * Fs), size(y, 1));
    
    % Extract the segment of audio
    y_segment = y(startIdx:endIdx, :);
    
    % Apply the bandpass filter to the segment
    y_filtered_segment = filtfilt(b, a, y_segment);
    
    % Store the filtered segment in the appropriate location in the output array
    filteredAudio(startIdx:endIdx, :) = y_filtered_segment;
    
    % Calculate the frequency spectrum of the segment
    N = size(y_filtered_segment, 1);
    Y = fft(y_filtered_segment);
    P2 = abs(Y/N);
    P1 = P2(1:N/2+1, :);
    P1(2:end-1, :) = 2*P1(2:end-1, :);
    f = Fs*(0:(N/2))/N;
    
    % Convert frequency values to Hertz
    f_hz{i} = f * Fs / N;
end

% Plot the frequency spectrum
figure;
plot(f, P1);
title('Frequency Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Combine frequency values from all frames
f_hz_all = vertcat(f_hz{:});

% Display frequency values in Hertz
disp('Frequency Values (Hz):');
disp(f_hz_all);

% Save the filtered audio as a new WAV file
outputFilename = 'lung3out.wav';
audiowrite(outputFilename, filteredAudio, Fs);
disp('Filtered audio saved as "lung3out.wav"');