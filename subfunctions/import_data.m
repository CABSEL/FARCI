function x = import_data()
N = input('How many files would you like to upload? ');
disp('****Please upload calcium imaging data. Accepted file formats: .mat .csv .xlsx .txt **** ');

for i = 1:N
    [FileName,PathName] = uigetfile('*.*');
    filename = strcat(PathName, FileName);
    
    if N == 1
        x = importdata(filename);
    else

        x{1,i} = importdata(filename); 
    end
    
end
disp('Done');
disp('Processing...');