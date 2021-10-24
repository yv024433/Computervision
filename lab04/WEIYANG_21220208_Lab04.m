% LAB04 WEI YANG 21220208

%  1.What edge detection techniques being used? 
%  In the program 4  edge detection techniques (Canny, Prewitt, Laplacian of Gaussian, Sobel) 
%  are used to detect the edge of a given Image. Any circle with in the image with  r more than 15 pixels will be found.

%  2. What is the role of edge detection threshold? 
%  Once we have measured of the gradient magnitude, then applying a threshold to decide whether edges are present or not at an image point. 
%  The lower the threshold, the more edges will be detected and the result will be increasingly susceptible to noise. 
%  Conversely a high threshold may miss subtle edges, or result in fragmented edges. 

%  3.How the circle is detected? 
%  Firstly, Hough transform for circles.Takes a binary 2-D image  and a vector RADII giving the radii of circles to detect. 
%  It returns the 3-D accumulator array.
%  Secondly,  finds peaks which get the most votes in the output of CIRCLE_HOUGH
%  Then, gets its edges and displays circles

function varargout = WEIYANG_21220208_Lab04(varargin)
% WEIYANG_21220208_LAB04 MATLAB code for WEIYANG_21220208_Lab04.fig
%      WEIYANG_21220208_LAB04, by itself, creates a new WEIYANG_21220208_LAB04 or raises the existing
%      singleton*.
%
%      H = WEIYANG_21220208_LAB04 returns the handle to a new WEIYANG_21220208_LAB04 or the handle to
%      the existing singleton*.
%
%      WEIYANG_21220208_LAB04('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WEIYANG_21220208_LAB04.M with the given input arguments.
%
%      WEIYANG_21220208_LAB04('Property','Value',...) creates a new WEIYANG_21220208_LAB04 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WEIYANG_21220208_Lab04_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WEIYANG_21220208_Lab04_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WEIYANG_21220208_Lab04

% Last Modified by GUIDE v2.5 28-Mar-2020 17:52:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WEIYANG_21220208_Lab04_OpeningFcn, ...
                   'gui_OutputFcn',  @WEIYANG_21220208_Lab04_OutputFcn, ...
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


% --- Executes just before WEIYANG_21220208_Lab04 is made visible.
function WEIYANG_21220208_Lab04_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WEIYANG_21220208_Lab04 (see VARARGIN)

% Choose default command line output for WEIYANG_21220208_Lab04
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
%initialization
set(handles.text6,'string',get(handles.slider1,'value')); %Initialize the value of text6
set(handles.text7,'string',get(handles.slider2,'value')); %Initialize the value of text7




% UIWAIT makes WEIYANG_21220208_Lab04 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = WEIYANG_21220208_Lab04_OutputFcn(hObject, eventdata, handles) 
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
global y;  %global a variable y to pass it to other functions
global i;  %global a variable i to pass it to other functions
[file,path] = uigetfile({'*.jpg';'*.png';'*.*'});
x = strcat(path,file);%Open a file selection dialog box to choose an image
i = imread(x);% Input an image
axes(handles.axes1);% handle to axes1
imshow(x); %Show image of input
title('Input Image')
y = rgb2gray(i);%Convert images to grayscale and double precision


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y;  
contents = cellstr(get(handles.popupmenu1,'String'));
a = contents{get(handles.popupmenu1,'Value')};% get the method used in edge detection from popupmenu1
   e = edge(y, a);   % the selected edge detector execute with default threshold for image y 
axes(handles.axes2); %handle to axes2
imshow(e); % show the Detected edge image
title('Edge')


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y;
global e; %global a variable e which is the edge image which will be used in circle detection
contents = cellstr(get(handles.popupmenu1,'String'));
a = contents{get(handles.popupmenu1,'Value')};% get the method used in edge detection from popupmenu1
sliderval = get(hObject,'Value'); % get the threshold for edge detection form the slider
set(handles.text6,'string',sliderval); % use a static text to show the threshold on the app panel
e = edge(y, a,sliderval); % use selected method and threshold to detect the edge of gray scale image y
axes(handles.axes2); %handle to axes2
imshow(e); %show the Detected edge image with threshold
title('Edge')




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
global e; %get the image of edge
global i; %get the input image
radii = get(hObject,'Value')-2:1:get(hObject,'Value')+2; %search r from given radii minus 2 to given value  plus 2 pixels, in steps of 1 pixel.
set(handles.text7,'string',get(hObject,'Value'));  % use a static text to show the radii we selected on the app panel
% takes a binary 2-D edge image e and avector RADII giving the radii of circles to detect. It returns the 3-D accumulator array h
%'same' returns only the part of H corresponding to centre positions within the image.
% 'normalise' multiplies each slice of h, h(:,:,K), by 1/RADII(K). 
h = circle_hough(e, radii, 'same', 'normalise'); 
%locates the positions of peaks in the output of CIRCLE_HOUGH.
%'Npeaks' sets the maximum number of peaks to be found and I set it 2.
% 'Threshold' sets the minimum number of votes (after any smoothing) needed for a peak to be counted. 
%The default is 0.5 * the maximum value in H. I set it to be 0.9* the maximum value in H to detect less distracter
peaks = circle_houghpeaks(h, radii, 'nhoodxy', 15, 'nhoodr', 21, 'npeaks',2);
axes(handles.axes2); %handle to axes2
imshow(e);
title('Edge')

%Draw the circles found on the both input and edge image, using both the positions and the radii stored in the peaks array. 
%The circlepoints function is convenient for this - it is also used by circle_hough so comes with it.
hold on;
for peak = peaks
    [x, y] = circlepoints(peak(3));
    plot(x+peak(1), y+peak(2), 'r');
end
hold off

axes(handles.axes1); %handle to axes1
imshow(i);
title('Input Image')
hold on;
for peak = peaks
    [x, y] = circlepoints(peak(3));
    plot(x+peak(1), y+peak(2), 'r');
end
hold off

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


% --- Executes during object creation, after setting all properties.
function text6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes during object creation, after setting all properties.
function text7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
