function varargout = RSG(varargin)
% RSG M-file for RSG.fig
%      RSG, by itself, creates a new RSG or raises the existing
%      singleton*.
%
%      H = RSG returns the handle to a new RSG or the handle to
%      the existing singleton*.
%
%      RSG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RSG.M with the given input arguments.
%
%      RSG('Property','Value',...) creates a new RSG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RSG_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RSG_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RSG

% Last Modified by GUIDE v2.5 28-Jul-2010 17:27:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RSG_OpeningFcn, ...
                   'gui_OutputFcn',  @RSG_OutputFcn, ...
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


% --- Executes just before RSG is made visible.
function RSG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RSG (see VARARGIN)

% Choose default command line output for RSG
handles.output = hObject;

handles.version = 1.01; % current version (2010-07-26)
handles.supportversion = 1; % minimum supported version

set(handles.surf1D_panel,'Visible','off');
set(handles.surf2D_panel,'Visible','on');
set(handles.plot2D_panel,'Visible','off');
set(handles.stats2D_panel,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RSG wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RSG_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function surfpts_edit_Callback(hObject, eventdata, handles)
% hObject    handle to surfpts_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of surfpts_edit as text
%        str2double(get(hObject,'String')) returns contents of surfpts_edit as a double


% --- Executes during object creation, after setting all properties.
function surfpts_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to surfpts_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function surflength_edit_Callback(hObject, eventdata, handles)
% hObject    handle to surflength_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of surflength_edit as text
%        str2double(get(hObject,'String')) returns contents of surflength_edit as a double


% --- Executes during object creation, after setting all properties.
function surflength_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to surflength_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function rmsheight_edit_Callback(hObject, eventdata, handles)
% hObject    handle to rmsheight_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rmsheight_edit as text
%        str2double(get(hObject,'String')) returns contents of rmsheight_edit as a double


% --- Executes during object creation, after setting all properties.
function rmsheight_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rmsheight_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function clength_edit_Callback(hObject, eventdata, handles)
% hObject    handle to clength_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of clength_edit as text
%        str2double(get(hObject,'String')) returns contents of clength_edit as a double


% --- Executes during object creation, after setting all properties.
function clength_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to clength_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function clengthy_edit_Callback(hObject, eventdata, handles)
% hObject    handle to clengthy_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of clengthy_edit as text
%        str2double(get(hObject,'String')) returns contents of clengthy_edit as a double


% --- Executes during object creation, after setting all properties.
function clengthy_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to clengthy_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function clengthx_edit_Callback(hObject, eventdata, handles)
% hObject    handle to clengthx_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of clengthx_edit as text
%        str2double(get(hObject,'String')) returns contents of clengthx_edit as a double


% --- Executes during object creation, after setting all properties.
function clengthx_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to clengthx_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in dimension_panel.
function dimension_panel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in dimension_panel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

if get(handles.oned_togglebutton,'Value') % 1D button selected
    set(handles.noniso_checkbox,'Visible','off');
    set(handles.iso_panel,'Visible','on');
    set(handles.noniso_panel,'Visible','off')
    if ~isempty(get(handles.surfpts_edit,'String'))
       if eventdata.OldValue == handles.twod_togglebutton
            set(handles.surfpts_edit,'String','');
       end
    end
elseif get(handles.twod_togglebutton,'Value') % 2D button selected
    set(handles.noniso_checkbox,'Visible','on');
    if get(handles.noniso_checkbox,'Value')
        set(handles.iso_panel,'Visible','off')
        set(handles.noniso_panel,'Visible','on')
    else
        set(handles.noniso_panel,'Visible','off')
        set(handles.iso_panel,'Visible','on')
    end
    if ~isempty(get(handles.surfpts_edit,'String')) % to reduce out of memory problems
       if eventdata.OldValue == handles.oned_togglebutton
            set(handles.surfpts_edit,'String','');
       end
    end
end


% --- Executes on button press in noniso_checkbox.
function noniso_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to noniso_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of noniso_checkbox
if get(hObject,'Value') % non-isotropic 2D surface
    set(handles.iso_panel,'Visible','off');
    set(handles.noniso_panel,'Visible','on');
else % isotropic 2D surface
    set(handles.noniso_panel,'Visible','off');
    set(handles.iso_panel,'Visible','on');
end


% --- Executes on selection change in hdf_popupmenu.
function hdf_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to hdf_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns hdf_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from hdf_popupmenu


% --- Executes during object creation, after setting all properties.
function hdf_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hdf_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in acf_popupmenu.
function acf_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to acf_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns acf_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from acf_popupmenu


% --- Executes during object creation, after setting all properties.
function acf_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to acf_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function resetpanels(handles)
set(handles.surf1D_panel,'Visible','off');
set(handles.plot1D_panel,'Visible','off');
set(handles.stats1D_panel,'Visible','off');
set(handles.surf2D_panel,'Visible','off');
set(handles.plot2D_panel,'Visible','off');
set(handles.stats2D_panel,'Visible','off');
drawnow

% --- Executes on button press in load_pushbutton.
function load_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to load_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName] = uigetfile('*.mat','Please select file to open',pwd);
if FileName ~= 0
    surfdata = load(fullfile(PathName,FileName));
    if isfield(surfdata,'x') && isfield(surfdata,'f') && ~isfield(surfdata,'y') && ...
            isfield(surfdata,'hdf') && isfield(surfdata,'acf') && ...
            isfield(surfdata,'version') % 1D surface
        
        if surfdata.version < handles.supportversion
            errordlg('Error! Surface data is too old and not supported by this version!','modal');
            return
        end
        
        resetpanels(handles);
        set(handles.surf1D_panel,'Visible','on');
        hw = uicontrol('Style','text','String','Please Wait...','Position',[385 400 100 50]);
        drawnow
        waitfor(hw,'Visible','on');
        
        handles.x = surfdata.x;
        handles.f = surfdata.f;
        handles.hdf = surfdata.hdf;
        handles.acf = surfdata.acf;
        
        % set panels
        set(handles.oned_togglebutton,'Value',1);
        set(handles.noniso_checkbox,'Value',0);
        set(handles.noniso_checkbox,'Visible','off');
        set(handles.noniso_panel,'Visible','off');
        set(handles.iso_panel,'Visible','on');
        if strcmp(handles.hdf,'gauss') 
            set(handles.hdf_popupmenu,'Value',1);
        end
        if strcmp(handles.acf,'gauss') 
            set(handles.acf_popupmenu,'Value',1);
        elseif strcmp(handles.acf,'exp') 
            set(handles.acf_popupmenu,'Value',2);
        end
        set(handles.surfpts_edit,'String',num2str(length(handles.f)));
        set(handles.surflength_edit,'String',num2str(handles.x(end)-handles.x(1)));
        [hdf,bc,h] = hdf1D(handles.f,100);
        set(handles.rmsheight_edit,'String',num2str(h));
        [acf,cl,lags] = acf1D(handles.f,handles.x);
        set(handles.clength_edit,'String',num2str(cl));
        
        %% draw surface and show data analysis
        draw1D(handles.x,handles.f,handles);
        set(handles.plot1D_panel,'Visible','on');
        
        if get(handles.showstats_checkbox,'Value') 
            showanalysis1D(handles.x,handles.f,handles);
            set(handles.stats1D_panel,'Visible','on');
        end
        set(hw,'Visible','off');
        drawnow
        
    elseif isfield(surfdata,'x') && isfield(surfdata,'y') && isfield(surfdata,'f') && ...
            isfield(surfdata,'hdf') && isfield(surfdata,'acf') && ...
            isfield(surfdata,'noniso') && isfield(surfdata,'version') % 2D surface
        
        if surfdata.version < handles.supportversion
            errordlg('Error! Surface data is too old and not supported by this version!','modal');
            return
        end
        
        resetpanels(handles);
        set(handles.surf2D_panel,'Visible','on');
        hw = uicontrol('Style','text','String','Please Wait...','Position',[385 400 100 50]);
        drawnow
        %waitfor(hw,'Visible','on');
       
        % set panels
        set(handles.twod_togglebutton,'Value',1);
        if strcmp(surfdata.hdf,'gauss') 
            set(handles.hdf_popupmenu,'Value',1);
        end
        if strcmp(surfdata.acf,'gauss') 
            set(handles.acf_popupmenu,'Value',1);
        elseif strcmp(surfdata.acf,'exp') 
            set(handles.acf_popupmenu,'Value',2);
        end
        set(handles.noniso_checkbox,'Value',surfdata.noniso);
        set(handles.noniso_checkbox,'Visible','on');
        set(handles.iso_panel,'Visible','off');
        set(handles.noniso_panel,'Visible','on');
        set(handles.surfpts_edit,'String',num2str(length(surfdata.f)));
        set(handles.surflength_edit,'String',num2str(surfdata.x(end)-surfdata.x(1)));
        [hdf,bc,h] = hdf2D(surfdata.f,100);
        set(handles.rmsheight_edit,'String',num2str(h));
        [acfx,clx,acfy,cly,lags] = acf2D(surfdata.f,surfdata.x,surfdata.y);
        if get(handles.noniso_checkbox,'Value')
            set(handles.clengthy_edit,'String',num2str(cly));
            set(handles.clengthx_edit,'String',num2str(clx));
            set(handles.noniso_panel,'Visible','on');
            set(handles.iso_panel,'Visible','off');
        else
            set(handles.clength_edit,'String',num2str(mean([clx cly])));
            set(handles.iso_panel,'Visible','on');
            set(handles.noniso_panel,'Visible','off');
        end
        
        
        %% draw surface and show data analysis
        draw2D(surfdata.x,surfdata.y,surfdata.f,handles);
        set(handles.plot2D_panel,'Visible','on');
        
        if get(handles.showstats_checkbox,'Value') 
            showanalysis2D(surfdata.x,surfdata.y,surfdata.f,handles);
            set(handles.stats2D_panel,'Visible','on');
            set(hw,'Visible','off');
            drawnow
            %% plot legend
            cla(handles.legend2D_axes)
            axes(handles.legend2D_axes);
            rectangle('Position', [-0.5 -0.9, 4.1, 1.8], 'FaceColor', 'w')
            hold(handles.legend2D_axes,'on')
            plot(handles.legend2D_axes,[0 1], [0.4 0.4], '-k', 'LineWidth', 2);
            hold(handles.legend2D_axes,'on')
            plot(handles.legend2D_axes,[0 1], [-0.4 -0.4], '-r', 'LineWidth', 1);
            axis(handles.legend2D_axes,[-1 5 -1 1])
            set(handles.legend2D_axes, 'Visible', 'off');
            text(1.5,0.4,'data','FontSize', 8,'FontWeight','normal');
            text(1.5,-0.4,'model','FontSize', 8,'Color','red');
        else
            set(hw,'Visible','off');
            drawnow
        end
        
        %% save new surface to handles structure
        handles.x = surfdata.x;
        handles.y = surfdata.y;
        handles.f = surfdata.f;
        handles.hdf = surfdata.hdf;
        handles.acf = surfdata.acf;
        handles.noniso = surfdata.noniso;
        
        
        
    else
       errordlg('Error! File has wrong format!');
    end
