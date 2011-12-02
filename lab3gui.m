function varargout = lab3gui(varargin)
% LAB3GUI MATLAB code for lab3gui.fig
%      LAB3GUI, by itself, creates a new LAB3GUI or raises the existing
%      singleton*.
%
%      H = LAB3GUI returns the handle to a new LAB3GUI or the handle to
%      the existing singleton*.
%
%      LAB3GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAB3GUI.M with the given input arguments.
%
%      LAB3GUI('Property','Value',...) creates a new LAB3GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lab3gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lab3gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lab3gui

% Last Modified by GUIDE v2.5 29-Nov-2011 15:35:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lab3gui_OpeningFcn, ...
                   'gui_OutputFcn',  @lab3gui_OutputFcn, ...
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


% --- Executes just before lab3gui is made visible.
function lab3gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lab3gui (see VARARGIN)

% Choose default command line output for lab3gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lab3gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lab3gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in q1.
function q1_Callback(hObject, eventdata, handles)
% hObject    handle to q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
deltax = [-1 0 1; -2 0 2; -1 0 1]; % Sobel operator
deltay = deltax';
lx = [0 0 0; -1/2 0 1/2; 0 0 0];

tools = few256;
dxtools = conv2(tools, deltax, 'valid');
dytools = conv2(tools, deltay, 'valid');
cdiff = conv2(tools, lx, 'valid');

figure(1);
subplot(1,1,1); % Clear
subplot(2,2,1); showgray(tools); title('tools');
subplot(2,2,2); showgray(cdiff/max(abs(cdiff(:))) - dxtools/max(abs(dxtools(:))));
title('difference between central difference and sobel (x-direction)');
subplot(2,2,3); showgray(dxtools); title('dxtools');
subplot(2,2,4); showgray(dytools); title('dytools');
set(handles.text1, 'String', sprintf('size(tools) = [%d, %d]\nsize(dxtools) = [%d, %d]\nsize(dytools) = [%d, %d]\n', ...
    size(tools), size(dxtools), size(dytools)));


% --- Executes on button press in q2.
function q2_Callback(hObject, eventdata, handles)
% hObject    handle to q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
deltax = [-1 0 1; -2 0 2; -1 0 1]; % Sobel operator
deltay = deltax';

tools = few256;
dxtools = conv2(tools, deltax, 'valid');
dytools = conv2(tools, deltay, 'valid');
gradmagtools = sqrt(dxtools .^ 2 + dytools .^ 2);

smooth1 = str2double(get(handles.smooth1, 'String'));

sm_tools = discgaussfft(tools, smooth1);
sm_dxtools = conv2(sm_tools, deltax, 'valid');
sm_dytools = conv2(sm_tools, deltay, 'valid');
sm_gradmagtools = sqrt(sm_dxtools .^ 2 + sm_dytools .^ 2);

threshold1 = str2double(get(handles.threshold1, 'String'));
threshold2 = str2double(get(handles.threshold2, 'String'));

figure(1);
subplot(1,1,1);
subplot(2,4,1); showgray(tools); title('tools');
subplot(2,4,2); showgray(gradmagtools); title('gradient magnitude tools');
subplot(2,4,3); hist(gradmagtools(:), 256); title('histogram');
subplot(2,4,4); showgray(gradmagtools-threshold1 > 0); title(sprintf('threshold = %d', threshold1));

subplot(2,4,5); showgray(sm_tools); title('smoothed tools');
subplot(2,4,6); showgray(sm_gradmagtools); title('gradient magnitude of smoothed tools');
subplot(2,4,7); hist(sm_gradmagtools(:), 256); title('histogram');
subplot(2,4,8); showgray(sm_gradmagtools-threshold2 > 0); title(sprintf('threshold = %d', threshold2));


function threshold1_Callback(hObject, eventdata, handles)
% hObject    handle to threshold1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of threshold1 as text
%        str2double(get(hObject,'String')) returns contents of threshold1 as a double


% --- Executes during object creation, after setting all properties.
function threshold1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threshold1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function threshold2_Callback(hObject, eventdata, handles)
% hObject    handle to threshold2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of threshold2 as text
%        str2double(get(hObject,'String')) returns contents of threshold2 as a double


% --- Executes during object creation, after setting all properties.
function threshold2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threshold2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function smooth1_Callback(hObject, eventdata, handles)
% hObject    handle to smooth1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of smooth1 as text
%        str2double(get(hObject,'String')) returns contents of smooth1 as a double


% --- Executes during object creation, after setting all properties.
function smooth1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smooth1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in s4.
function s4_Callback(hObject, eventdata, handles)
% hObject    handle to s4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% [x y] = meshgrid(-5:5, -5:5);
% filter2(dxxxmask, x .^ 3, 'valid')
house = godthem256;

figure(1);
subplot(1,1,1);
scale = [0.0001 1.0 4.0 16 64];
for i = 1:5
    subplot(3,5,i);
    showgray(discgaussfft(house, scale(i))); title(sprintf('scale = %d', scale(i)));
    subplot(3,5,i+5);
    contour(Lvvtilde(discgaussfft(house, scale(i)), 'same'), [0 0]);
    axis('image');
    axis('ij');
    subplot(3,5,i+10);
    showgray(Lvvvtilde(discgaussfft(house, scale(i)), 'same') < 0);
    axis('image');
    axis('ij');
end
