%% Load audio
    [x, fs] = audioread('cv-valid-train/sample-000000.mp3');
    %x = mean(x,2);      % stereo -> mono
    x = resample(x,8000,fs);    % resample (44100 Hz -> 8000 Hz)
    fs = 8000;

%% Pre-processing_Low Pass Filter
    % Removing formant-2
    lpf = FIR_LPF_900Hz();
    x = filter(lpf,1,x);
    x = x/max(abs(x));      % normalize

%% Voice Segmentation
    w_size = 8000*0.03;   % 30ms Hann window
    w = hamming(w_size); 
    %step = 8000*0.02;     % 20ms step size
    step = 8000*0.01;     % 10ms step size
    numFrame = fix((length(x)-w_size)/step) + 1; % number of frames

    X = zeros(w_size,numFrame);

    for i = 1:numFrame
        X(:,i) = x((1:w_size)+(i-1)*step);
    end

%% Processing_Frames
    Pitch = zeros(1,numFrame);
    for i = 1:numFrame
        % 3-level center clipping function
        cL = 0.68*min([max(abs(X(1:w_size/3,i))) max(abs(X(w_size/3+1:w_size,i)))]);
        for j = 1:w_size    % clipping
           if X(j,i) > cL
               X(j,i) = 1;
           elseif X(j,i) < -cL
               X(j,i) = -1;
           else
               X(j,i) = 0;
           end
        end
        % Auto-correlation
        [R, R0] = ACF(X(:,i),31,100);
        [Rmax,k] = max(R);
        % Check pitch
        if Rmax >= 0.4*R0
            Pitch(i) = fs/(k + 30);
        else
            Pitch(i) = 0;
        end 
    end

%% Gender Detection
    % Male: 85 - 180 Hz
    % Female: 165 - 255 Hz
    malePitch = 0;
    femalePitch = 0;

    for i = 1: length(Pitch)
        if (Pitch(i) >= 80) && (Pitch(i) <= 146) % Male
            malePitch = malePitch + 1;
        end
        if (Pitch(i) >= 188) && (Pitch(i) <= 255) % Female
            femalePitch = femalePitch + 1;
        end
    end
    
    % Display result
    disp(['malePitch: ' num2str(malePitch)]);
    disp(['femalePitch ' num2str(femalePitch)]);
    
    if (malePitch > femalePitch)
        disp('Gender: Male!');
    end
    if (femalePitch > femalePitch)
        disp('Gender: Female');
    end

        
        
        
        