else
    errordlg('Error! No such file!');
end

guidata(hObject, handles);


% --- Executes on button press in save_pushbutton.
function save_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(handles.oned_togglebutton,'Value') % 1D surface
    if isfield(handles,'x') && isfield(handles,'f')
        surf.x = handles.x;
        surf.f = handles.f;
        surf.acf = handles.acf;
        surf.hdf = handles.hdf;
        surf.version = handles.version;
        
        [FileName,PathName] = uiputfile('*.mat','Save surface As...',pwd);
        if FileName ~= 0
            save(fullfile(PathName,FileName), '-struct', 'surf');
        end
    else
        errordlg('Error! No surface to be saved!','modal');
    end
elseif get(handles.twod_togglebutton,'Value') % 2D surface
    if isfield(handles,'x') && isfield(handles,'f')
        surf.x = handles.x;
        surf.y = handles.y;
        surf.f = handles.f;
        surf.acf = handles.acf;
        surf.hdf = handles.hdf;
        surf.noniso = handles.noniso;
        surf.version = handles.version;
        
        [FileName,PathName] = uiputfile('*.mat','Save surface As...',pwd);
        if FileName ~= 0
            save(fullfile(PathName,FileName), '-struct', 'surf');
        end
    else
        errordlg('Error! No surface to be saved!','modal');
    end
