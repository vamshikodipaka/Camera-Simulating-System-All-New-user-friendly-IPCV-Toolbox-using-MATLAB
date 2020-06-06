function varargout = Main_VP(varargin)
% MAIN_VP MATLAB code for Main_VP.fig
%      MAIN_VP, by itself, creates a new MAIN_VP or raises the existing
%      singleton*.
%
%      H = MAIN_VP returns the handle to a new MAIN_VP or the handle to
%      the existing singleton*.
%
%      MAIN_VP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_VP.M with the given input arguments.
%
%      MAIN_VP('Property','Value',...) creates a new MAIN_VP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_VP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_VP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main_VP

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Main_VP_OpeningFcn, ...
    'gui_OutputFcn',  @Main_VP_OutputFcn, ...
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


% --- Executes just before Main_VP is made visible.
function Main_VP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main_VP (see VARARGIN)

% Choose default command line output for Main_VP
handles.output = hObject;
set(handles.map1,'visible', 'off');
set(handles.map2,'visible', 'off');
%to clear x,y ticklabels in axes handles
axes(handles.axes1);
set(gca,'XtickLabel',[],'YtickLabel',[]);

%to set axes handles not to show ticks on axes
axes(handles.axes2);
set(gca,'XtickLabel',[],'YtickLabel',[]);

global Lmks LmkGraphics Wpts WptGraphics DefaultText AxisDim RunTime ...
    Obstacles ObstaclesMidpoint World

World = [];

Lmks = [];

LmkGraphics = line(...
    'parent',handles.axes1, ...
    'linestyle','none', ...
    'marker','+', ...
    'color','b', ...
    'xdata',[], ...
    'ydata',[]);

Wpts = [];

WptGraphics = line(...
    'parent',handles.axes1, ...
    'marker','o', ...
    'color','r', ...
    'xdata',[], ...
    'ydata',[]);

Obstacles = [];
ObstaclesMidpoint = [];

DefaultText = 'Select a command...';
AxisDim = 10;
%set(handles.mainAxes, 'XLim', [-AxisDim,AxisDim], 'YLim', [-AxisDim,AxisDim]);
axes(handles.axes1)
axis([-AxisDim AxisDim -AxisDim AxisDim])
axis square

set(handles.ColorSpace_radio, 'value', 0);
set(handles.Hist_radio, 'value', 0);
set(handles.Morph_radio, 'value', 0);


set(handles.uibuttongroup_gauss, 'visible', 'off');
set(handles.uibuttongroup_median, 'visible', 'off');
set(handles.uibuttongroup_pad, 'visible', 'off');
set(handles.uibuttongroup_track,'visible','off');
set(handles.uibuttongroup_slam,'visible','off');
set(handles.ColSpace_uibuttongroup, 'visible', 'off');
set(handles.Hist_buttongroup, 'visible', 'off');
set(handles.Morph_uibuttongroup, 'visible', 'off');

set(handles.Basic_uibuttongroup,'visible','off');
set(handles.EdgLine_uibuttongroup,'visible','off');
set(handles.uibuttongroup_tab3,'visible','off');
set(handles.Feat_uibuttongroup,'visible','off');

set(handles.CC_uibuttongroup,'visible','off');

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes Main_VP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main_VP_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Reset_pushbutton.
function Reset_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Reset_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Load_pushbutton.
function Load_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Load_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Function to get image
[filename, pathname] = uigetfile({'*.jpg;*.tif;*.bmp;*.jpeg;*.png;*.gif','All Image Files';'*.*','All Files'}, 'Select an Image');
if isnumeric(filename)
    return
end
fileName = fullfile(pathname, filename);

% read image
handles.img = imread(fileName);

axes(handles.axes1);
imshow(handles.img);

guidata(hObject, handles);

% --- Executes on button press in Image_radio.
function Image_radio_Callback(hObject, eventdata, handles)
% hObject    handle to Image_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Image_radio


% --- Executes on button press in Video_radio.
function Video_radio_Callback(hObject, eventdata, handles)
% hObject    handle to Video_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Video_radio



% --- Executes on button press in Save_pushbutton.
function Save_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Save_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imgout = handles.axes2;
[a b] =uiputfile();
filename = strcat(b,a);
imwrite(imgout,filename);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in Filter_popupmenu.
function Filter_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to Filter_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value= get(handles.Filter_popupmenu,'value');
set(handles.LPF_uibuttongroup, 'visible', 'off');
set(handles.HPF_uibuttongroup, 'visible', 'off');
set(handles.Noise_uibuttongroup, 'visible', 'off');
switch value
    case 1
        set(handles.LPF_uibuttongroup, 'visible', 'on');
    case 2
        set(handles.HPF_uibuttongroup, 'visible', 'on');
        set(handles.HPF_uibuttongroup,'position',get(handles.LPF_uibuttongroup,'position'));
        
    case 3
        set(handles.Noise_uibuttongroup, 'visible', 'on');
        set(handles.Noise_uibuttongroup,'position',get(handles.LPF_uibuttongroup,'position'));
        
    otherwise
end
set(handles.Filter_popupmenu,'position',get(handles.EdgLine_popupmenu,'position'));


% a= get(handles.Filter_popupmenu, 'value')
% if (a==1)
%     set(handles.LPF_uibuttongroup, 'visible', 'on')
% else
%     set(handles.HPF_uibuttongroup, 'visible', 'on')
% end



% Hints: contents = cellstr(get(hObject,'String')) returns Filter_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Filter_popupmenu


% --- Executes during object creation, after setting all properties.
function Filter_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Filter_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Basic_pushbutton.
function Basic_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Basic_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Basic_uibuttongroup,'visible','on');
set(handles.EdgLine_uibuttongroup,'visible','off');
set(handles.uibuttongroup_tab3,'visible','off');
set(handles.Feat_uibuttongroup,'visible','off');
set(handles.CC_uibuttongroup,'visible','off');
set(handles.uibuttongroup_track,'visible','off');
set(handles.uibuttongroup_slam,'visible','off');


% --- Executes on button press in Edg_Line_pushbutton.
function Edg_Line_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Edg_Line_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Edgdet_uibuttongroup, 'visible', 'off');
set(handles.LinDet_uibuttongroup, 'visible', 'off');
set(handles.CircDet_uibuttongroup, 'visible', 'off');
set(handles.uibuttongroup_track,'visible','off');
set(handles.uibuttongroup_slam,'visible','off');
set(handles.EdgLine_uibuttongroup,'visible','on');
set(handles.Basic_uibuttongroup,'visible','off');
set(handles.uibuttongroup_tab3,'visible','off');
set(handles.Feat_uibuttongroup,'visible','off');
set(handles.CC_uibuttongroup,'visible','off');
set(handles.EdgLine_uibuttongroup,'position',get(handles.Basic_uibuttongroup,'position'));


% --- Executes on button press in Filter_pushbutton.
function Filter_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Filter_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uibuttongroup_basic, 'visible', 'off');
set(handles.uibuttongroup_edge, 'visible', 'off');
set(handles.uibuttongroup_track,'visible','off');
set(handles.uibuttongroup_slam,'visible','off');
set(handles.uibuttongroup_gauss, 'visible', 'off');
set(handles.uibuttongroup_median, 'visible', 'off');
set(handles.uibuttongroup_pad, 'visible', 'off');

set(handles.radiobutton_efilter, 'Value', 0);
set(handles.radiobutton_basic, 'Value', 0);

set(handles.uibuttongroup_tab3,'visible','on');
set(handles.Basic_uibuttongroup,'visible','off');
set(handles.EdgLine_uibuttongroup,'visible','off');
set(handles.Feat_uibuttongroup,'visible','off');
set(handles.CC_uibuttongroup,'visible','off');
set(handles.uibuttongroup_tab3,'position',get(handles.Basic_uibuttongroup,'position'));



% --- Executes on button press in FeatMatch_pushbutton.
function FeatMatch_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to FeatMatch_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup_detection, 'visible','off');
set(handles.uibuttongroup_stich, 'visible','off');
set(handles.uibuttongroup_slam,'visible','off');
set(handles.Feat_uibuttongroup,'visible','on');
set(handles.uibuttongroup_feature_match,'visible','off');
set(handles.uibuttongroup_feature_ext,'visible','off');
set(handles.radiobutton_det, 'Value', 0);
set(handles.radiobutton_match, 'Value', 0);
set(handles.Basic_uibuttongroup,'visible','off');
set(handles.EdgLine_uibuttongroup,'visible','off');
set(handles.uibuttongroup_tab3,'visible','off');
set(handles.CC_uibuttongroup,'visible','off');
set(handles.uibuttongroup_track,'visible','off');
set(handles.Feat_uibuttongroup,'position',get(handles.Basic_uibuttongroup,'position'));


