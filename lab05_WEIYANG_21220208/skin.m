function varargout = skin(varargin)
% SKIN MATLAB code for skin.fig
%      SKIN, by itself, creates a new SKIN or raises the existing
%      singleton*.
%
%      H = SKIN returns the handle to a new SKIN or the handle to
%      the existing singleton*.
%
%      SKIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SKIN.M with the given input arguments.
%
%      SKIN('Property','Value',...) creates a new SKIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before skin_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to skin_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help skin

% Last Modified by GUIDE v2.5 06-Apr-2020 17:05:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @skin_OpeningFcn, ...
                   'gui_OutputFcn',  @skin_OutputFcn, ...
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


% --- Executes just before skin is made visible.
function skin_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to skin (see VARARGIN)

% Choose default command line output for skin
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes skin wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = skin_OutputFcn(hObject, eventdata, handles) 
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
[file,path] = uigetfile({'*.*'});
x = strcat(path,file);%Open a file selection dialog box to choose an image
I = imread(x);% Input an image
I1 = rgb2hsv(I);% Convert RGB image to HSV color domain
axes(handles.axes1);% handle to axes1
imshow(I); %Show image of input
title('Input Image');
% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.038;
channel1Max = 0.139;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.062;
channel2Max = 0.626;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.605;
channel3Max = 1.000;

% Create mask based on chosen histogram thresholds
BW = (I1(:,:,1) >= channel1Min ) & (I1(:,:,1) <= channel1Max) & ...
    (I1(:,:,2) >= channel2Min ) & (I1(:,:,2) <= channel2Max) & ...
    (I1(:,:,3) >= channel3Min ) & (I1(:,:,3) <= channel3Max);
maskedImage = I;% Initialize output masked image based on input image.
maskedImage(repmat(~BW,[1 1 3])) = 0; % Set background pixels where is false to zero.
Im=rgb2gray(maskedImage)>0; % convert to binary image
axes(handles.axes2);% handle to axes2
imshow(Im);  % show segmented image
title('Skin Detected');