end

guidata(hObject, handles);


% --- Executes on button press in reset_pushbutton.
function reset_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to reset_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% empty fields
if isfield(handles,'x') 
    handles = rmfield(handles,'x');
end
if isfield(handles,'y') 
    handles = rmfield(handles,'y');
end
if isfield(handles,'f') 
    handles = rmfield(handles,'f');
end

% reset panels
set(handles.surfpts_edit,'String','');
set(handles.surflength_edit,'String','');
set(handles.rmsheight_edit,'String','');
set(handles.clength_edit,'String','');
set(handles.clengthy_edit,'String','');
set(handles.clengthx_edit,'String','');
set(handles.surf1D_panel,'Visible','off');
set(handles.surf2D_panel,'Visible','on');
set(handles.plot2D_panel,'Visible','off');
set(handles.stats2D_panel,'Visible','off');

guidata(hObject, handles);


% --- Executes on button press in exit_pushbutton.
function exit_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to exit_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close


% --- Executes on button press in create_pushbutton.
function create_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to create_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(handles.oned_togglebutton,'Value') % 1D surface
    
    if checkinput(handles,1) % check for valid inputs
        resetpanels(handles);
        set(handles.surf1D_panel,'Visible','on');
        hw = uicontrol('Style','text','String','Please Wait...','Position',[385 400 100 50]);
        drawnow
        waitfor(hw,'Visible','on');
        %% load input parameters
        surfpts = str2double(get(handles.surfpts_edit,'String'));
        length = str2double(get(handles.surflength_edit,'String'));
        rmsheight = str2double(get(handles.rmsheight_edit,'String'));
        cl = str2double(get(handles.clength_edit,'String'));
        %% check selected surface statistics
        % hdf
        if get(handles.hdf_popupmenu,'Value') == 1
            handles.hdf = 'gauss';
        end
        % acf
        if get(handles.acf_popupmenu,'Value') == 1
            [f,x] = rsgeng1D(surfpts,length,rmsheight,cl);
            handles.acf = 'gauss';
        elseif get(handles.acf_popupmenu,'Value') == 2
            [f,x] = rsgene1D(surfpts,length,rmsheight,cl);
            handles.acf = 'exp';
        end
        %% remove obsolete fields
        if isfield(handles,'x')
            handles = rmfield(handles,'x');
        end
        if isfield(handles,'y')
            handles = rmfield(handles,'y');
        end
        if isfield(handles,'f')
            handles = rmfield(handles,'f');
        end        
        %% draw surface and show data analysis
        draw1D(x,f,handles); 
        set(handles.plot1D_panel,'Visible','on');
        
        if get(handles.showstats_checkbox,'Value') 
            showanalysis1D(x,f,handles);
            set(handles.stats1D_panel,'Visible','on');
        end
        set(hw,'Visible','off');
        drawnow
        %% save new surface to handles structure
        handles.x = x; handles.f = f;
        if isfield(handles,'y')
            handles = rmfield(handles,'y');
        end
    end
    