% --- Executes on button press in pushbutton_tracking.
function pushbutton_tracking_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_tracking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%set(handles.uibuttongroup_detection, 'visible','off');
set(handles.Feat_uibuttongroup,'visible','off');
set(handles.uibuttongroup_track,'visible','on');
set(handles.uibuttongroup_feature_match,'visible','off');
set(handles.uibuttongroup_feature_ext,'visible','off');
set(handles.Basic_uibuttongroup,'visible','off');
set(handles.EdgLine_uibuttongroup,'visible','off');
set(handles.uibuttongroup_tab3,'visible','off');
set(handles.CC_uibuttongroup,'visible','off');
set(handles.uibuttongroup_slam,'visible','off');
set(handles.radiobutton_tr_mv, 'Value', 0);
set(handles.radiobutton_dt_fc, 'Value', 0);
set(handles.radiobuttonobj_dt, 'Value', 0);

set(handles.uibuttongroup_det_obj, 'visible','off');
set(handles.uibuttongroup_track1, 'visible','off');
set(handles.uibuttongroupdet_fc, 'visible','off');

set(handles.uibuttongroup_track,'position',get(handles.Basic_uibuttongroup,'position'));


% --- Executes on button press in Calib_pushbutton.
function Calib_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Calib_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.CC_uibuttongroup,'visible','on');
set(handles.uibuttongroup_slam,'visible','off');
set(handles.uibuttongroup_3d,'visible','off');
set(handles.uibuttongroup56,'visible','off');
set(handles.Basic_uibuttongroup,'visible','off');
set(handles.EdgLine_uibuttongroup,'visible','off');
set(handles.uibuttongroup_tab3,'visible','off');
set(handles.Feat_uibuttongroup,'visible','off');
set(handles.uibuttongroup_track,'visible','off');
set(handles.CC_uibuttongroup,'position',get(handles.Basic_uibuttongroup,'position'));



function HP_edit_Callback(hObject, eventdata, handles)
% hObject    handle to HP_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
edit=get(hObject, 'string');
set(hObject.HP_slider, 'value', 'str2num');
guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of HP_edit as text
%        (get(hObject,'String')) returns contents of HP_edit as a double


% --- Executes during object creation, after setting all properties.
function HP_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HP_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function HP_slider_Callback(hObject, eventdata, handles)
% hObject    handle to HP_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider=get(hObject, 'value');
set(handles.HP_edit ,'string', num2str(slider));
guidata(hObject, handles);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function HP_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HP_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function LP_edit_Callback(hObject, eventdata, handles)
% hObject    handle to LP_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
edit=get(hObject, 'string');
set(hObject.LP_slider, 'value', 'str2num');
guidata(hObject, handles);



% Hints: get(hObject,'String') returns contents of LP_edit as text
%        (get(hObject,'String')) returns contents of LP_edit as a double


% --- Executes during object creation, after setting all properties.
function LP_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LP_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function LP_slider_Callback(hObject, eventdata, handles)
% hObject    handle to LP_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider=get(hObject, 'value');
set(handles.LP_edit ,'string', num2str(slider));
guidata(hObject, handles);


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function LP_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LP_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in FeatExtract_popupmenu.
function FeatExtract_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to FeatExtract_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = get(handles.FeatExtract_popupmenu,'Value')
switch contents
    case 1
        set(handles.Surf_uibuttongroup,'visible','on');
        
end

% Hints: contents = cellstr(get(hObject,'String')) returns FeatExtract_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FeatExtract_popupmenu


% --- Executes during object creation, after setting all properties.
function FeatExtract_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FeatExtract_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        (get(hObject,'String')) returns contents of edit1 as a double


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


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Dilate_pushbutton.
function Dilate_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Dilate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

f = str2double(get(handles.Morph_edit,'String'));
H=rgb2gray(handles.img);
se14 = offsetstrel('ball',f,f);
dilateI = imdilate(H,se14);
axes(handles.axes2)
imshow(dilateI);
guidata(hObject,handles);

% --- Executes on button press in Erode_pushbutton.
function Erode_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Erode_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = str2double(get(handles.Morph_edit,'String'));
H=rgb2gray(handles.img);
se14 = offsetstrel('ball',f,f);
erodedI = imerode(H,se14);
axes(handles.axes2)
imshow(erodedI);
guidata(hObject,handles);

% --- Executes on button press in Open_pushbutton.
function Open_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Open_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = str2double(get(handles.Morph_edit,'String'));
H=rgb2gray(handles.img);
se11 = strel('disk',f);
openBW = imopen(H,se11);
axes(handles.axes2)
imshow(openBW);
guidata(hObject,handles);

% --- Executes on button press in Close_pushbutton.
function Close_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Close_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = str2double(get(handles.Morph_edit,'String'));
H=rgb2gray(handles.img);
se11 = strel('disk',f);
closeBW = imclose(H,se11);
axes(handles.axes2)
imshow(closeBW);
guidata(hObject,handles);


function Morph_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Morph_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Morph_edit as text
%        (get(hObject,'String')) returns contents of Morph_edit as a double


% --- Executes during object creation, after setting all properties.
function Morph_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Morph_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Dis_pushbutton.
function Dis_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Dis_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imhist(handles.img);
axes(handles.axes2)
guidata(hObject,handles);



% --- Executes on button press in Equal_pushbutton.
function Equal_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Equal_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
J=histeq(handles.img);
axes(handles.axes2)
imshow(J);
guidata(hObject,handles);


% --- Executes on button press in RGB2gray.
function RGB2gray_Callback(hObject, eventdata, handles)
% hObject    handle to RGB2gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
H=rgb2gray(handles.img);
axes(handles.axes2), imshow(H);
guidata(hObject,handles);

% --- Executes on button press in RGB2Ycbcr.
function RGB2Ycbcr_Callback(hObject, eventdata, handles)
% hObject    handle to RGB2Ycbcr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
H=rgb2ycbcr(handles.img);
axes(handles.axes2), imshow(H);
guidata(hObject,handles);

% --- Executes on button press in RGB2HSV.
function RGB2HSV_Callback(hObject, eventdata, handles)
% hObject    handle to RGB2HSV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
H=rgb2hsv(handles.img);
axes(handles.axes2)
imshow(H);
guidata(hObject,handles);

% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Noise_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Noise_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
edit=get(hObject, 'string');
set(hObject.slider3, 'value', 'str2num');
guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of Noise_edit as text
%        (get(hObject,'String')) returns contents of Noise_edit as a double


% --- Executes during object creation, after setting all properties.
function Noise_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Noise_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Noise_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Noise_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider=get(hObject, 'value');
set(handles.Noise_edit ,'string', num2str(slider));
guidata(hObject, handles);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Noise_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Noise_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in Contour_popupmenu.
function Contour_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to Contour_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Contour_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Contour_popupmenu


% --- Executes during object creation, after setting all properties.
function Contour_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Contour_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in EdgLine_popupmenu.
function EdgLine_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to EdgLine_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value= get(handles.EdgLine_popupmenu,'value');
set(handles.Edgdet_uibuttongroup, 'visible', 'off');
set(handles.LinDet_uibuttongroup, 'visible', 'off');
set(handles.CircDet_uibuttongroup, 'visible', 'off');
switch value
    case 2
        set(handles.Edgdet_uibuttongroup, 'visible', 'on');
    case 3
        set(handles.LinDet_uibuttongroup, 'visible', 'on');
        set(handles.LinDet_uibuttongroup,'position',get(handles.Edgdet_uibuttongroup,'position'));
        
    case 4
        set(handles.CircDet_uibuttongroup, 'visible', 'on');
        set(handles.CircDet_uibuttongroup,'position',get(handles.Edgdet_uibuttongroup,'position'));
        
    otherwise
end

% Hints: contents = cellstr(get(hObject,'String')) returns EdgLine_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from EdgLine_popupmenu


