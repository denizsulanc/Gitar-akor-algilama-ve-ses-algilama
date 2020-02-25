function varargout = ses(varargin)
% SES MATLAB code for ses.fig
%      SES, by itself, creates a new SES or raises the existing
%      singleton*.
%
%      H = SES returns the handle to a new SES or the handle to
%      the existing singleton*.
%
%      SES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SES.M with the given input arguments.
%
%      SES('Property','Value',...) creates a new SES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ses_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ses_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ses

% Last Modified by GUIDE v2.5 23-Jan-2017 00:16:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ses_OpeningFcn, ...
                   'gui_OutputFcn',  @ses_OutputFcn, ...
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


% --- Executes just before ses is made visible.
function ses_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ses (see VARARGIN)

% Choose default command line output for ses
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ses wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ses_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in bkaydet.
function bkaydet_Callback(hObject, eventdata, handles)
clear All;
close All;
clc;
%% Bir kayýt nesnesi yaratýyoruz
recorder = audiorecorder(16000,8,2);
%% Kullanýcý sesini kayýt yapacak
disp('lütfen ses kaydý yapýnýz');
drawnow();
pause(1);
recordblocking(recorder,5); %%Kayýt süresini 5 saniye olarak belirledim 5 saniye sonunda dursun 
play(recorder); %%Ses çalma komutu kullanýyoruz 
data=getaudiodata(recorder); %%Recorder'daki ses verisini data'ya aktarýyorum 
plot (data) %%Ses seviyesini grafik üzerinde görmek için plot ile çizdiriyoruz
figure;
%% Feature Extraction
f=VoiceFeatures(data);
%% Save users data
uno=input('Enter the user number :');
try
    load database %%verileri yükle
    F=[F;f];
    C=[C;uno];
    save database
catch
    F=f;
    C=uno;
    save database F C
end
msgbox('ses kaydoldu')

% --- Executes on button press in btest.
function btest_Callback(hObject, eventdata, handles)
clear All;
close All;
clc;
%% bir kayýt nesnesi yarattýk
recorder = audiorecorder(16000,16,2);
%% kullanýcý sesini 5 saniye boyunca kaydet
disp('lütfen ses kaydý yapýnýz');
drawnow();
pause(1);
recordblocking(recorder,5);
play(recorder);
data=getaudiodata(recorder);
plot (data)
figure;
%% Feature Extraction
load database
f=VoiceFeatures(data); 
disp(f);
%% Classifty
if f > 540 && f < 900 %2050
    disp('mi');
    %%elseif f > 1000 && f < 1200 %280--
    %%fprintf('la');
    %elseif f > 230 && f < 250 %1470
    %fprintf('re');
    %%elseif f > 950 && f < 1050  %990
    %%fprintf('sol');
    %%elseif f > 1200 && f < 1300 %1230
    %%fprintf('si');
    elseif f > 200 && f <550 %1648
    fprintf('ince mi');

end


function [perde]= VoiceFeatures(data)
F=fft(data(:,1));
figure(2);
plot(real(F));
title('Frekans');
m=max(real(F));
perde=m;