elseif get(handles.twod_togglebutton,'Value') % 2D surface

    if checkinput(handles,1) % check for valid inputs
        resetpanels(handles);
        set(handles.surf2D_panel,'Visible','on');
        hw = uicontrol('Style','text','String','Please Wait...','Position',[385 400 100 50]);
        drawnow
        waitfor(hw,'Visible','on');
        %% load input parameters
        surfpts = str2double(get(handles.surfpts_edit,'String'));
        length = str2double(get(handles.surflength_edit,'String'));
        rmsheight = str2double(get(handles.rmsheight_edit,'String'));
        if get(handles.noniso_checkbox,'Value')
            clx = str2double(get(handles.clengthx_edit,'String'));
            cly = str2double(get(handles.clengthy_edit,'String'));
        else
            cl = str2double(get(handles.clength_edit,'String'));
        end
        %% remove obsolete fields
        if isfield(handles,'x')
            handles = rmfield(handles,'x');
        end
        if isfield(handles,'y')
            handles = rmfield(handles,'y');
        end
        if isfield(handles,'f')
            handles = rmfield(handles,'f');
        end
        %% check selected surface statistics
        % hdf
        if get(handles.hdf_popupmenu,'Value') == 1
            handles.hdf = 'gauss';
        end
        % acf
        if get(handles.acf_popupmenu,'Value') == 1
            if get(handles.noniso_checkbox,'Value')
                [f,x,y] = rsgeng2D(surfpts,length,rmsheight,clx,cly);
                handles.noniso = 1;
            else
                [f,x,y] = rsgeng2D(surfpts,length,rmsheight,cl);
                handles.noniso = 0;
            end
            handles.acf = 'gauss';
        elseif get(handles.acf_popupmenu,'Value') == 2
            if get(handles.noniso_checkbox,'Value')
                [f,x,y] = rsgene2D(surfpts,length,rmsheight,clx,cly);
                handles.noniso = 1;
            else
                [f,x,y] = rsgene2D(surfpts,length,rmsheight,cl);
                handles.noniso = 0;
            end
            handles.acf = 'exp';
        end
        %% draw surface and show data analysis
        draw2D(x,y,f,handles);
        set(handles.plot2D_panel,'Visible','on');

        if get(handles.showstats_checkbox,'Value') 
            %% show stats
            showanalysis2D(x,y,f,handles);
            set(handles.stats2D_panel,'Visible','on');
            
        end
        set(hw,'Visible','off');
        %% save new surface to handles structure
        handles.x = x; handles.y = y; handles.f = f;
        drawnow

    end
    
end

guidata(hObject, handles);


% --- Executes on button press in showstats_checkbox.
function showstats_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to showstats_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showstats_checkbox
tic
if get(hObject,'Value')
    if isfield(handles,'f')
        hw = uicontrol('Style','text','String','Please Wait...','Position',[385 400 100 50]);
        drawnow
        waitfor(hw,'Visible','on');
        if get(handles.oned_togglebutton,'Value')
            showanalysis1D(handles.x,handles.f,handles);
            set(handles.stats1D_panel,'Visible','on');
            set(hw,'Visible','off');
            drawnow
            %% plot legend
            cla(handles.legend1D_axes)
            axes(handles.legend1D_axes);
            rectangle('Position', [-0.5 -0.9, 4.1, 1.8], 'FaceColor', 'w')
            hold(handles.legend1D_axes,'on')
            plot(handles.legend1D_axes,[0 1], [0.4 0.4], '-k', 'LineWidth', 2);
            hold(handles.legend1D_axes,'on')
            plot(handles.legend1D_axes,[0 1], [-0.4 -0.4], '-r', 'LineWidth', 1);
            axis(handles.legend1D_axes,[-1 5 -1 1])
            set(handles.legend1D_axes, 'Visible', 'off');
            text(1.5,0.4,'data','FontSize', 8,'FontWeight','normal');
            text(1.5,-0.4,'model','FontSize', 8,'Color','red');
        else
            showanalysis2D(handles.x,handles.y,handles.f,handles);
            set(handles.stats2D_panel,'Visible','on');
            set(hw,'Visible','off');
            drawnow
            %% plot legend
            cla(handles.legend2D_axes)
            axes(handles.legend2D_axes);
            rectangle('Position', [-0.5 -0.9, 4.1, 1.8], 'FaceColor', 'w')
            hold(handles.legend2D_axes,'on')
            plot(handles.legend2D_axes,[0 1], [0.4 0.4], '-k', 'LineWidth', 2);
            hold(handles.legend2D_axes,'on')
            plot(handles.legend2D_axes,[0 1], [-0.4 -0.4], '-r', 'LineWidth', 1);
            axis(handles.legend2D_axes,[-1 5 -1 1])
            set(handles.legend2D_axes, 'Visible', 'off');
            text(1.5,0.4,'data','FontSize', 8,'FontWeight','normal');
            text(1.5,-0.4,'model','FontSize', 8,'Color','red');
        end
    end