% --- Executes during object creation, after setting all properties.
function EdgLine_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EdgLine_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LinDetThresh_edit_Callback(hObject, eventdata, handles)
% hObject    handle to LinDetThresh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LinDetThresh_edit as text
%        (get(hObject,'String')) returns contents of LinDetThresh_edit as a double


% --- Executes during object creation, after setting all properties.
function LinDetThresh_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LinDetThresh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EdgDetThresh_edit_Callback(hObject, eventdata, handles)
% hObject    handle to EdgDetThresh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EdgDetThresh_edit as text
%        (get(hObject,'String')) returns contents of EdgDetThresh_edit as a double


% --- Executes during object creation, after setting all properties.
function EdgDetThresh_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EdgDetThresh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FeatExtThresh_edit_Callback(hObject, eventdata, handles)
% hObject    handle to FeatExtThresh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FeatExtThresh_edit as text
%        (get(hObject,'String')) returns contents of FeatExtThresh_edit as a double


% --- Executes during object creation, after setting all properties.
function FeatExtThresh_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FeatExtThresh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FeatExtNumFeat_edit_Callback(hObject, eventdata, handles)
% hObject    handle to FeatExtNumFeat_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FeatExtNumFeat_edit as text
%        (get(hObject,'String')) returns contents of FeatExtNumFeat_edit as a double


% --- Executes during object creation, after setting all properties.
function FeatExtNumFeat_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FeatExtNumFeat_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Load1FeatMatch_pushbutton.
function Load1FeatMatch_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Load1FeatMatch_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.jpg;*.tif;*.bmp;*.jpeg;*.png;*.gif','All Image Files';'*.*','All Files'}, 'Select an Image');
fileName = fullfile(pathname, filename);

% read image
img = imread(fileName);

axes(handles.axes1);
imshow(img);

handles.img = img;
guidata(hObject, handles);

% set(handles.Apply_pushbutton,'Enable','on'); % set process button vissibility on


% --- Executes on button press in Load2FeatMatch_pushbutton.
function Load2FeatMatch_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Load2FeatMatch_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.jpg;*.tif;*.bmp;*.jpeg;*.png;*.gif','All Image Files';'*.*','All Files'}, 'Select an Image');
fileName = fullfile(pathname, filename);

% read image
img = imread(fileName);

axes(handles.axes1);
imshow(img);

handles.img = img;
guidata(hObject, handles);



% --- Executes on button press in MatchFeat_pushbutton.
function MatchFeat_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to MatchFeat_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        (get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        (get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        (get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Logo_pushbutton.
function Logo_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Logo_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%make a duplicate of image
img_out = img;

% add logo at bottom right
img_out(end-rows+1:end,end-cols+1:end) = alphaResize.*double(img_logo) + ...
    (1-alphaResize).*double(img_out(end-rows+1:end,end-cols+1:end));

% show output image
axes(handles.axes2);
imshow(img_out);
handles.img_out = img_out; guidata(hObject,handles);



% --- Executes on button press in pushbutton37.
function pushbutton37_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Hist_radio.
function Hist_radio_Callback(hObject, eventdata, handles)
% hObject    handle to Hist_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ColSpace_uibuttongroup, 'visible', 'off');
set(handles.Hist_buttongroup, 'visible', 'on');
set(handles.Morph_uibuttongroup, 'visible', 'off');

set(handles.ColorSpace_radio, 'value', 0);
set(handles.Hist_radio, 'value', 1);
set(handles.Morph_radio, 'value', 0);
set(handles.Hist_buttongroup,'position',get(handles.ColSpace_uibuttongroup,'position'));


% Hint: get(hObject,'Value') returns toggle state of Hist_radio


% --- Executes on button press in ColorSpace_radio.
function ColorSpace_radio_Callback(hObject, eventdata, handles)
% hObject    handle to ColorSpace_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ColSpace_uibuttongroup, 'visible', 'on');
set(handles.Hist_buttongroup, 'visible', 'off');
set(handles.Morph_uibuttongroup, 'visible', 'off');

set(handles.ColorSpace_radio, 'value', 1);
set(handles.Hist_radio, 'value', 0);
set(handles.Morph_radio, 'value', 0);









% Hint: get(hObject,'Value') returns toggle state of ColorSpace_radio


% --- Executes on button press in Morph_radio.
function Morph_radio_Callback(hObject, eventdata, handles)
% hObject    handle to Morph_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ColSpace_uibuttongroup, 'visible', 'off');
set(handles.Hist_buttongroup, 'visible', 'off');
set(handles.Morph_uibuttongroup, 'visible', 'on');

set(handles.ColorSpace_radio, 'value', 0);
set(handles.Hist_radio, 'value', 0);
set(handles.Morph_radio, 'value', 1);
set(handles.Morph_uibuttongroup,'position',get(handles.ColSpace_uibuttongroup,'position'));


% --- Executes on button press in pushbuttonchecker.
function pushbuttonchecker_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonchecker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ask user to input checkerboard images
[names, path] = uigetfile('*.*','Select checkerboard images', 'MultiSelect', 'on');
% % return from this call, if no file is selected
if isnumeric(names)
    return
end

% % convert char to cell, if only one file is selected
if ~iscellstr(names)
    names = cellstr(names);
end
image_count = length(names); %total number of images

%let's make an array of filenames
for i = 1 : image_count
    current_file_name = strcat(path, names{i});
    handles.chk_images{i} = current_file_name;
end
guidata(hObject,handles); %% to save data in global structure "handles"


% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name, path] = uigetfile('*.*','Select image 1', 'MultiSelect', 'off');
% % return from this call, if no file is selected
if isnumeric(name)
    return
end

filename = strcat(path, name);
I = imread(filename);
handles.img1 = undistortImage(I, handles.cameraParams);
guidata(hObject,handles); %% to save data in global structure "handles"

% --- Executes on button press in pushbutton40.
function pushbutton40_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name, path] = uigetfile('*.*','Select image 1', 'MultiSelect', 'off');
% % return from this call, if no file is selected
if isnumeric(name)
    return
end

filename = strcat(path, name);
I = imread(filename);
%let's undistort the image
handles.img2 = undistortImage(I, handles.cameraParams);

guidata(hObject,handles); %% to save data in global structure "handles"

% --- Executes on button press in pushbutton_recons.
function pushbutton_recons_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_recons (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I1 = handles.img1;
I2 = handles.img2;
cameraParams = handles.cameraParams;

% Detect feature points
imagePoints1 = detectMinEigenFeatures(rgb2gray(I1), 'MinQuality', 0.1);

% Visualize detected points
figure
imshow(I1, 'InitialMagnification', 50);
title('150 Strongest Corners from the First Image');
hold on
plot(selectStrongest(imagePoints1, 150));

% Create the point tracker
tracker = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 5);

% Initialize the point tracker
imagePoints1 = imagePoints1.Location;
initialize(tracker, imagePoints1, I1);

% Track the points
[imagePoints2, validIdx] = step(tracker, I2);
matchedPoints1 = imagePoints1(validIdx, :);
matchedPoints2 = imagePoints2(validIdx, :);

% Visualize correspondences
figure
showMatchedFeatures(I1, I2, matchedPoints1, matchedPoints2);
title('Tracked Features');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Estimate the fundamental matrix
[E, epipolarInliers] = estimateEssentialMatrix(...
    matchedPoints1, matchedPoints2, cameraParams, 'Confidence', 99.99);

% Find epipolar inliers
inlierPoints1 = matchedPoints1(epipolarInliers, :);
inlierPoints2 = matchedPoints2(epipolarInliers, :);

% Display inlier matches
figure
showMatchedFeatures(I1, I2, inlierPoints1, inlierPoints2);
title('Epipolar Inliers');

[orient, loc] = relativeCameraPose(E, cameraParams, inlierPoints1, inlierPoints2);

% Detect dense feature points. Use an ROI to exclude points close to the
% image edges.
roi = [30, 30, size(I1, 2) - 30, size(I1, 1) - 30];
imagePoints1 = detectMinEigenFeatures(rgb2gray(I1), 'ROI', roi, ...
    'MinQuality', 0.001);

% Create the point tracker
tracker = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 5);

% Initialize the point tracker
imagePoints1 = imagePoints1.Location;
initialize(tracker, imagePoints1, I1);

