function varargout = Input_trial(varargin)
% INPUT_TRIAL MATLAB code for Input_trial.fig
%      INPUT_TRIAL, by itself, creates a new INPUT_TRIAL or raises the existing
%      singleton*.
%
%      H = INPUT_TRIAL returns the handle to a new INPUT_TRIAL or the handle to
%      the existing singleton*.
%
%      INPUT_TRIAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INPUT_TRIAL.M with the given input arguments.
%
%      INPUT_TRIAL('Property','Value',...) creates a new INPUT_TRIAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Input_trial_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      reset.  All inputs are passed to Input_trial_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Input_trial

% Last Modified by GUIDE v2.5 30-Nov-2016 17:31:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Input_trial_OpeningFcn, ...
                   'gui_OutputFcn',  @Input_trial_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% dname = uigetdir('C:\');


% % create an axes that spans the whole gui
 ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
% % import the background image and show it on the axes
bg = imread('M.jpg');imagesc(bg);
% % prevent plotting over the background and turn the axis off
 set(ah,'handlevisibility','off','visible','off')
% % making sure the background is behind all the other uicontrols
uistack(ah, 'bottom');


% --- Executes just before Input_trial is made visible.
function Input_trial_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Input_trial (see VARARGIN)

% Choose default command line output for Input_trial
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Input_trial wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Input_trial_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
handles.fs=44100;
set(handles.edit1,'String',handles.fs);

handles.BPM=240;
 set(handles.edit2,'String',handles.BPM);
 handles.PPQ=4;
 set(handles.edit3,'String',handles.PPQ);
  
guidata(hObject,handles);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
X=handles.X;
fs=handles.fs;
X = X(find(X,1,'first'):find(X,1,'last'));
soundsc(X,fs)
guidata(hObject,handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
startingFolder = 'G:\Digital_Audio_forensics';
if ~exist(startingFolder, 'dir')
	% If that folder doesn't exist, just start in the current folder.
	startingFolder = pwd;
end
% Get the name of the mat file that the user wants to use.
defaultFileName = fullfile(startingFolder, '*.mat');
[baseFileName, folder] = uigetfile(defaultFileName, 'Select a mat file');
if baseFileName == 0
	% User clicked the Cancel button.
	return;
end
fullFileName = fullfile(folder, baseFileName)
storedStructure = load(fullFileName);
%fs = 44100; %-- or 8000 Hz
fs=handles.fs;
BPM=handles.BPM; %BPM from user
PPQ=handles.PPQ; %PPQ from user
X=zeros(1,10*fs);
X2=zeros(1,10*fs);

%Loop to add notes sequentially according to .mat file
for kk1 = 1:length(storedStructure.input1(:,1))
keynum = storedStructure.input1(kk1,1);
X= key2note1(X, keynum, storedStructure.input1(kk1,2), storedStructure.input1(kk1,3), fs, BPM, PPQ); 
end

for kk2 = 1:length(storedStructure.input2(:,1))
keynum = storedStructure.input2(kk1,1);
X2= key2note1(X2, keynum, storedStructure.input2(kk1,2), storedStructure.input2(kk1,3), fs, BPM, PPQ);
end
handles.X=X;
handles.X2=X2;
guidata(hObject,handles);





function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fs=handles.fs;
X2=handles.X2;
X2 = X2(find(X2,1,'first'):find(X2,1,'last'));
soundsc(X2,fs)

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fs=get(handles.edit1,'String');  %fs from user input
handles.fs=str2num(fs);
BPM=get(handles.edit2,'String');
handles.BPM=str2num(BPM);
PPQ=get(handles.edit3,'String');
handles.PPQ=str2num(PPQ);
guidata(hObject,handles);




% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end







% --- Executes during object creation, after setting all properties.
function Filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Title=get(handles.edit8,'String'); %title of the wave file in which the given son is to be saved
handles.title=Title;
guidata(hObject,handles);


% --- Executes on button press in wave.
function wave_Callback(hObject, eventdata, handles)
% hObject    handle to wave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uiputfile('.txt','Specify Folder Path');  %for taking path from a user to save the wave file
handles.path=path;
guidata(hObject,handles);

% --- Executes on button press in SaveWave.


function SaveWave_Callback(hObject, eventdata, handles)
% hObject    handle to SaveWave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path=handles.path;
Title=handles.title;
fs=handles.fs;

Song=get(handles.SongSelect,'SelectedObject');
Selection=get(Song,'String');
handles.s=Selection;
switch Selection
    case 'Song1'
        X=handles.X;
        path1=strcat(path,Title);
        audiowrite(strcat(path1,'.wav'),X,fs);
    case 'Song2'
        X2=handles.X2;
        path1=strcat(path,Title);
        audiowrite(strcat(path1,'.wav'),X2,fs);
    case 'Piano'
        Xi=handles.Xi;
        path1=strcat(path,Title);
        audiowrite(strcat(path1,'.wav'),Xi,fs);
end
guidata(hObject,handles);


% --- Executes on button press in C.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in D.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in E.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to E (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in F.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to F (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in G.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to G (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in A.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Ex    ecutes on button press in B.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Csharp.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to Csharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Dsharp.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to Dsharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Fsharp.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to Fsharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Gsharp.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to Gsharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Asharp.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to Asharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Playy.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to Playy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Reset.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in C.
function C_Callback(hObject, eventdata, handles)
% hObject    handle to C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = 523.251;  %freq of note C IN MIDDLE OCTAVE
n=handles.n; %Stores the time stamp
Xi=handles.Xi; %song to be saved in Xi matrix
fs = handles.fs;
note_select = get(handles.Note,'SelectedObject');

slct = get(note_select,'String');

%routine to select the duration of notes
switch (slct)
    case 'Whole'
        t=n:1/fs:n+1;
        n=n+1;
    case 'Half'
        t=n:1/fs:n+0.5;
        n=n+0.5;
    case 'Quarter'
        t=n:1/fs:n+0.25;
        n=n+0.25;
end
Xi = [Xi sin(2*pi*f*t)];
handles.n=n;
handles.Xi = Xi; %saved back to global structure handles
guidata(hObject, handles);


% --- Executes on button press in D.
function D_Callback(hObject, eventdata, handles)
% hObject    handle to D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = 587.330;
fs =handles.fs;
note_select = get(handles.Note,'SelectedObject');
n=handles.n;
Xi=handles.Xi;
slct = get(note_select,'String');


switch (slct)
    case 'Whole'
        t=n:1/fs:n+1;
        n=n+1;
    case 'Half'
        t=n:1/fs:n+0.5;
        n=n+0.5;
    case 'Quarter'
        t=n:1/fs:n+0.25;
        n=n+0.25;
end
Xi = [Xi sin(2*pi*f*t)];
handles.n=n;
handles.Xi = Xi;
guidata(hObject, handles);


% --- Executes on button press in E.
function E_Callback(hObject, eventdata, handles)
% hObject    handle to E (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = 659.255;
fs = handles.fs;
n=handles.n;
Xi=handles.Xi;
note_select = get(handles.Note,'SelectedObject');

slct = get(note_select,'String');


switch (slct)
    case 'Whole'
        t=n:1/fs:n+1;
        n=n+1;
    case 'Half'
        t=n:1/fs:n+0.5;
        n=n+0.5;
    case 'Quarter'
        t=n:1/fs:n+0.25;
        n=n+0.25;
end
Xi = [Xi sin(2*pi*f*t)];
handles.n=n;
handles.Xi = Xi;
guidata(hObject, handles);


% --- Executes on button press in F.
function F_Callback(hObject, eventdata, handles)
% hObject    handle to F (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = 698.456;
fs = handles.fs;
n=handles.n;
Xi=handles.Xi;
note_select = get(handles.Note,'SelectedObject');

slct = get(note_select,'String');


switch (slct)
    case 'Whole'
        t=n:1/fs:n+1;
        n=n+1;
    case 'Half'
        t=n:1/fs:n+0.5;
        n=n+0.5;
    case 'Quarter'
        t=n:1/fs:n+0.25;
        n=n+0.25;
end
Xi = [Xi sin(2*pi*f*t)];
handles.n=n;
handles.Xi = Xi;
guidata(hObject, handles);


% --- Executes on button press in G.
function G_Callback(hObject, eventdata, handles)
% hObject    handle to G (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = 783.991;
fs = handles.fs;
n=handles.n;
Xi=handles.Xi;
note_select = get(handles.Note,'SelectedObject');

slct = get(note_select,'String');


switch (slct)
    case 'Whole'
        t=n:1/fs:n+1;
        n=n+1;
    case 'Half'
        t=n:1/fs:n+0.5;
        n=n+0.5;
    case 'Quarter'
        t=n:1/fs:n+0.25;
        n=n+0.25;
end
Xi = [Xi sin(2*pi*f*t)];
handles.n=n;
handles.Xi = Xi;
guidata(hObject, handles);


% --- Executes on button press in A.
function A_Callback(hObject, eventdata, handles)
% hObject    handle to A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = 440.000;
fs = handles.fs;
n=handles.n;
Xi=handles.Xi;
note_select = get(handles.Note,'SelectedObject');

slct = get(note_select,'String');


switch (slct)
    case 'Whole'
        t=n:1/fs:n+1;
        n=n+1;
    case 'Half'
        t=n:1/fs:n+0.5;
        n=n+0.5;
    case 'Quarter'
        t=n:1/fs:n+0.25;
        n=n+0.25;
end
Xi = [Xi sin(2*pi*f*t)];
handles.n=n;
handles.Xi = Xi;
guidata(hObject, handles);


% --- Executes on button press in B.
function B_Callback(hObject, eventdata, handles)
% hObject    handle to B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = 493.883;
fs = handles.fs;
n=handles.n;
Xi=handles.Xi;
note_select = get(handles.Note,'SelectedObject');

slct = get(note_select,'String');


switch (slct)
    case 'Whole'
        t=n:1/fs:n+1;
        n=n+1;
    case 'Half'
        t=n:1/fs:n+0.5;
        n=n+0.5;
    case 'Quarter'
        t=n:1/fs:n+0.25;
        n=n+0.25;
end
Xi = [Xi sin(2*pi*f*t)];
handles.n=n;
handles.Xi = Xi;
guidata(hObject, handles);


% --- Executes on button press in Csharp.
function Csharp_Callback(hObject, eventdata, handles)
% hObject    handle to Csharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = 554.365;
fs = handles.fs;
n=handles.n;
Xi=handles.Xi;
note_select = get(handles.Note,'SelectedObject');

slct = get(note_select,'String');


switch (slct)
    case 'Whole'
        t=n:1/fs:n+1;
        n=n+1;
    case 'Half'
        t=n:1/fs:n+0.5;
        n=n+0.5;
    case 'Quarter'
        t=n:1/fs:n+0.25;
        n=n+0.25;
end
Xi = [Xi sin(2*pi*f*t)];
handles.n=n;
handles.Xi = Xi;
guidata(hObject, handles);


% --- Executes on button press in Dsharp.
function Dsharp_Callback(hObject, eventdata, handles)
% hObject    handle to Dsharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = 622.254;
fs = handles.fs;
n=handles.n;
Xi=handles.Xi;
note_select = get(handles.Note,'SelectedObject');

slct = get(note_select,'String');


switch (slct)
    case 'Whole'
        t=n:1/fs:n+1;
        n=n+1;
    case 'Half'
        t=n:1/fs:n+0.5;
        n=n+0.5;
    case 'Quarter'
        t=n:1/fs:n+0.25;
        n=n+0.25;
end
Xi = [Xi sin(2*pi*f*t)];
handles.n=n;
handles.Xi = Xi;
guidata(hObject, handles);


% --- EXiecutes on button press in Fsharp.
function Fsharp_Callback(hObject, eventdata, handles)
% hObject    handle to Fsharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = 739.989;
fs = handles.fs;
n=handles.n;
Xi=handles.Xi;
note_select = get(handles.Note,'SelectedObject');

slct = get(note_select,'String');


switch (slct)
    case 'Whole'
        t=n:1/fs:n+1;
        n=n+1;
    case 'Half'
        t=n:1/fs:n+0.5;
        n=n+0.5;
    case 'Quarter'
        t=n:1/fs:n+0.25;
        n=n+0.25;
end
Xi = [Xi sin(2*pi*f*t)];
handles.n=n;
handles.Xi = Xi;
guidata(hObject, handles);


% --- EXiecutes on button press in Gsharp.
function Gsharp_Callback(hObject, eventdata, handles)
% hObject    handle to Gsharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = 830.609;
fs = handles.fs;
n=handles.n;
Xi=handles.Xi;
note_select = get(handles.Note,'SelectedObject');

slct = get(note_select,'String');


switch (slct)
    case 'Whole'
        t=n:1/fs:n+1;
        n=n+1;
    case 'Half'
        t=n:1/fs:n+0.5;
        n=n+0.5;
    case 'Quarter'
        t=n:1/fs:n+0.25;
        n=n+0.25;
end
Xi = [Xi sin(2*pi*f*t)];
handles.n=n;
handles.Xi = Xi;

guidata(hObject, handles);


% --- EXiecutes on button press in Asharp.
function Asharp_Callback(hObject, eventdata, handles)
% hObject    handle to Asharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = 466.164;
fs = handles.fs;
n=handles.n;
Xi=handles.Xi;
note_select = get(handles.Note,'SelectedObject');

slct = get(note_select,'String');


switch (slct)
    case 'Whole'
        t=n:1/fs:n+1;
        n=n+1;
    case 'Half'
        t=n:1/fs:n+0.5;
        n=n+0.5;
    case 'Quarter'
        t=n:1/fs:n+0.25;
        n=n+0.25;
end
Xi = [Xi sin(2*pi*f*t)];
handles.n=n;
handles.Xi = Xi;
guidata(hObject, handles);


% --- EXiecutes on button press in Playy.
function Playy_Callback(hObject, eventdata, handles)
% hObject    handle to Playy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.n=0;  %Initialization of time stamp and song matrix
handles.Xi=[];
guidata(hObject, handles);


% --- EXiecutes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=handles.n
Xi=handles.Xi
handles.Str = [];
set(handles.STR1,'String',handles.Str);
guidata(hObject, handles);


% --- EXiecutes on button press in Detect Notes.
function DN_Callback(hObject, eventdata, handles)
% hObject    handle to DN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fs=handles.fs; 
S=get(handles.DG,'SelectedObject');
Select=get(S,'String');
switch Select  %to select which file from the 4 options to be analysed
    case 'Song1'
        X=handles.X;
        X = X(find(X,1,'first'):find(X,1,'last'));     %--trim leading & trailing zeros
        

        %%
        %fs = number of samples in 1 second (general observation => fs =44100)
        %ASSUMPTIONS - 
        %WHOLE NOTE = 1 sec
        %HALF NOTE = 0.5 sec
        %QUARTER NOTE = 0.25 sec

        %The input 'X' in segmented into small pieces of 250 milliseconds (0.25 sec) time length
        segment = buffer(X,floor(fs*0.25));
        Str = []; %Arbitrary variable to store the string of notes played in 'X'
        check = 0;
        prev_index = 0;
        for iteration = 1:size(segment,2)

            x = segment(:,iteration);
            filtered =[];
            Pow = [];
            for i=1:88
                a= 27.5*(2^((i-1)/12));
                [b,c]=butter(1,[(a-0.5)/(fs/2) (a+0.5)/(fs/2)],'bandpass');
                filter_x = filter(b,c,x); %filtering of signal frame
                filtered = [filtered; filter_x]; %-- ith row of matrix 'filtered' contains the filtered output of ith filter

                out_pow = bandpower(filter_x,fs,[(a-0.5) (a+0.5)]);
        %         disp(iteration);
                Pow = [Pow;out_pow];  %-- ith row of matrix 'Pow' contains the power of filtered output of ith filter
            end

            index = find(Pow==max(Pow)); %--index of maximum power corresponds to the dominant frequency in the segment of 0.25 sec
                                         %--by the relation dominant_frequency=27.5 X (2^(index/12)


            %Identify the alphabetical notation of the dominant note in the segment and save it in 'Str'                             
            if (index~=prev_index)
                prev_index = index;
                rem = mod(index,12);
                quo = floor(index/12);

                switch(check)
                    case 1
                        Str = strcat(Str,'(Q)');
                    case 2
                        Str = strcat(Str,'(H)');
                    case 4
                        ;
                    otherwise
                        Str=strcat(Str,'(H)');
                end

                check = 0;

                switch(rem)
                    case 1
                        Str = strcat(Str,'_','A',num2str(quo));
                    case 2
                        Str = strcat(Str,'_','A#',num2str(quo));
                    case 3
                        Str = strcat(Str,'_','B',num2str(quo));
                    case 4
                        Str = strcat(Str,'_','C',num2str(quo+1));
                    case 5
                        Str = strcat(Str,'_','C#',num2str(quo+1));
                    case 6
                        Str = strcat(Str,'_','D',num2str(quo+1));
                    case 7
                        Str = strcat(Str,'_','D#',num2str(quo+1));
                    case 8
                        Str = strcat(Str,'_','E',num2str(quo+1));
                    case 9
                        Str = strcat(Str,'_','F',num2str(quo+1));
                    case 10
                        Str = strcat(Str,'_','F#',num2str(quo+1));
                    case 11
                        Str = strcat(Str,'_','G',num2str(quo+1));
                    otherwise
                        Str = strcat(Str,'_','G#',num2str(quo+1));
                end
            end

            check = check +1;
            if (check == 4)
                Str = strcat(Str,'(W)');
                prev_index = 0;
            end

           
        end
        switch(check)
            case 1
                Str = strcat(Str,'(Q)');
            case 2
                Str = strcat(Str,'(H)');
            case 3
                Str = strcat(Str,'(H)');
            otherwise
        end
        
        set(handles.STR1, 'string', Str);
        
    case 'Song2'
        X2=handles.X2;
        
        X2 = X2(find(X2,1,'first'):find(X2,1,'last'));     %--trim leading & trailing zeros
        

        %%
        %fs = number of samples in 1 second (general observation => fs =44100)
        %ASSUMPTIONS - 
        %WHOLE NOTE = 1 sec
        %HALF NOTE = 0.5 sec
        %QUARTER NOTE = 0.25 sec

        %The input 'X' in segmented into small pieces of 250 milliseconds (0.25 sec) time length
        segment = buffer(X2,floor(fs*0.25));
        Str = []; %Arbitrary variable to store the string of notes played in 'X'
        check = 0;
        prev_index = 0;
        for iteration = 1:size(segment,2)

            x = segment(:,iteration);
            filtered =[];
            Pow = [];
            for i=1:88
                a= 27.5*(2^((i-1)/12));
                [b,c]=butter(1,[(a-0.5)/(fs/2) (a+0.5)/(fs/2)],'bandpass');
                filter_x = filter(b,c,x);
                filtered = [filtered; filter_x]; %-- ith row of matrix 'filtered' contains the filtered output of ith filter

                out_pow = bandpower(filter_x,fs,[(a-0.5) (a+0.5)]);
        %         disp(iteration);
                Pow = [Pow;out_pow];  %-- ith row of matrix 'Pow' contains the power of filtered output of ith filter
            end

            index = find(Pow==max(Pow)); %--index of maximum power corresponds to the dominant frequency in the segment of 0.25 sec
                                         %--by the relation dominant_frequency=27.5 X (2^(index/12)


            %Identify the alphabetical notation of the dominant note in the segment and save it in 'Str'                             
            if (index~=prev_index)
                prev_index = index;
                rem = mod(index,12);
                quo = floor(index/12);

                switch(check)
                    case 1
                        Str = strcat(Str,'(Q)');
                    case 2
                        Str = strcat(Str,'(H)');
                    case 4
                        ;
                    otherwise
                        Str=strcat(Str,'(H)');
                end

                check = 0;

                switch(rem)
                    case 1
                        Str = strcat(Str,'_','A',num2str(quo));
                    case 2
                        Str = strcat(Str,'_','A#',num2str(quo));
                    case 3
                        Str = strcat(Str,'_','B',num2str(quo));
                    case 4
                        Str = strcat(Str,'_','C',num2str(quo+1));
                    case 5
                        Str = strcat(Str,'_','C#',num2str(quo+1));
                    case 6
                        Str = strcat(Str,'_','D',num2str(quo+1));
                    case 7
                        Str = strcat(Str,'_','D#',num2str(quo+1));
                    case 8
                        Str = strcat(Str,'_','E',num2str(quo+1));
                    case 9
                        Str = strcat(Str,'_','F',num2str(quo+1));
                    case 10
                        Str = strcat(Str,'_','F#',num2str(quo+1));
                    case 11
                        Str = strcat(Str,'_','G',num2str(quo+1));
                    otherwise
                        Str = strcat(Str,'_','G#',num2str(quo+1));
                end
            end

            check = check +1;
            if (check == 4)
                Str = strcat(Str,'(W)');
                prev_index = 0;
            end

           
        end
        switch(check)
            case 1
                Str = strcat(Str,'(Q)');
            case 2
                Str = strcat(Str,'(H)');
            case 3
                Str = strcat(Str,'(H)');
            otherwise
                
        end
        Str
        set(handles.STR1, 'string', Str);
    case 'Piano'
        Xi=handles.Xi;
        Xi = Xi(find(Xi,1,'first'):find(Xi,1,'last'));     %--trim leading & trailing zeros
        

        %%
        %fs = number of samples in 1 second (general observation => fs =44100)
        %ASSUMPTIONS - 
        %WHOLE NOTE = 1 sec
        %HALF NOTE = 0.5 sec
        %QUARTER NOTE = 0.25 sec

        %The input 'X' in segmented into small pieces of 250 milliseconds (0.25 sec) time length
        segment = buffer(Xi,floor(fs*0.25));
        Str = []; %Arbitrary variable to store the string of notes played in 'X'
        check = 0;
        prev_index = 0;
        for iteration = 1:size(segment,2)

            x = segment(:,iteration);
            filtered =[];
            Pow = [];
            for i=1:88
                a= 27.5*(2^((i-1)/12));
                [b,c]=butter(1,[(a-0.5)/(fs/2) (a+0.5)/(fs/2)],'bandpass');
                filter_x = filter(b,c,x);
                filtered = [filtered; filter_x]; %-- ith row of matrix 'filtered' contains the filtered output of ith filter

                out_pow = bandpower(filter_x,fs,[(a-0.5) (a+0.5)]);
        %         disp(iteration);
                Pow = [Pow;out_pow];  %-- ith row of matrix 'Pow' contains the power of filtered output of ith filter
            end

            index = find(Pow==max(Pow)); %--index of maximum power corresponds to the dominant frequency in the segment of 0.25 sec
                                         %--by the relation dominant_frequency=27.5 X (2^(index/12)


            %Identify the alphabetical notation of the dominant note in the segment and save it in 'Str'                             
            if (index~=prev_index)
                prev_index = index;
                rem = mod(index,12);
                quo = floor(index/12);

                switch(check)
                    case 1
                        Str = strcat(Str,'(Q)');
                    case 2
                        Str = strcat(Str,'(H)');
                    case 4
                        ;
                    otherwise
                        Str=strcat(Str,'(H)');
                end

                check = 0;

                switch(rem)
                    case 1
                        Str = strcat(Str,'_','A',num2str(quo));
                    case 2
                        Str = strcat(Str,'_','A#',num2str(quo));
                    case 3
                        Str = strcat(Str,'_','B',num2str(quo));
                    case 4
                        Str = strcat(Str,'_','C',num2str(quo+1));
                    case 5
                        Str = strcat(Str,'_','C#',num2str(quo+1));
                    case 6
                        Str = strcat(Str,'_','D',num2str(quo+1));
                    case 7
                        Str = strcat(Str,'_','D#',num2str(quo+1));
                    case 8
                        Str = strcat(Str,'_','E',num2str(quo+1));
                    case 9
                        Str = strcat(Str,'_','F',num2str(quo+1));
                    case 10
                        Str = strcat(Str,'_','F#',num2str(quo+1));
                    case 11
                        Str = strcat(Str,'_','G',num2str(quo+1));
                    otherwise
                        Str = strcat(Str,'_','G#',num2str(quo+1));
                end
            end

            check = check +1;
            if (check == 4)
                Str = strcat(Str,'(W)');
                prev_index = 0;
            end

           
        end
        switch(check)
            case 1
                Str = strcat(Str,'(Q)');
            case 2
                Str = strcat(Str,'(H)');
            case 3
                Str = strcat(Str,'(H)');
            otherwise
                
        end
        Str
        set(handles.STR1, 'string', Str);
    case 'From WAV file'
        Y=handles.Y;
        
        Y = Y(find(Y,1,'first'):find(Y,1,'last'));     %--trim leading & trailing zeros
        

        %%
        %fs = number of samples in 1 second (general observation => fs =44100)
        %ASSUMPTIONS - 
        %WHOLE NOTE = 1 sec
        %HALF NOTE = 0.5 sec
        %QUARTER NOTE = 0.25 sec

        %The input 'X' in segmented into small pieces of 250 milliseconds (0.25 sec) time length
        segment = buffer(Y,floor(fs*0.25));
        Str = []; %Arbitrary variable to store the string of notes played in 'X'
        check = 0;
        prev_index = 0;
        for iteration = 1:size(segment,2)

            x = segment(:,iteration);
            filtered =[];
            Pow = [];
            for i=1:88
                a= 27.5*(2^((i-1)/12));
                [b,c]=butter(1,[(a-0.5)/(fs/2) (a+0.5)/(fs/2)],'bandpass');
                filter_x = filter(b,c,x);
                filtered = [filtered; filter_x]; %-- ith row of matrix 'filtered' contains the filtered output of ith filter

                out_pow = bandpower(filter_x,fs,[(a-0.5) (a+0.5)]);
        %         disp(iteration);
                Pow = [Pow;out_pow];  %-- ith row of matrix 'Pow' contains the power of filtered output of ith filter
            end

            index = find(Pow==max(Pow)); %--index of maximum power corresponds to the dominant frequency in the segment of 0.25 sec
                                         %--by the relation dominant_frequency=27.5 X (2^(index/12)


            %Identify the alphabetical notation of the dominant note in the segment and save it in 'Str'                             
            if (index~=prev_index)
                prev_index = index;
                rem = mod(index,12);
                quo = floor(index/12);

                switch(check)
                    case 1
                        Str = strcat(Str,'(Q)');
                    case 2
                        Str = strcat(Str,'(H)');
                    case 4
                        ;
                    otherwise
                        Str=strcat(Str,'(H)');
                end

                check = 0;

                switch(rem)
                    case 1
                        Str = strcat(Str,'_','A',num2str(quo));
                    case 2
                        Str = strcat(Str,'_','A#',num2str(quo));
                    case 3
                        Str = strcat(Str,'_','B',num2str(quo));
                    case 4
                        Str = strcat(Str,'_','C',num2str(quo+1));
                    case 5
                        Str = strcat(Str,'_','C#',num2str(quo+1));
                    case 6
                        Str = strcat(Str,'_','D',num2str(quo+1));
                    case 7
                        Str = strcat(Str,'_','D#',num2str(quo+1));
                    case 8
                        Str = strcat(Str,'_','E',num2str(quo+1));
                    case 9
                        Str = strcat(Str,'_','F',num2str(quo+1));
                    case 10
                        Str = strcat(Str,'_','F#',num2str(quo+1));
                    case 11
                        Str = strcat(Str,'_','G',num2str(quo+1));
                    otherwise
                        Str = strcat(Str,'_','G#',num2str(quo+1));
                end
            end

            check = check +1;
            if (check == 4)
                Str = strcat(Str,'(W)');
                prev_index = 0;
            end

           
        end
        switch(check)
            case 1
                Str = strcat(Str,'(Q)');
            case 2
                Str = strcat(Str,'(H)');
            case 3
                Str = strcat(Str,'(H)');
            otherwise
                
        end
        Str
        set(handles.STR1, 'string', Str);
        
        
end
guidata(hObject,handles);


% --- Executes on button press in Fake Music Detector Block1.
function FMDB1_Callback(hObject, eventdata, handles)
% hObject    handle to FMDB1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=get(handles.FMD,'SelectedObject');
Select1=get(F,'String');
switch Select1
    case 'Song1'
        X=handles.X;
        
        fs=handles.fs;
        X = X(find(X,1,'first'):find(X,1,'last')); %to remove initial and final silence the signal
        filter_x = X;
    

        for i=1:88
                f_c = (27.5*(2^((i-1)/12)))/(fs/2);
                [b,c]=iirnotch(f_c,f_c/35);
                filter_x = filter(b,c,filter_x);

        end
        out_pow_har1 =rms(filter_x)^2;
        out_pow_tone =rms(X)^2;

        if (out_pow_har1 > 0.4*out_pow_tone) %threshold selected according totested samples
            disp('Given tone is a real music');
        elseif (out_pow_har1 < 0.4*out_pow_tone)
            disp('Given tone is a fake music');
        else
            disp('Further analysis needed to determine real/fake');
        end
        
    case 'Song2'
        X2=handles.X2;
        
        fs=handles.fs;
        X2 = X2(find(X2,1,'first'):find(X2,1,'last'));
        filter_x = X2;


        for i=1:88
                f_c = (27.5*(2^((i-1)/12)))/(fs/2);
                [b,c]=iirnotch(f_c,f_c/35);
                filter_x = filter(b,c,filter_x);

        end
        out_pow_har1 =rms(filter_x)^2
        out_pow_tone =rms(X2)^2

        if (out_pow_har1 > 0.4*out_pow_tone)
            disp('Given tone is a real music');
        elseif (out_pow_har1 < 0.4*out_pow_tone)
            disp('Given tone is a fake music');
        else
            disp('Further analysis needed to determine real/fake');
        end
    case 'Piano'
        Xi=handles.Xi;
        
        fs=handles.fs;
        Xi = Xi(find(Xi,1,'first'):find(Xi,1,'last'));
        filter_x = Xi;


        for i=1:88
                f_c = (27.5*(2^((i-1)/12)))/(fs/2);
                [b,c]=iirnotch(f_c,f_c/35);
                filter_x = filter(b,c,filter_x);

        end
        out_pow_har1 =rms(filter_x)^2
        out_pow_tone =rms(Xi)^2

        if (out_pow_har1 > 0.4*out_pow_tone)
            disp('Given tone is a real music');
        elseif (out_pow_har1 < 0.4*out_pow_tone)
            disp('Given tone is a fake music');
        else
            disp('Further analysis needed to determine real/fake');
        end
    case 'Wav file'
        Y=handles.Y;
        
        fs=handles.Fs;
        Y = Y(find(Y,1,'first'):find(Y,1,'last'));
        filter_x = Y;
    

        for i=1:88
                f_c = (27.5*(2^((i-1)/12)))/(fs/2);
                [b,c]=iirnotch(f_c,f_c/35);
                filter_x = filter(b,c,filter_x);

        end
        out_pow_har1 =rms(filter_x)^2
        out_pow_tone =rms(Y)^2

        if (out_pow_har1 > 0.4*out_pow_tone)
            disp('Given tone is a real music');
        elseif (out_pow_har1 < 0.4*out_pow_tone)
            disp('Given tone is a fake music');
        else
            disp('Further analysis needed to determine real/fake');
        end
        
        
        
end


% --- Executes on button press in Fake music Detector Block2.
function FMDB2_Callback(hObject, eventdata, handles)
% hObject    handle to FMDB2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=get(handles.FMD,'SelectedObject');
Select1=get(F,'String');
switch Select1
    case 'Song1'
        X=handles.X;

        fs=handles.fs;
        X = X(find(X,1,'first'):find(X,1,'last'));
        segment = buffer(X,floor(fs*0.25));%windowing operation
        [r c] = size(segment);
        disp(c);
        check = 0;
        prev_index = 0;
        lambda =[];

        for iteration = 1:size(segment,2)
            disp(iteration);
            x = segment(:,iteration);
            filtered =[];

            Pow = [];

            for i=1:88
                a= 27.5*(2^((i-1)/12));
                [b,c]=butter(1,[(a-0.5)/(fs/2) (a+0.5)/(fs/2)],'bandpass');%bandpass filter center at notes freq
                filter_x = filter(b,c,x);
                filter_x=filter_x';
                filtered = [filtered; filter_x]; %-- ith row of matrix 'filtered_1' contains the filtered output of ith filter

                out_pow = bandpower(filter_x,fs,[(a-0.5) (a+0.5)]);
        %         disp(iteration);
                Pow = [Pow;out_pow];  %-- ith row of matrix 'Pow' contains the power of filtered output of ith filter
            end

            index = find(Pow==max(Pow)) %--index of maximum power corresponds to the dominant frequency in the segment of 0.25 sec
                                         %--by the relation dominant_frequency=27.5 X (2^(index/12)

            y = fft(x); %--Taking Fourier transforms of each ith segment
            m = abs(y); 

            frq = 27.5*(2.^((index-1)/12));

        %     if (2*frq > 4186)

            l = expfit([m(floor(frq)) m(floor(2*frq))]); %--Finding the exponential decay factor lambda of dominant frequency
            lambda = [lambda l]; %--Stacking the i lambdas
        end

        varnc = var(lambda);

        if (varnc > 100)
            disp('Given tone is a real music');
        else
            disp('Given tone is a fake music');
        end
        
    case 'Song2'
        X2=handles.X2;
        fs=handles.fs;
        X2 = X2(find(X2,1,'first'):find(X2,1,'last'));
        segment = buffer(X2,floor(fs*0.25));
        [r c] = size(segment);
        disp(c);
        check = 0;
        prev_index = 0;
        lambda =[];

        for iteration = 1:size(segment,2)
            disp(iteration);
            x = segment(:,iteration);
            filtered =[];

            Pow = [];

            for i=1:88
                a= 27.5*(2^((i-1)/12));
                [b,c]=butter(1,[(a-0.5)/(fs/2) (a+0.5)/(fs/2)],'bandpass');
                filter_x = filter(b,c,x);
                filter_x=filter_x';
                filtered = [filtered; filter_x]; %-- ith row of matrix 'filtered_1' contains the filtered output of ith filter

                out_pow = bandpower(filter_x,fs,[(a-0.5) (a+0.5)]);
        %         disp(iteration);
                Pow = [Pow;out_pow];  %-- ith row of matrix 'Pow' contains the power of filtered output of ith filter
            end

            index = find(Pow==max(Pow)); %--index of maximum power corresponds to the dominant frequency in the segment of 0.25 sec
                                         %--by the relation dominant_frequency=27.5 X (2^(index/12)

            y = fft(x); %--Taking Fourier transforms of each ith segment
            m = abs(y); 

            frq = 27.5*(2.^((index-1)/12));

        %     if (2*frq > 4186)

            l = expfit([m(floor(frq)) m(floor(2*frq))]); %--Finding the exponential decay factor lambda of dominant frequency
            lambda = [lambda l]; %--Stacking the i lambdas
        end

        varnc = var(lambda)

        if (varnc > 100)
            disp('Given tone is a real music');
        else
            disp('Given tone is a fake music');
        end
    case 'Piano'
        Xi=handles.Xi;
        fs=handles.fs;
        Xi = Xi(find(Xi,1,'first'):find(Xi,1,'last'));
        segment = buffer(Xi,floor(fs*0.25));
        [r c] = size(segment);
        disp(c);
        check = 0;
        prev_index = 0;
        lambda =[];

        for iteration = 1:size(segment,2)
            disp(iteration);
            x = segment(:,iteration);
            filtered =[];

            Pow = [];

            for i=1:88
                a= 27.5*(2^((i-1)/12));
                [b,c]=butter(1,[(a-0.5)/(fs/2) (a+0.5)/(fs/2)],'bandpass');
                filter_x = filter(b,c,x);
                filter_x=filter_x';
                filtered = [filtered; filter_x]; %-- ith row of matrix 'filtered_1' contains the filtered output of ith filter

                out_pow = bandpower(filter_x,fs,[(a-0.5) (a+0.5)]);
        %         disp(iteration);
                Pow = [Pow;out_pow];  %-- ith row of matrix 'Pow' contains the power of filtered output of ith filter
            end

            index = find(Pow==max(Pow)); %--index of maximum power corresponds to the dominant frequency in the segment of 0.25 sec
                                         %--by the relation dominant_frequency=27.5 X (2^(index/12)

            y = fft(x); %--Taking Fourier transforms of each ith segment
            m = abs(y); 

            frq = 27.5*(2.^((index-1)/12));

        %     if (2*frq > 4186)

            l = expfit([m(floor(frq)) m(floor(2*frq))]); %--Finding the exponential decay factor lambda of dominant frequency
            lambda = [lambda l]; %--Stacking the i lambdas
        end

        varnc = var(lambda)

        if (varnc > 100)
            disp('Given tone is a real music');
        else
            disp('Given tone is a fake music');
        end
    case 'Wav file'
        Y=handles.Y;
        fs=handles.Fs;
        Y = Y(find(Y,1,'first'):find(Y,1,'last'));
        segment = buffer(Y,floor(fs*0.25));
        [r c] = size(segment);
        disp(c);
        check = 0;
        prev_index = 0;
        lambda =[];

        for iteration = 1:size(segment,2)
            disp(iteration);
            x = segment(:,iteration);
            filtered =[];

            Pow = [];

            for i=1:88
                a= 27.5*(2^((i-1)/12));
                [b,c]=butter(1,[(a-0.5)/(fs/2) (a+0.5)/(fs/2)],'bandpass');
                filter_x = filter(b,c,x);
                filter_x=filter_x';
                filtered = [filtered; filter_x]; %-- ith row of matrix 'filtered_1' contains the filtered output of ith filter

                out_pow = bandpower(filter_x,fs,[(a-0.5) (a+0.5)]);
        %         disp(iteration);
                Pow = [Pow;out_pow];  %-- ith row of matrix 'Pow' contains the power of filtered output of ith filter
            end

            index = find(Pow==max(Pow)); %--index of maximum power corresponds to the dominant frequency in the segment of 0.25 sec
                                         %--by the relation dominant_frequency=27.5 X (2^(index/12)

            y = fft(x); %--Taking Fourier transforms of each ith segment
            m = abs(y); 

            frq = 27.5*(2.^((index-1)/12));

        %     if (2*frq > 4186)

            l = expfit([m(floor(frq)) m(floor(2*frq))]); %--Finding the exponential decay factor lambda of dominant frequency
            lambda = [lambda l]; %--Stacking the i lambdas
        end

        varnc = var(lambda)

        if (varnc > 100)
            disp('Given tone is a real music');
        else
            disp('Given tone is a fake music');
        end
        
         
            
            
end


% --- Executes on button press in Wavefile.
function Wavefile_Callback(hObject, eventdata, handles)
% hObject    handle to Wavefile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
startingFolder = 'G:\Digital_Audio_forensics';
if ~exist(startingFolder, 'dir')
	% If that folder doesn't exist, just start in the current folder.
	startingFolder = pwd;
end
% Get the name of the mat file that the user wants to use.
defaultFileName = fullfile(startingFolder, '*.wav');
[baseFileName, folder] = uigetfile(defaultFileName, 'Select a wav file');
if baseFileName == 0
	% User clicked the Cancel button.
	return;
end
fullFileName = fullfile(folder, baseFileName)
[Y,Fs]=audioread(baseFileName); 
handles.Y=Y;
handles.Fs=Fs;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function STR1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to STR1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