else
    if isfield(handles,'f')
        if get(handles.oned_togglebutton,'Value')
            set(handles.stats1D_panel,'Visible','off');
        else
            set(handles.stats2D_panel,'Visible','off');
        end
    end
end
toc

%% check input parameters
function check = checkinput(handles,create)
check = 0;
if ~isempty(get(handles.surfpts_edit,'String')) && ~isempty(get(handles.surflength_edit,'String')) && ...
        ~isempty(get(handles.rmsheight_edit,'String')) && ...
        (~isempty(get(handles.clength_edit,'String')) || (~isempty(get(handles.clengthy_edit,'String')) && ~isempty(get(handles.clengthx_edit,'String'))))
    create = 1; % try to create surface
    surfpts = str2double(get(handles.surfpts_edit,'String'));
    length = str2double(get(handles.surflength_edit,'String'));
    rmsheight = str2double(get(handles.rmsheight_edit,'String'));
    if get(handles.twod_togglebutton,'Value') && get(handles.noniso_checkbox,'Value')
        clx = str2double(get(handles.clengthy_edit,'String'));
        cly = str2double(get(handles.clengthy_edit,'String'));      
        cl = 1;
    else
        cl = str2double(get(handles.clength_edit,'String'));
        clx = 1; cly = 1;
    end
    if (isnumeric(surfpts) && isreal(surfpts) && ~isnan(surfpts)) && ...
            (isnumeric(length) && isreal(length) && ~isnan(length)) && ...
            (isnumeric(rmsheight) && isreal(rmsheight) && ~isnan(rmsheight)) && ...
            (isnumeric(cl) && isreal(cl) && ~isnan(cl)) && ...
            (isnumeric(clx) && isreal(clx) && ~isnan(clx)) && (isnumeric(cly) && isreal(cly) && ~isnan(cly))
        if surfpts > 0 && length > 0 && rmsheight > 0 && cl > 0 && clx > 0 && cly > 0
            check = 1;
        else
            if create
                errordlg('Error! All inputs must be real and positive numbers!','modal');
            end
        end
    else
        if create
            errordlg('Error! All inputs must be real and positive numbers!','modal');
        end
    end
else
    if create
        errordlg('Error! Not enough input parameters!','modal');
    end
end

%% draw 1D surface
function draw1D(x,f,handles)
cla(handles.surf1D_axes);
plot(handles.surf1D_axes,x,f,'LineWidth',2,'Color','black'); axis(handles.surf1D_axes,[x(1) x(end) min(f) max(f)]); axis(handles.surf1D_axes, 'auto y');
xlabel(handles.surf1D_axes,'x','FontWeight','bold'), ylabel(handles.surf1D_axes,''), grid(handles.surf1D_axes,'on')

%% draw 2D surface
function draw2D(x,y,f,handles)
cla(handles.surf2D_axes);
mesh(handles.surf2D_axes,x,y,f); 
axis(handles.surf2D_axes, 'equal'); 
xlabel(handles.surf2D_axes,'x','FontWeight','bold'), ylabel(handles.surf2D_axes,'y','FontWeight','bold'), zlabel(handles.surf2D_axes,'')
set(handles.surf2D_axes,'ZTick',[]);
grid(handles.surf2D_axes,'on'), rotate3d(handles.surf2D_axes,'on'); 

%% show 1D surface statistics
function showanalysis1D(x,f,handles)
cla(handles.hdf1D_axes);
cla(handles.acfx1D_axes);

% plot histogram of surface data
[hdf,bc,h] = hdf1D(f,100);
skew = skewness(f);
kurt = kurtosis(f);
bar(handles.hdf1D_axes,bc,hdf), grid(handles.hdf1D_axes,'on')
xlabel(handles.hdf1D_axes,'Height'), ylabel(handles.hdf1D_axes,'Counts')
set(handles.rmsheight1D_text,'String',num2str(h));
set(handles.skewness1D_text,'String',num2str(skew,'%3.3f'));
set(handles.kurtosis1D_text,'String',num2str(kurt,'%3.3f'));

