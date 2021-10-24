%Convert the origin images to HSV color domain,  then use H for selection a particular color through lower and upper threshold.
%By adjusting the lower and higher threshold to find the color we want.
%Covert HSV color domain to RGB domine and then to binary image as required.

function varargout = WEIYANG_21220208_Lab05(varargin)
% WEIYANG_21220208_LAB05 MATLAB code for WEIYANG_21220208_Lab05.fig
%      WEIYANG_21220208_LAB05, by itself, creates a new WEIYANG_21220208_LAB05 or raises the existing
%      singleton*.
%
%      H = WEIYANG_21220208_LAB05 returns the handle to a new WEIYANG_21220208_LAB05 or the handle to
%      the existing singleton*.
%
%      WEIYANG_21220208_LAB05('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WEIYANG_21220208_LAB05.M with the given input arguments.
%
%      WEIYANG_21220208_LAB05('Property','Value',...) creates a new WEIYANG_21220208_LAB05 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WEIYANG_21220208_Lab05_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WEIYANG_21220208_Lab05_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WEIYANG_21220208_Lab05

% Last Modified by GUIDE v2.5 19-May-2020 11:27:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WEIYANG_21220208_Lab05_OpeningFcn, ...
                   'gui_OutputFcn',  @WEIYANG_21220208_Lab05_OutputFcn, ...
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


% --- Executes just before WEIYANG_21220208_Lab05 is made visible.
function WEIYANG_21220208_Lab05_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WEIYANG_21220208_Lab05 (see VARARGIN)

% Choose default command line output for WEIYANG_21220208_Lab05
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
%initialization
set(handles.text4,'string',get(handles.slider1,'value')); %Initialize the value of text4
set(handles.text5,'string',get(handles.slider2,'value')); %Initialize the value of text5

% UIWAIT makes WEIYANG_21220208_Lab05 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = WEIYANG_21220208_Lab05_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I1; %global I1 to pass it to other functions
global I   %global I variable y to pass it to other functions
[file,path] = uigetfile({'*.*'});
x = strcat(path,file);%Open a file selection dialog box to choose an image
I = imread(x);% Input an image
I1 = rgb2hsv(I);% Convert RGB image to HSV color domain
axes(handles.axes1);% handle to axes1
imshow(I); %Show image of input
title('Input Image');
channel1Min = get(handles.slider1,'Value'); % get the lower threshold from slider1.
channel1Max = get(handles.slider2,'Value'); % get the higher threshold from slider1.
if channel1Max >=channel1Min
BW = (I1(:,:,1) >= channel1Min ) & (I1(:,:,1) <= channel1Max); % Create mask based on lower and higher threshold
else
    BW = (I1(:,:,1) >= channel1Min ) | (I1(:,:,1) <= channel1Max); 
end
maskedImage = I;% Initialize output masked image based on input image.
maskedImage(repmat(~BW,[1 1 3])) = 0; % Set background pixels where is false to zero.
Im=rgb2gray(maskedImage)>0; % convert to binary image
axes(handles.axes2);% handle to axes2
imshow(Im);  % show segmented image
title('Segmentation Image');




% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I1;
global I
sliderval = get(hObject,'Value'); % get the lnumber form the slider
set(handles.text4,'string',sliderval); % use a static text to show the threshold on the app panel
channel1Min = sliderval;  % use the number form the slider as lower threshold
channel1Max = get(handles.slider2,'Value'); % get the higher threshold from slider2
if channel1Max >=channel1Min
BW = (I1(:,:,1) >= channel1Min ) & (I1(:,:,1) <= channel1Max);% Create mask based on lower and higher threshold
else
    BW = (I1(:,:,1) >= channel1Min ) | (I1(:,:,1) <= channel1Max);
end
maskedImage = I;% Initialize output masked image based on input image.
maskedImage(repmat(~BW,[1 1 3])) = 0; % Set background pixels where is false to zero.
Im=rgb2gray(maskedImage)>0; % convert to binary image
axes(handles.axes2);% handle to axes2
imshow(Im);   % show segmented image
title('Segmentation Image');

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I1;
global I
sliderval = get(hObject,'Value');  % get the lnumber form the slider
set(handles.text5,'string',sliderval); % use a static text to show the threshold on the app panel
channel1Min = get(handles.slider1,'Value'); % get the lower threshold from slider1
channel1Max = sliderval; % use the number form the slider as lower threshold
if channel1Max >=channel1Min
BW = (I1(:,:,1) >= channel1Min ) & (I1(:,:,1) <= channel1Max);% Create mask based on lower and higher threshold
else
    BW = (I1(:,:,1) >= channel1Min ) | (I1(:,:,1) <= channel1Max);
end
maskedImage = I;% Initialize output masked image based on input image.
maskedImage(repmat(~BW,[1 1 3])) = 0; % Set background pixels where is false to zero.
Im=rgb2gray(maskedImage)>0;% convert to binary image
axes(handles.axes2);% handle to axes2
imshow(Im); % show segmented image
title('Segmentation Image');

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function text4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
