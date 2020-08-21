function ops = sp_deconv_inputs()
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
ops.imageRate = input('Please enter the imaging rate (frame/sec): '); % Imaging rate 
ops.sensorTau = input(['Please enter the decay rate of the fluorescence sensor ('  (char(964)) '): ']); % Fluorescence decay ratre