% plot gaussian fit
[muhat,sigmahat] = normfit(f);
hold(handles.hdf1D_axes,'on');
binwidth = bc(2) - bc(1);
histarea = binwidth*sum(hdf);
X = bc(1):binwidth/10:bc(end);
Y = normpdf(X,muhat,sigmahat);
plot(handles.hdf1D_axes,X,histarea*Y,'-r','LineWidth',1);
axis(handles.hdf1D_axes,'tight'),
set(handles.distfit1D_mean_text,'String',num2str(muhat));
set(handles.distfit1D_sigma_text,'String',num2str(sigmahat));

% draw lines for sigma (rms height)
hold(handles.hdf1D_axes,'on')
u = axis(handles.hdf1D_axes);
plot(handles.hdf1D_axes, [sigmahat sigmahat], [u(3) u(4)], ':r');
hold(handles.hdf1D_axes,'on')
plot(handles.hdf1D_axes, [-sigmahat -sigmahat], [u(3) u(4)], ':r');
hold(handles.hdf1D_axes,'on')
plot(handles.hdf1D_axes, [muhat muhat], [u(3) u(4)], '-.r');

% plot autocorrelation function of surface data
[acf,cl,lags] = acf1D(f,x);
plot(handles.acfx1D_axes,lags,acf/acf(1),'-k','LineWidth',2), axis(handles.acfx1D_axes,[0 5*cl -0.5 1])
xlabel(handles.acfx1D_axes,'Lag length'), ylabel(handles.acfx1D_axes,'ACF'), grid(handles.acfx1D_axes,'on')
set(handles.clengthx1D_text2,'String',num2str(cl));

% plot autocorrelation fit
if get(handles.acf_popupmenu,'Value') == 1 % gaussian acf
    hold(handles.acfx1D_axes,'on')
    acf_gauss = exp(-lags.^2/cl^2);
    plot(handles.acfx1D_axes,lags,acf_gauss,'-r')
elseif get(handles.acf_popupmenu,'Value') == 2 % exponential acf
    hold(handles.acfx1D_axes,'on')
    acf_exp = exp(-lags/cl);
    plot(handles.acfx1D_axes,lags,acf_exp,'-r')
end

% draw lines for 1/e (correlation length)
hold(handles.acfx1D_axes,'on')
plot(handles.acfx1D_axes, [0 10*cl], [1/exp(1) 1/exp(1)], ':r');
v = axis(handles.acfx1D_axes);
plot(handles.acfx1D_axes, [cl cl], [v(3) v(4)], ':r');

% plot legend
cla(handles.legend1D_axes) 
axes(handles.legend1D_axes);
rectangle('Position', [-0.5 -0.9, 4.1, 1.8], 'FaceColor', 'w') 
hold(handles.legend1D_axes,'on')
plot(handles.legend1D_axes,[0 1], [0.4 0.4], '-k', 'LineWidth', 2);
hold(handles.legend1D_axes,'on')
plot(handles.legend1D_axes,[0 1], [-0.4 -0.4], '-r', 'LineWidth', 1);
axis(handles.legend1D_axes,[-1 5 -1 1])
set(handles.legend1D_axes, 'Visible', 'off');
text(1.5,0.4,'data','FontSize', 8,'FontWeight','normal');
text(1.5,-0.4,'model','FontSize', 8,'Color','red');

%% show 2D surface statistics
function showanalysis2D(x,y,f,handles)
cla(handles.hdf2D_axes);
cla(handles.acfx2D_axes);
cla(handles.acfy2D_axes);

% plot histogram of surface data
[hdf,bc,h] = hdf2D(f,100);
skew = skewness(reshape(f,1,numel(f)));
kurt = kurtosis(reshape(f,1,numel(f)));
bar(handles.hdf2D_axes,bc,hdf), grid(handles.hdf2D_axes,'on')
xlabel(handles.hdf2D_axes,'Height'), ylabel(handles.hdf2D_axes,'Counts')
set(handles.rmsheight2D_text,'String',num2str(h));
set(handles.skewness2D_text,'String',num2str(skew,'%3.3f'));
set(handles.kurtosis2D_text,'String',num2str(kurt,'%3.3f'));

% plot gaussian fit
[muhat,sigmahat] = normfit(reshape(f,1,numel(f)));
hold(handles.hdf2D_axes,'on');
binwidth = bc(2) - bc(1);
histarea = binwidth*sum(hdf);
X = bc(1):binwidth/10:bc(end);
Y = normpdf(X,muhat,sigmahat);
plot(handles.hdf2D_axes,X,histarea*Y,'-r','LineWidth',1);
axis(handles.hdf2D_axes,'tight'),
set(handles.distfit2D_mean_text,'String',num2str(muhat));
set(handles.distfit2D_sigma_text,'String',num2str(sigmahat));