% Track the points
[imagePoints2, validIdx] = step(tracker, I2);
matchedPoints1 = imagePoints1(validIdx, :);
matchedPoints2 = imagePoints2(validIdx, :);

% Compute the camera matrices for each position of the camera
% The first camera is at the origin looking along the Z-axis. Thus, its
% rotation matrix is identity, and its translation vector is 0.
camMatrix1 = cameraMatrix(cameraParams, eye(3), [0 0 0]);

% Compute extrinsics of the second camera
[R, t] = cameraPoseToExtrinsics(orient, loc);
camMatrix2 = cameraMatrix(cameraParams, R, t);

% Compute the 3-D points
points3D = triangulate(matchedPoints1, matchedPoints2, camMatrix1, camMatrix2);

% Get the color of each reconstructed point
numPixels = size(I1, 1) * size(I1, 2);
allColors = reshape(I1, [numPixels, 3]);
colorIdx = sub2ind([size(I1, 1), size(I1, 2)], round(matchedPoints1(:,2)), ...
    round(matchedPoints1(:, 1)));
color = allColors(colorIdx, :);

% Create the point cloud
ptCloud = pointCloud(points3D, 'Color', color);
% Display the 3-D Point Cloud
% Use the plotCamera function to visualize the locations and orientations of the camera, and the pcshow function to visualize the point cloud.

% Visualize the camera locations and orientations
cameraSize = 0.3;
figure,
plotCamera('Size', cameraSize, 'Color', 'r', 'Label', '1', 'Opacity', 0);
hold on
grid on
plotCamera('Location', loc, 'Orientation', orient, 'Size', cameraSize, ...
    'Color', 'b', 'Label', '2', 'Opacity', 0);

% Visualize the point cloud
pcshow(ptCloud, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', ...
    'MarkerSize', 45);

% Rotate and zoom the plot
camorbit(0, -30);
camzoom(1.5);

% Label the axes
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis')

title('Up to Scale Reconstruction of the Scene');


% --- Executes on button press in pushbutton42.
function pushbutton42_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Fast_radio.
function Fast_radio_Callback(hObject, eventdata, handles)
% hObject    handle to Fast_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
firstcount = get(handles.FeatExtThresh_edit,'String');
firstcount = num2str(firstcount);
count = get(handles.FeatExtNumFeat_edit,'String');
count = num2str(count);

% Hint: get(hObject,'Value') returns toggle state of Fast_radio


% --- Executes on button press in Surf_radio.
function Surf_radio_Callback(hObject, eventdata, handles)
% hObject    handle to Surf_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

firstcount = get(handles.FeatExtThresh_edit,'String');
firstcount = num2str(firstcount);
count = get(handles.FeatExtNumFeat_edit,'String');
count = num2str(count);
% Hint: get(hObject,'Value') returns toggle state of Surf_radio

% --- Executes on button press in ApplyFeatExt_pushbutton.
function ApplyFeatExt_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyFeatExt_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_lines.
function pushbutton_lines_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_lines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% % % HOUGH TRANSFORMS ================


a = str2double(get(handles.LinDetThresh_edit, 'String'));

H = rgb2gray(handles.img);
BWh = edge(H,'canny');
[Ho,T,R] = hough(BWh);
%       figure, imshow(Ho,[],'XData',T,'YData',R,'InitialMagnification','fit');
%        xlabel('\theta'), ylabel('\rho');
%        axis on, axis normal, hold on;
P  = houghpeaks(Ho,5,'threshold',ceil(0.3*max(Ho(:))));
x = T(P(:,2));
y = R(P(:,1));
%        plot(x,y,'s','color','white');

% Find lines and plot them
lines = houghlines(BWh,T,R,P,'FillGap',5,'MinLength',a);
figure, imshow(H), hold on
max_len = 0;
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    
    % plot beginnings and ends of lines
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    
    % determine the endpoints of the longest line segment
    len = norm(lines(k).point1 - lines(k).point2);
    if ( len > max_len)
        max_len = len;
        xy_long = xy;
    end
end

% --- Executes on button press in pushbutton_detCirc.
function pushbutton_detCirc_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_detCirc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





% --- Executes on button press in BasicApply_pushbutton.
function BasicApply_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to BasicApply_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%if get(handles.Hist_radio, 'Value') == true;



% --- Executes on button press in BasicSave_pushbutton.
function BasicSave_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to BasicSave_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in EdgApply_pushbutton.
function EdgApply_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to EdgApply_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value = get(handles.popupmenu_edges,'value');

switch value
    case 2
        H=rgb2gray(handles.img);
        BW2 = edge(H,'canny');
        axes(handles.axes2); imshow(BW2);
        
    case 3
        H=rgb2gray(handles.img);
        BW2 = edge(H,'sobel');
        axes(handles.axes2); imshow(BW2);
        
    case 4
        H=rgb2gray(handles.img);
        BW2 = edge(H,'log');
        axes(handles.axes2); imshow(BW2);
        
    case 5
        H=rgb2gray(handles.img);
        BW2 = edge(H,'prewitt');
        axes(handles.axes2); imshow(BW2);
        
    case 6
        H=rgb2gray(handles.img);
        BW2 = edge(H,'Roberts');
        axes(handles.axes2); imshow(BW2);
        
    case 7
        H=rgb2gray(handles.img);
        BW2 = edge(H,'zerocross');
        axes(handles.axes2); imshow(BW2);
        
    otherwise
end

% --- Executes on button press in pushbutton48.
function pushbutton48_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton49.
function pushbutton49_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton49 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ApplyBasic_pushbutton.
function ApplyBasic_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyBasic_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in LoadBasic_pushbutton.
function LoadBasic_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to LoadBasic_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.jpg;*.tif;*.bmp;*.jpeg;*.png;*.gif','All Image Files';'*.*','All Files'}, 'Select an Image');
fileName = fullfile(pathname, filename);

% read image
handles.img = imread(fileName);

axes(handles.axes1);
imshow(handles.img);

guidata(hObject, handles);

% --- Executes on button press in LoadEdg_pushbutton.
function LoadEdg_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to LoadEdg_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton52.
function pushbutton52_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in LoadFilter_pushbutton.
function LoadFilter_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to LoadFilter_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.jpg;*.tif;*.bmp;*.jpeg;*.png;*.gif','All Image Files';'*.*','All Files'}, 'Select an Image');
fileName = fullfile(pathname, filename);

% read image
handles.img = imread(fileName);

axes(handles.axes1);
imshow(handles.img);

guidata(hObject, handles);


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%get the current image
F = getframe(handles.axes2);
I = frame2im(F);
%ask user where to save the JPEG images
[filename, foldername] = uiputfile('output.jpg');
complete_name = fullfile(foldername, filename);
imwrite(I, complete_name);