% draw lines for sigma (rms height)
hold(handles.hdf2D_axes,'on')
u = axis(handles.hdf2D_axes);
plot(handles.hdf2D_axes, [sigmahat sigmahat], [u(3) u(4)], ':r');
hold(handles.hdf2D_axes,'on')
plot(handles.hdf2D_axes, [-sigmahat -sigmahat], [u(3) u(4)], ':r');
hold(handles.hdf2D_axes,'on')
plot(handles.hdf2D_axes, [muhat muhat], [u(3) u(4)], '-.r');

% plot autocorrelation function of surface data
[acfx,clx,acfy,cly,lags] = acf2D(f,x,y);
plot(handles.acfx2D_axes,lags,acfx/acfx(1),'-k','LineWidth',2), axis(handles.acfx2D_axes,[0 5*clx -0.5 1])
xlabel(handles.acfx2D_axes,'Lag length'), ylabel(handles.acfx2D_axes,'ACF'), grid(handles.acfx2D_axes,'on')
set(handles.clengthx2D_text,'String',num2str(clx));
plot(handles.acfy2D_axes,lags,acfy/acfy(1),'-k','LineWidth',2), axis(handles.acfy2D_axes,[0 5*cly -0.5 1])
xlabel(handles.acfy2D_axes,'Lag length'), ylabel(handles.acfy2D_axes,'ACF'), grid(handles.acfy2D_axes,'on')
set(handles.clengthy2D_text,'String',num2str(cly));

% plot autocorrelation fit
if get(handles.acf_popupmenu,'Value') == 1 % gaussian acf
    hold(handles.acfx2D_axes,'on')
    acf_gauss = exp(-lags.^2/clx^2);
    plot(handles.acfx2D_axes,lags,acf_gauss,'-r')
    hold(handles.acfy2D_axes,'on')
    acf_gauss = exp(-lags.^2/cly^2);
    plot(handles.acfy2D_axes,lags,acf_gauss,'-r')
elseif get(handles.acf_popupmenu,'Value') == 2 % exponential acf
    hold(handles.acfx2D_axes,'on')
    acf_exp = exp(-lags/clx);
    plot(handles.acfx2D_axes,lags,acf_exp,'-r')
    hold(handles.acfy2D_axes,'on')
    acf_exp = exp(-lags/cly);
    plot(handles.acfy2D_axes,lags,acf_exp,'-r')
end

% draw lines for 1/e (correlation length)
hold(handles.acfx2D_axes,'on')
plot(handles.acfx2D_axes, [0 10*clx], [1/exp(1) 1/exp(1)], ':r');
v = axis(handles.acfx2D_axes);
plot(handles.acfx2D_axes, [clx clx], [v(3) v(4)], ':r');
hold(handles.acfy2D_axes,'on')
plot(handles.acfy2D_axes, [0 10*cly], [1/exp(1) 1/exp(1)], ':r');
v = axis(handles.acfy2D_axes);
plot(handles.acfy2D_axes, [cly cly], [v(3) v(4)], ':r');

%% plot legend
cla(handles.legend2D_axes)
axes(handles.legend2D_axes);
rectangle('Position', [-0.5 -0.9, 4.1, 1.8], 'FaceColor', 'w')
hold(handles.legend2D_axes,'on')
plot(handles.legend2D_axes,[0 1], [0.4 0.4], '-k', 'LineWidth', 2);
hold(handles.legend2D_axes,'on')
plot(handles.legend2D_axes,[0 1], [-0.4 -0.4], '-r', 'LineWidth', 1);
axis(handles.legend2D_axes,[-1 5 -1 1])
set(handles.legend2D_axes, 'Visible', 'off');
text(1.5,0.4,'data','FontSize', 8,'FontWeight','normal');
text(1.5,-0.4,'model','FontSize', 8,'Color','red');
            
%% calculate autocovariance and correlation length for 1D surface
function [acf,cl,lags] = acf1D(f,x)
N = length(x); % number of sample points
lags = linspace(0,x(N)-x(1),N); % lag lengths % lag lengths
% autocovariance function calculation
c=xcov(f,'coeff'); % the autocovariance function
acf=c(N:2*N-1); % right-sided version
% correlation length calculation
k = 1;
while (acf(k) > 1/exp(1))
    k = k + 1;
end;
cl = 1/2*(x(k-1)+x(k)-2*x(1)); % the correlation length

%% calculate autocovariance and correlation length for 2D surface
function [acfx,clx,acfy,cly,lags] = acf2D(f,x,y)
N = length(x); % number of sample points
lags = linspace(0,x(N)-x(1),N); % lag lengths
% autocovariance function calculation
acfx = zeros(1,N); acfy = zeros(1,N);
for i = 1:N
    cx = xcov(f(i,:),'coeff'); % the autocovariance function in x at row i
    acfx = acfx + cx(N:2*N-1); % right-sided version (cumulative sum)
    cy = xcov(f(:,i),'coeff'); % the autocovariance function in y at column i
    acfy = acfy + cy(N:2*N-1)'; % right-sided version (cumulative sum)