% --- Executes on selection change in popupmenu_edges.
function popupmenu_edges_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_edges (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_edges contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_edges


% --- Executes during object creation, after setting all properties.
function popupmenu_edges_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_edges (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_basic.
function popupmenu_basic_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_basic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_basic contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_basic

value= get(handles.popupmenu_basic,'value');

set(handles.uibuttongroup_gauss, 'visible', 'off');
set(handles.uibuttongroup_median, 'visible', 'off');
set(handles.uibuttongroup_pad, 'visible', 'off');

switch value
    case 2
        set(handles.uibuttongroup_gauss, 'visible', 'on');
        set(handles.uibuttongroup_median, 'visible', 'off');
        set(handles.uibuttongroup_pad, 'visible', 'off');
        
    case 3
        set(handles.uibuttongroup_gauss, 'visible', 'off');
        set(handles.uibuttongroup_median, 'visible', 'on');
        set(handles.uibuttongroup_pad, 'visible', 'off');
        set(handles.uibuttongroup_median,'position',get(handles.uibuttongroup_gauss,'position'));
        
    case 4
        set(handles.uibuttongroup_gauss, 'visible', 'off');
        set(handles.uibuttongroup_median, 'visible', 'on');
        set(handles.uibuttongroup_pad, 'visible', 'off');
        set(handles.uibuttongroup_median,'position',get(handles.uibuttongroup_gauss,'position'));
        
    case 5
        set(handles.uibuttongroup_gauss, 'visible', 'off');
        set(handles.uibuttongroup_median, 'visible', 'off');
        set(handles.uibuttongroup_pad, 'visible', 'on');
        set(handles.uibuttongroup_pad,'position',get(handles.uibuttongroup_gauss,'position'));
        
    otherwise
end

% --- Executes during object creation, after setting all properties.
function popupmenu_basic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_basic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Basic_filter.
function pushbutton_Basic_filter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Basic_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

I = handles.img;
value= get(handles.popupmenu_basic,'value');

switch value
    case 2
        sigma = str2double(get(handles.edit_sigma, 'String'));
        J = imgaussfilt(I, sigma);
        axes(handles.axes2); imshow(J,[]);
        
    case 3
        f = str2double(get(handles.edit19, 'String'));
        I = rgb2gray(I);
        J = medfilt2(I,[f f]);
        axes(handles.axes2); imshow(J,[]);
        
    case 4
        f = str2double(get(handles.edit19, 'String'));
        J = imboxfilt(I, f);
        axes(handles.axes2); imshow(J,[]);
        
    case 5
        p = str2double(get(handles.edit_pad, 'String'));
        J=padarray(I,[p p],0,'both');
        axes(handles.axes2); imshow(J,[]);
        
    otherwise
end



function edit_sigma_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sigma as text
%        str2double(get(hObject,'String')) returns contents of edit_sigma as a double


% --- Executes during object creation, after setting all properties.
function edit_sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pad_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pad as text
%        str2double(get(hObject,'String')) returns contents of edit_pad as a double


% --- Executes during object creation, after setting all properties.
function edit_pad_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton_basic.
function radiobutton_basic_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_basic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_basic

set(handles.uibuttongroup_basic, 'visible', 'on');
set(handles.uibuttongroup_edge, 'visible', 'off');


% --- Executes on button press in pushbutton_edge_res.
function pushbutton_edge_res_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_edge_res (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I = handles.img;
value= get(handles.popupmenu_edge,'value');

switch value
    case 2
        sigma = str2double(get(handles.edit23, 'String'))
        J = imbilatfilt(I, sigma);
        axes(handles.axes2); imshow(J,[]);
        
    case 3
        J = imdiffusefilt(I);
        axes(handles.axes2); imshow(J,[]);
        
    case 4
        J = imguidedfilter(I);
        axes(handles.axes2); imshow(J,[]);
        
    case 5
        [J,~] = imnlmfilt(I);
        axes(handles.axes2); imshow(J,[]);
        
    otherwise
end


% --- Executes on selection change in popupmenu_edge.
function popupmenu_edge_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_edge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_edge contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_edge
value= get(handles.popupmenu_edge,'value');

if value==2
    set(handles.uibuttongroup44, 'visible', 'on');
else
    set(handles.uibuttongroup44, 'visible', 'off');
    
end

% --- Executes during object creation, after setting all properties.
function popupmenu_edge_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_edge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton_efilter.
function radiobutton_efilter_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_efilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_efilter
set(handles.uibuttongroup_basic, 'visible', 'off');
set(handles.uibuttongroup_edge, 'visible', 'on');
set(handles.uibuttongroup_edge,'position',get(handles.uibuttongroup_basic,'position'));



% --- Executes on button press in radiobutton_det.
function radiobutton_det_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_det (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_det
handles.uibuttongroup_feature_ext.Visible = 'on';
handles.uibuttongroup_stich.Visible = 'off';
handles.uibuttongroup_feature_match.Visible = 'off';
handles.uibuttongroup_detection.Visible = 'off';
handles.uibuttongroup6.Visible = 'on';
set(handles.uibuttongroup_feature_ext,'position',get(handles.uibuttongroup_feature_match,'position'));

function edit_feat_Callback(hObject, eventdata, handles)
% hObject    handle to edit_feat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_feat as text
%        str2double(get(hObject,'String')) returns contents of edit_feat as a double


% --- Executes during object creation, after setting all properties.
function edit_feat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_feat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_feature.
function popupmenu_feature_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_feature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_feature contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_feature
value = get(handles.popupmenu_feature,'value');
switch value
    case 9
        handles.uibuttongroup_feature_match.Visible = 'off';
    otherwise
end

% --- Executes during object creation, after setting all properties.
function popupmenu_feature_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_feature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_load2.
function pushbutton_load2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[name, path] = uigetfile('*.*','Select an image to match features', 'MultiSelect', 'off');
% % return from this call, if no file is selected
if isnumeric(name)
    return
end
filename = char(strcat(path,name));
handles.org_img2 = imread(filename);
axes(handles.axes2); cla; imshow(handles.org_img2,[]);
guidata(hObject,handles); %% to save data in global structure "handles"


% --- Executes on button press in pushbutton_match.
function pushbutton_match_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_match (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value = get(handles.popupmenu_feature,'value');
I1 = rgb2gray(handles.img);
I2 = rgb2gray(handles.org_img2);
feature = str2double(get(handles.edit_feat,'String'));
switch value
    
    case 2
        %Detect features
        points1 = detectBRISKFeatures(I1);
        points2 = detectBRISKFeatures(I2);
        %find matched points
        [matchedPoints1,matchedPoints2] = giveMatchedPoints(I1,I2, points1, points2, feature);
        %Visualize candidate matches.
        figure, showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage');
        
    case 3
        %Detect features
        points1 = detectFASTFeatures(I1);
        points2 = detectFASTFeatures(I2);
        %find matched points
        [matchedPoints1,matchedPoints2] = giveMatchedPoints(I1,I2, points1, points2, feature);
        %Visualize candidate matches.
        figure, showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage');
        
    case 4
        %Detect features
        points1 = detectHarrisFeatures(I1);
        points2 = detectHarrisFeatures(I2);
        %find matched points
        [matchedPoints1,matchedPoints2] = giveMatchedPoints(I1,I2, points1, points2, feature);
        %Visualize candidate matches.
        figure, showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage');
        
    case 5
        %Detect features
        points1 = detectMinEigenFeatures(I1);
        points2 = detectMinEigenFeatures(I2);
        %find matched points
        [matchedPoints1,matchedPoints2] = giveMatchedPoints(I1,I2, points1, points2, feature);
        %Visualize candidate matches.
        figure, showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage');
        
    case 6
        %Detect features
        points1 = detectMSERFeatures(I1);
        points2 = detectMSERFeatures(I2);
        %find matched points
        [matchedPoints1,matchedPoints2] = giveMatchedPoints(I1,I2, points1, points2, feature);
        %Visualize candidate matches.
        figure, showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage');
        
    case 7
        %Detect features
        points1 = detectSURFFeatures(I1);
        points2 = detectSURFFeatures(I2);
        %find matched points
        [matchedPoints1,matchedPoints2] = giveMatchedPoints(I1,I2, points1, points2, feature);
        %Visualize candidate matches.
        figure, showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage');
        
    case 8
        %Detect features
        points1 = detectKAZEFeatures(I1);
        points2 = detectKAZEFeatures(I2);
        %find matched points
        [matchedPoints1,matchedPoints2] = giveMatchedPoints(I1,I2, points1, points2, feature);
        %Visualize candidate matches.
        figure, showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage');
        
    otherwise
end

% --- Executes on button press in pushbutton_detect.
function pushbutton_detect_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_detect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

value = get(handles.popupmenu_feature,'value');
%set(handles.edit_feat, 'enable', 'on')
copy_img = rgb2gray(handles.img);
axes(handles.axes2); imshow(copy_img); hold on;
feature = str2double(get(handles.edit_feat,'String'));
switch value
    
    case 2
        points = detectBRISKFeatures(copy_img);
        plot(points.selectStrongest(feature));
        
    case 3
        points = detectFASTFeatures(copy_img);
        plot(points.selectStrongest(feature));
        
    case 4
        points = detectHarrisFeatures(copy_img);
        plot(points.selectStrongest(feature));
        
    case 5
        points = detectMinEigenFeatures(copy_img);
        plot(points.selectStrongest(feature));
        
    case 6
        points = detectMSERFeatures(copy_img);
        plot(points);
        
    case 7
        points = detectSURFFeatures(copy_img);
        plot(points.selectStrongest(feature));
        
    case 8
        points = detectKAZEFeatures(copy_img);
        plot(points.selectStrongest(feature));
        
    case 9
        [~,hogVisualization] = extractHOGFeatures(copy_img);
        plot(hogVisualization);
        
    otherwise
end

% --- Executes on button press in radiobutton_match.
function radiobutton_match_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_match (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_match
handles.uibuttongroup_feature_ext.Visible = 'off';
handles.uibuttongroup_stich.Visible = 'off';
handles.uibuttongroup_feature_match.Visible = 'on';
handles.uibuttongroup_detection.Visible = 'off';
handles.uibuttongroup6.Visible = 'on';

% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1);cla reset;
set(gca,'XtickLabel',[],'YtickLabel',[]);

%to set axes handles not to show ticks on axes
axes(handles.axes2);cla reset;
set(gca,'XtickLabel',[],'YtickLabel',[]);


% --- Executes on button press in pushbutton_ref.
function pushbutton_ref_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name, path] = uigetfile('*.*','Select image 1', 'MultiSelect', 'off');
% % return from this call, if no file is selected
if isnumeric(name)
    return
end

filename = strcat(path, name);
handles.img1_obj_detection = rgb2gray(imread(filename));
guidata(hObject,handles); %% to save data in global structure "handles"

% --- Executes on button press in pushbutton_obj_detection.
function pushbutton_obj_detection_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_obj_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
refImage = handles.img1_obj_detection ;
sceneImage = rgb2gray(handles.img) ;

refPoints = detectSURFFeatures(refImage);
scenePoints = detectSURFFeatures(sceneImage);

[boxFeatures, refPoints] = extractFeatures(refImage, refPoints);
[sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);

refPairs = matchFeatures(boxFeatures, sceneFeatures);

matchedBoxPoints = refPoints(refPairs(:, 1), :);
matchedScenePoints = scenePoints(refPairs(:, 2), :);

[tform, inlierBoxPoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedBoxPoints, matchedScenePoints, 'affine');

boxPolygon = [1, 1;...                           % top-left
    size(refImage, 2), 1;...                 % top-right
    size(refImage, 2), size(refImage, 1);... % bottom-right
    1, size(refImage, 1);...                 % bottom-left
    1, 1];                   % top-left again to close the polygon

newBoxPolygon = transformPointsForward(tform, boxPolygon);

axes(handles.axes2);
imshow(sceneImage,[]);
hold on;
line(newBoxPolygon(:, 1), newBoxPolygon(:, 2), 'Color', 'y');
title('Detected Object');


% --- Executes on button press in radiobutton_obj_det.
function radiobutton_obj_det_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_obj_det (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_obj_det
handles.uibuttongroup_feature_ext.Visible = 'off';
handles.uibuttongroup_stich.Visible = 'off';
handles.uibuttongroup_feature_match.Visible = 'off';
handles.uibuttongroup_detection.Visible = 'on';
handles.uibuttongroup6.Visible = 'off';


% --- Executes on button press in CC_pushbutton.
function CC_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to CC_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%let's gather 2d image points

[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(handles.chk_images);
imageFileNames = handles.chk_images(imagesUsed);

I = imread(imageFileNames{1});
axes(handles.axes1);  imshow(I);
hold on;  plot(imagePoints(:,1,1),imagePoints(:,2,1),'ro');

I = imread(imageFileNames{2});
axes(handles.axes2);  imshow(I);
hold on;  plot(imagePoints(:,1,2),imagePoints(:,2,2),'ro');

% get the size of square from user in mm
squareSize = str2double(get(handles.CC_edit,'String'));

%get 3d world points
worldPoints = generateCheckerboardPoints(boardSize, squareSize);
% Calibrate the camera
handles.cameraParams = estimateCameraParameters(imagePoints, worldPoints);
f = msgbox('Calibration process completed');
guidata(hObject,handles); %% to save data in global structure "handles"


function CC_edit_Callback(hObject, eventdata, handles)
% hObject    handle to CC_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CC_edit as text
%        str2double(get(hObject,'String')) returns contents of CC_edit as a double


% --- Executes during object creation, after setting all properties.
function CC_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CC_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_epip.
function pushbutton_epip_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_epip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

I1 = handles.img1;
I2 = handles.img2;
cameraParams = handles.cameraParams;

% Detect feature points
imagePoints1 = detectMinEigenFeatures(rgb2gray(I1), 'MinQuality', 0.1);

% % Visualize detected points
% figure
% imshow(I1, 'InitialMagnification', 50);
% title('150 Strongest Corners from the First Image');
% hold on
% plot(selectStrongest(imagePoints1, 150));

% Create the point tracker
tracker = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 5);

% Initialize the point tracker
imagePoints1 = imagePoints1.Location;
initialize(tracker, imagePoints1, I1);

% Track the points
[imagePoints2, validIdx] = step(tracker, I2);
matchedPoints1 = imagePoints1(validIdx, :);
matchedPoints2 = imagePoints2(validIdx, :);

% % Visualize correspondences
% figure
% showMatchedFeatures(I1, I2, matchedPoints1, matchedPoints2);
% title('Tracked Features');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Estimate the fundamental matrix
% [fLMedS, inliers] = estimateEssentialMatrix(...
%     matchedPoints1, matchedPoints2, cameraParams, 'Confidence', 99.99);
%% test for epioplar line
[fLMedS, inliers] = estimateFundamentalMatrix(matchedPoints1,matchedPoints2,'NumTrials',2000);
%I1 = imread('C:\Users\pankaj\iCloudDrive\VIBOT-2018\Semester 2\Visual Perception\Shabeik\PAL\homo.jpeg');
figure;
subplot(121);
imshow(I1);
title('Inliers and Epipolar Lines in First Image'); hold on;
plot(matchedPoints1(inliers,1),matchedPoints1(inliers,2),'go')


epiLines = epipolarLine(fLMedS',matchedPoints2(inliers,:));
points = lineToBorderPoints(epiLines,size(I1));
line(points(:,[1,3])',points(:,[2,4])');

%I2 = imread('C:\Users\pankaj\iCloudDrive\VIBOT-2018\Semester 2\Visual Perception\Shabeik\PAL\homo2.jpeg');
subplot(122);
imshow(I2);
title('Inliers and Epipolar Lines in Second Image'); hold on;
plot(matchedPoints2(inliers,1),matchedPoints2(inliers,2),'go')

epiLines = epipolarLine(fLMedS,matchedPoints1(inliers,:));
points = lineToBorderPoints(epiLines,size(I2));
line(points(:,[1,3])',points(:,[2,4])');
truesize;



function edit_output_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output as text
%        str2double(get(hObject,'String')) returns contents of edit_output as a double


% --- Executes during object creation, after setting all properties.
function edit_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton_intr.
function pushbutton_intr_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_intr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a=num2cell(handles.cameraParams.IntrinsicMatrix');
%b= num2cell(a);
set(handles.uitable_output, 'Data', a)

% --- Executes on button press in pushbuttonextr.
function pushbuttonextr_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonextr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure,  showExtrinsics(handles.cameraParams);

function uitable_output_DeleteFcn(hObject,eventdata, handles)
% hObject    handle to pushbuttonextr (see GCBO)

% --- Executes on button press in pushbutton78.
function pushbutton78_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton78 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name, path] = uigetfile('*.mp4*','Select a video', 'MultiSelect', 'off');
% % return from this call, if no file is selected
if isnumeric(name)
    return
end

file_name = strcat(path, name);

save_path = uigetdir('Select Folder to save');

videoFReader = vision.VideoFileReader(file_name);
iter=1;
videoPlayer = vision.VideoPlayer;
while ~isDone(videoFReader)
   frame = step(videoFReader);
%    bbox = step(faceDetector, frame);
%    frame = insertShape(frame, 'Rectangle', bbox);
% current_file_name = strcat(save_path,'/',num2str(iter),'.jpg');
% imwrite(frame, current_file_name,'jpg');
% iter = iter+1;
   step(videoPlayer,frame);
end
release(videoFReader);
release(videoPlayer);




% --- Executes on button press in pushbutton_track.
function pushbutton_track_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_track (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Set up video reader and player
vidFReader = vision.VideoFileReader(handles.obj_vid,...
    'VideoOutputDataType','double');
%vidPlayer = vision.DeployableVideoPlayer;

%% Initialize tracking
img = step(vidFReader);
figure
imshow(img)
h = imrect;
wait(h);
[~,centLoc] = getLoc(h);

MotionModel = 'ConstantVelocity';
InitLoc = centLoc;
InitErr = 10 * ones(1,2);
MotionNoise = [20 20];
MeasurementNoise = 200;
kf = configureKalmanFilter(...
    MotionModel,...
    InitLoc,...
    InitErr,...
    MotionNoise,...
    MeasurementNoise);

%% Loop algorithm
idx = 1;
axes(handles.axes1);
while ~isDone(vidFReader)
    img = step(vidFReader);
    trackedLocation = predict(kf);
    out = insertShape(img,'circle',[trackedLocation 20],...
        'Color','green','LineWidth',5);
    
    % Find the ball
    [~,detectedLocation] = segmentBall(img,5000);
    if (~isempty(detectedLocation))
        % If ball is found, correct kalman filter
        trackedLocation = correct(kf,detectedLocation);
        out = insertShape(out,'circle',[trackedLocation 5],...
            'Color','blue','LineWidth',5);
    end
    
    %     step(vidPlayer,out);
    imshow(out);
    pos(idx,:) = trackedLocation;
    idx = idx+1;
    pause(0.1);
    
end

axes(handles.axes2); imshow(img)
hold on
plot(pos(:,1),pos(:,2),'rx-','LineWidth',2)

%% Clean up
%release(vidPlayer);
release(vidFReader);

% --- Executes on button press in pushbutton_vid_track.
function pushbutton_vid_track_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_vid_track (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name, path] = uigetfile('*.mp4*','Select a video', 'MultiSelect', 'off');
% % return from this call, if no file is selected
if isnumeric(name)
    return
end

handles.obj_vid = strcat(path, name);
guidata(hObject,handles); %% to save data in global structure "handles"


% --- Executes on button press in pushbutton_faces.
function pushbutton_faces_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_faces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
faceDetector = vision.CascadeObjectDetector();
videoFReader = vision.VideoFileReader(handles.obj_vid);
%videoPlayer = vision.VideoPlayer;
while ~isDone(videoFReader)
    frame = step(videoFReader);
    axes(handles.axes1), imshow(frame);
    bbox = step(faceDetector, frame);
    frame = insertShape(frame, 'Rectangle', bbox, 'LineWidth', 4);
    axes(handles.axes2), imshow(frame);
    %step(videoPlayer,frame);
end
release(videoFReader);
%release(videoPlayer);


% --- Executes on button press in pushbutton_obj_det.
function pushbutton_obj_det_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_obj_det (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

videoFReader = vision.VideoFileReader(handles.obj_vid);
object = handles.obj_trk;

refImage = rgb2gray(handles.obj_trk) ;
refPoints = detectSURFFeatures(refImage);
[boxFeatures, refPoints] = extractFeatures(refImage, refPoints);

while ~isDone(videoFReader)
   sceneImage = step(videoFReader);
   sceneImage = rgb2gray(sceneImage) ;
scenePoints = detectSURFFeatures(sceneImage);
[sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);
refPairs = matchFeatures(boxFeatures, sceneFeatures);

matchedBoxPoints = refPoints(refPairs(:, 1), :);
matchedScenePoints = scenePoints(refPairs(:, 2), :);

[tform, inlierBoxPoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedBoxPoints, matchedScenePoints, 'affine');

boxPolygon = [1, 1;...                           % top-left
    size(refImage, 2), 1;...                 % top-right
    size(refImage, 2), size(refImage, 1);... % bottom-right
    1, size(refImage, 1);...                 % bottom-left
    1, 1];                   % top-left again to close the polygon

newBoxPolygon = transformPointsForward(tform, boxPolygon);

axes(handles.axes2);
imshow(sceneImage,[]);
hold on;
line(newBoxPolygon(:, 1), newBoxPolygon(:, 2), 'Color', 'y');
end
release(videoFReader);


% --- Executes on button press in pushbutton_load_obj.
function pushbutton_load_obj_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_obj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name, path] = uigetfile('*.*','Select object', 'MultiSelect', 'off');
% % return from this call, if no file is selected
if isnumeric(name)
    return
end

filename = strcat(path, name);
handles.obj_trk = imread(filename);
axes(handles.axes1); imshow(handles.obj_trk);
guidata(hObject,handles); %% to save data in global structure "handles"


% --- Executes on button press in radiobutton_tr_mv.
function radiobutton_tr_mv_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_tr_mv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_tr_mv
set(handles.uibuttongroup_track1,'visible','on');
set(handles.uibuttongroup_det_obj,'visible','off');
set(handles.uibuttongroupdet_fc,'visible','off');
set(handles.uibuttongroup_track1,'position',get(handles.uibuttongroup_det_obj,'position'));



% --- Executes on button press in radiobutton_dt_fc.
function radiobutton_dt_fc_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_dt_fc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_dt_fc
set(handles.uibuttongroup_track1,'visible','off');
set(handles.uibuttongroup_det_obj,'visible','off');
set(handles.uibuttongroupdet_fc,'visible','on');
set(handles.uibuttongroupdet_fc,'position',get(handles.uibuttongroup_det_obj,'position'));


% --- Executes on button press in radiobuttonobj_dt.
function radiobuttonobj_dt_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonobj_dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonobj_dt
set(handles.uibuttongroup_track1,'visible','off');
set(handles.uibuttongroup_det_obj,'visible','on');
set(handles.uibuttongroupdet_fc,'visible','off');


% --- Executes on button press in pushbutton_stich.
function pushbutton_stich_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_stich (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stiched_image = imageStiching(handles.buildingScene);
axes(handles.axes2); imshow(stiched_image)

% --- Executes on button press in pushbutton_ld_st.
function pushbutton_ld_st_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ld_st (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stich_path = uigetdir('Select Folder of images needs to be stiched');
handles.buildingScene = imageDatastore(stich_path);
% Display images to be stitched
axes(handles.axes1); montage(handles.buildingScene.Files)
guidata(hObject,handles); %% to save data in global structure "handles"

% --- Executes on button press in radiobutton_stih.
function radiobutton_stih_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_stih (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_stih
handles.uibuttongroup_feature_ext.Visible = 'off';
handles.uibuttongroup_stich.Visible = 'on';
handles.uibuttongroup_feature_match.Visible = 'off';
handles.uibuttongroup_detection.Visible = 'off';
handles.uibuttongroup6.Visible = 'off';
set(handles.uibuttongroup_stich,'position',get(handles.uibuttongroup_detection,'position'));


% --- Executes on button press in pushbutton87.
function pushbutton87_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton87 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cam = webcam;
preview(handles.cam);
% axes(handles.axes1);
% while true
%     img = snapshot(handles.cam);
%     imshow(img)
% end
guidata(hObject,handles); %% to save data in global structure "handles"


% --- Executes on button press in pushbutton88.
function pushbutton88_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton88 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = snapshot(handles.cam);
axes(handles.axes2); imshow(img)


% --- Executes on button press in pushbutton89.
function pushbutton89_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton89 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton90.
function pushbutton90_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton90 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear('handles.cam');
guidata(hObject,handles); %% to save data in global structure "handles"


% --- Executes on button press in pushbutton_add_lnd.
function pushbutton_add_lnd_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_add_lnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Lmks AxisDim DefaultText
set(handles.helpBox, 'String', 'Click on the axes to place a landmark...')
clicked = 0;
while ~clicked
    [x,y]=ginputax(handles.axes1,1);
    if abs(x) < AxisDim && abs(y) < AxisDim
        Lmks = [Lmks [x;y]];
        axes(handles.axes1);
        hold on;
        plotItems(Lmks, 'landmarks');
        set(handles.helpBox, 'String', ...
            ['Landmark placed at:' char(10) ...
            '(' num2str(x) ', ' num2str(y) ')' char(10) DefaultText])
        clicked = 1;
    else
        set(handles.helpBox, 'String', ...
            'Landmark not placed! Click somewhere on the axes.')
    end
end



function plotItems(Items, ItemType)
global LmkGraphics WptGraphics
if strcmp(ItemType, 'landmarks')
    set(LmkGraphics, 'xdata', Items(1, :), 'ydata', Items(2, :))
elseif strcmp(ItemType, 'waypoints')
    set(WptGraphics, 'xdata', Items(1, :), 'ydata', Items(2, :))
end


% --- Executes on button press in pushbutton92.
function pushbutton92_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton92 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Lmks AxisDim DefaultText
set(handles.helpBox, 'String', 'Click a landmark to delete...')
clicked = 0;
while ~clicked
    if ~isempty(Lmks)
        p = ginputax(handles.axes1,1);
        if abs(p(1))<AxisDim && abs(p(2))<AxisDim
            i = nearestNeighbour(Lmks, p);
            % Remove nearest neighbour from Lmks
            lmk_deleted = Lmks(:,i);
            Lmks(:,i) = [];

            axes(handles.axes1);
            hold on
            plotItems(Lmks, 'landmarks');

            set(handles.helpBox, 'String', ...
                ['Landmark deleted at:' char(10) ...
                '(' num2str(lmk_deleted(1)) ', ' num2str(lmk_deleted(2)) ')' ...
                char(10) DefaultText])
            clicked = 1;
        else
            set(handles.helpBox, 'String', ...
                'No landmarks deleted! Click somewhere on the axes.')
        end
    else
        set(handles.helpBox, 'String', ...
            ['No landmarks to delete.' char(10) DefaultText])
        clicked = 1;
    end
end

function i = nearestNeighbour(Items, p)
diff2 = (Items(1,:)-p(1)).^2 + (Items(2,:)-p(2)).^2;
i= find(diff2 == min(diff2));
i= i(1);


% --- Executes on button press in pushbutton93.
function pushbutton93_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton93 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Wpts AxisDim DefaultText
set(handles.helpBox, 'String', 'Click on the axes to place a waypoint...')
clicked = 0;
while ~clicked
    [x,y]=ginputax(handles.axes1,1);
    if abs(x) < AxisDim && abs(y) < AxisDim
        Wpts = [Wpts [x;y]];
        axes(handles.axes1);
        %hold on
        plotItems(Wpts, 'waypoints');
        set(handles.helpBox, 'String', ...
            ['Waypoint placed at:' char(10) ...
            '(' num2str(x) ', ' num2str(y) ')' char(10) DefaultText])
        clicked = 1;
    else
        set(handles.helpBox, 'String', ...
            'Waypoint not placed! Click somewhere on the axes.')
    end
end


% --- Executes on button press in pushbutton94.
function pushbutton94_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton94 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Wpts AxisDim DefaultText
set(handles.helpBox, 'String', 'Click a waypoint to delete...')
clicked = 0;
while ~clicked
    if ~isempty(Wpts)
        p = ginputax(handles.axes1,1);
        if abs(p(1))<AxisDim && abs(p(2))<AxisDim
            i = nearestNeighbour(Wpts, p);
            % Remove nearest neighbour from Lmks
            wpt_deleted = Wpts(:,i);
            Wpts(:,i) = [];
            
            axes(handles.axes1);
            hold on
            plotItems(Wpts, 'waypoints');

            set(handles.helpBox, 'String', ...
                ['Waypoint deleted at:' char(10) ...
                '(' num2str(wpt_deleted(1)) ', ' num2str(wpt_deleted(2)) ')' ...
                char(10) DefaultText])
            clicked = 1;
        else
            set(handles.helpBox, 'String', ...
                'No waypoints deleted! Click somewhere on the axes.')
        end
    else
        set(handles.helpBox, 'String', ...
            ['No waypoints to delete.' char(10) DefaultText])
        clicked = 1;
    end
end


% --- Executes on button press in pushbutton95.
function pushbutton95_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton95 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Obstacles ObstaclesMidpoint DefaultText AxisDim

velX = str2double(get(handles.obsVelX, 'String'));
velY = str2double(get(handles.obsVelY, 'String'));

if isempty(Obstacles)
    Obstacles = Obstacle([], [velX; velY]);
else
    Obstacles(end+1) = Obstacle([], [velX; velY]);
end

vertices = str2double(get(handles.obsVertices, 'String'));
numObstacles = length(Obstacles);

set(handles.helpBox, 'String', ['Adding obstacle with' char(10) ...
    num2str(vertices) ' vertices.' char(10) DefaultText])

i = 1;
while i <= vertices
    p = ginputax(handles.axes1, 1);
    if abs(p(1))<AxisDim && abs(p(2))<AxisDim
        Obstacles(numObstacles).vertices(:, end+1) = p;
        Obstacles(numObstacles).plot(handles.axes1);
        i = i + 1;
    end
end

ObstaclesMidpoint(:, numObstacles) = [mean(Obstacles(numObstacles).vertices(1,:)); ...
    mean(Obstacles(numObstacles).vertices(2,:))];

set(handles.helpBox, 'String', ['Obstacle added!' char(10) DefaultText])



function obsVertices_Callback(hObject, eventdata, handles)
% hObject    handle to obsVertices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of obsVertices as text
%        str2double(get(hObject,'String')) returns contents of obsVertices as a double


% --- Executes during object creation, after setting all properties.
function obsVertices_CreateFcn(hObject, eventdata, handles)
% hObject    handle to obsVertices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function obsVelX_Callback(hObject, eventdata, handles)
% hObject    handle to obsVelX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of obsVelX as text
%        str2double(get(hObject,'String')) returns contents of obsVelX as a double


% --- Executes during object creation, after setting all properties.
function obsVelX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to obsVelX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function obsVelY_Callback(hObject, eventdata, handles)
% hObject    handle to obsVelY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of obsVelY as text
%        str2double(get(hObject,'String')) returns contents of obsVelY as a double


% --- Executes during object creation, after setting all properties.
function obsVelY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to obsVelY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton96.
function pushbutton96_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton96 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Obstacles ObstaclesMidpoint AxisDim DefaultText

set(handles.helpBox, 'String', 'Click an obstacle to delete...')
clicked = 0;
while ~clicked
    if ~isempty(Obstacles)
        p = ginputax(handles.axes1,1);
        if abs(p(1))<AxisDim && abs(p(2))<AxisDim
            i = nearestNeighbour(ObstaclesMidpoint, p);
            % Remove nearest obstacle
            Obstacles(i).vertices = [];
            Obstacles(i).plot(handles.axes1);
            Obstacles(i) = [];
            ObstaclesMidpoint(:, i) = [];

            axes(handles.axes1);

            set(handles.helpBox, 'String', ['Obstacle deleted!' char(10) ...
                DefaultText])
            
            clicked = 1;
        else
            set(handles.helpBox, 'String', ...
                'No obstacles deleted! Click somewhere on the axes.')
        end
    else
        set(handles.helpBox, 'String', ...
            ['No obstacles to delete.' char(10) DefaultText])
        clicked = 1;
    end
end


% --- Executes on button press in pushbutton97.
function pushbutton97_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton97 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Lmks Wpts DefaultText AxisDim Obstacles World Map1 Map2
if isempty(Lmks) || isempty(Wpts) || isempty(Obstacles)
    errordlg(['The map must consist of at least 1 landmark,' ...
        '1 waypoint and 1 obstacle'],'BOOM!')
else
    set(handles.helpBox, 'String', 'Executing SLAM...')
    World = ekfSLAM(handles, AxisDim, Lmks, Wpts, Obstacles);
    set(handles.helpBox, 'String', ['SLAM simulation complete!' char(10) ...
        DefaultText])
    Map1 = World.gridmap_greyscale;
    Map2 = World.gridmap;
end


% --- Executes on button press in pushbutton_slam.
function pushbutton_slam_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_slam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.CC_uibuttongroup,'visible','off');
set(handles.uibuttongroup_slam,'visible','on');

set(handles.Basic_uibuttongroup,'visible','off');
set(handles.EdgLine_uibuttongroup,'visible','off');
set(handles.uibuttongroup_tab3,'visible','off');
set(handles.Feat_uibuttongroup,'visible','off');
set(handles.uibuttongroup_track,'visible','off');
set(handles.uibuttongroup_slam,'position',get(handles.Basic_uibuttongroup,'position'));


% --- Executes on button press in radiobutton_3d.
function radiobutton_3d_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_3d
set(handles.uibuttongroup_3d,'visible','on');
set(handles.uibuttongroup56,'visible','off');


% --- Executes on button press in radiobutton_epipl.
function radiobutton_epipl_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_epipl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_epipl
set(handles.uibuttongroup_3d,'visible','off');
set(handles.uibuttongroup56,'visible','on');
set(handles.uibuttongroup56,'position',get(handles.uibuttongroup_3d,'position'));