end;
acfx = acfx / N; acfy = acfy / N; % averaging of acfs
% correlation lengths calculation
% in x
k = 1;
while (acfx(k) > 1/exp(1))
    k = k + 1;
end;
clx = 1/2*(x(k-1)+x(k)-2*x(1)); % the correlation length in x
% in y
k = 1;
while (acfy(k) > 1/exp(1))
    k = k + 1;
end;
cly = 1/2*(y(k-1)+y(k)-2*y(1)); % the correlation length in y

%% calculate height distribution function and rms height for 1D surface
function [hdf,bc,h] = hdf1D(f,b)
h = std(f); % rms height
[hdf,bc] = hist(f,b); 

%% calculate height distribution function and rms height for 2D surface
function [hdf,bc,h] = hdf2D(f,b)
h =  std(f(:)); % rms height
[hdf,bc] = hist(f,b); % histograms over columns
hdf = sum(hdf,2); % summing all histograms

%% 1D Gaussian random rough surface with Gaussian autocovariance function
function [f,x] = rsgeng1D(N,rL,h,cl)
x = linspace(-rL/2,rL/2,N);
Z = h.*randn(1,N); % uncorrelated Gaussian random rough surface distribution with mean 0 and standard deviation h           
F = exp(-x.^2/(cl^2/2)); % Gaussian filter
f = sqrt(2/sqrt(pi))*sqrt(rL/N/cl)*ifft(fft(Z).*fft(F)); %correlation of surface using convolution (faltung), inverse Fourier transform and normalizing prefactors

%% 2D Gaussian random rough surface with Gaussian autocovariance function
function [f,x,y] = rsgeng2D(N,rL,h,clx,cly)
x = linspace(-rL/2,rL/2,N); y = linspace(-rL/2,rL/2,N);
[X,Y] = meshgrid(x,y); 
Z = h.*randn(N,N); % uncorrelated Gaussian random rough surface distribution with mean 0 and standard deviation h
% isotropic surface
if nargin == 4
    F = exp(-((X.^2+Y.^2)/(clx^2/2))); % Gaussian filter
    f = 2/sqrt(pi)*rL/N/clx*ifft2(fft2(Z).*fft2(F)); % correlation of surface including convolution (faltung), inverse Fourier transform and normalizing prefactors
% non-isotropic surface
elseif nargin == 5
    F = exp(-(X.^2/(clx^2/2)+Y.^2/(cly^2/2))); % Gaussian filter
    f = 2/sqrt(pi)*rL/N/sqrt(clx)/sqrt(cly)*ifft2(fft2(Z).*fft2(F)); % correlated surface generation including convolution (faltning) and inverse Fourier transform
end

%% 1D Gaussian random rough surface with exponential autocovariance function
function [f,x] = rsgene1D(N,rL,h,cl)
x = linspace(-rL/2,rL/2,N);
Z = h.*randn(1,N); % uncorrelated Gaussian random rough surface distribution with rms height h 
F = exp(-abs(x)/(cl/2)); % Gaussian filter
f = sqrt(2)*sqrt(rL/N/cl)*ifft(fft(Z).*fft(F)); % correlated surface generation including convolution (faltning) and inverse Fourier transform and normalizing prefactors

%% 2D Gaussian random rough surface with exponential autocovariance function
function [f,x,y] = rsgene2D(N,rL,h,clx,cly)
x = linspace(-rL/2,rL/2,N); y = linspace(-rL/2,rL/2,N);
[X,Y] = meshgrid(x,y); 
Z = h.*randn(N,N); % uncorrelated Gaussian random rough surface distribution with rms height h
% isotropic surface
if nargin == 4
    F = exp(-(abs(X)+abs(Y))/(clx/2)); % Gaussian filter
    f = 2*rL/N/clx*ifft2(fft2(Z).*fft2(F)); % correlation of surface including convolution (faltung), inverse Fourier transform and normalizing prefactors
% non-isotropic surface
elseif nargin == 5
    F = exp(-(abs(X)/(clx/2)+abs(Y)/(cly/2))); % Gaussian filter
    f = 2*rL/N/sqrt(clx*cly)*ifft2(fft2(Z).*fft2(F)); % correlation of surface including convolution (faltung), inverse Fourier transform and suitable prefactors
end
%% skewness
function sk = skewness(f)
sk = mean((f-mean(f)).^3)/((mean((f-mean(f)).^2))^(3/2));
%% kurtosis
function ku = kurtosis(f)
ku = mean((f-mean(f)).^4)/((mean((f-mean(f)).^2))^(2));