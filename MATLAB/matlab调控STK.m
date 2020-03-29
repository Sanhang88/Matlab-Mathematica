function varargout = bishe(varargin)
% BISHE M-file for bishe.fig
%      BISHE, by itself, creates a new BISHE or raises the existing
%      singleton*.
%
%      H = BISHE returns the handle to a new BISHE or the handle to
%      the existing singletn*.
%
%      BISHE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BISHE.M with the given input arguments.
%
%      BISHE('Property','Value',...) creates a new BISHE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bishe_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bishe_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bishe

% Last Modified by GUIDE v2.5 04-Jun-2017 23:53:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bishe_OpeningFcn, ...
                   'gui_OutputFcn',  @bishe_OutputFcn, ...
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


% --- Executes just before bishe is made visible.
function bishe_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bishe (see VARARGIN)

% Choose default command line output for bishe
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global t
t=timer;%定义一个定时器，添加到handles结构体中，方便后面使用  
set(t,'ExecutionMode','FixedRate');%ExecutionMode   执行的模式  
set(t,'Period',1);%周期  
set(t,'TimerFcn',{@dispNow,handles});%定时器的执行函数
set(handles.figure1, 'DeleteFcn', {@DeleteFcn, t});
start(t);%启动定时器

function DeleteFcn(hObject, eventdata, t)
stop(t);

function dispNow(hObject,eventdata,handles) 
global shijieshijian;
beijingshijian=datestr(now,'dd mmm yyyy HH:MM:SS');
[year,month,day,h,min,sec] = datevec(beijingshijian);
shijian = datestr([year,month,day,(h-str2num('8')),min,sec]);
shijieshijian=datestr(shijian,'dd mmm yyyy HH:MM:SS');
set(handles.beijingshijian,'string',['北京时间:' beijingshijian]);
set(handles.shijian,'string',['世界时间:' shijieshijian]);
% global ScanSim_APP
% ScanSim_APP = actxserver('STKX9.Application');
% set(ScanSim_APP,'EnableConnect',true);
% set(ScanSim_APP,'ConnectPort',5001);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bgcolor_red = 0;
% bgcolor_green = 0;
% bgcolor_blue = 0;
% bgcolor = (bgcolor_blue*65535) + (bgcolor_green*255) + (bgcolor_red);
% set(handles.activex1,'Backcolor',bgcolor);
% set(handles.activex1,'Nologo',1);

% UIWAIT makes bishe wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = bishe_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in changjing.
function changjing_Callback(hObject, eventdata, handles)
% hObject    handle to changjing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles    structure with handles and user data (see GUIDATA)
clc;
global weizhiwenjian
global zitaiwenjian
global moxingwenjian
global shijieshijian
sjsj=shijieshijian;
dt=textread(['' weizhiwenjian '']);
[m,n]=size(dt);
title=char('stk.v.4.2','BEGIN Ephemeris','    BlockingFactor		20','    InterpolationOrder 		5',['NumberOfEphemerisPoints 		' num2str(m) ''],['ScenarioEpoch 		' sjsj ''],'CentralBody 		 Earth','CoordinateSystem 		 Fixed','EphemerisTimePosVel');
fid=fopen((['' cd  '/weizhi/weizhitou.txt']),'w');
for i=1:size(title,1)
    fprintf(fid,'%s\r\n',title(i,:));
end
fid1=fopen((['' cd  '/weizhi/weizhitou.txt']),'r');
fid2=fopen(['' weizhiwenjian ''],'r');
fid3=fopen((['' cd  '/weizhi/weizhiwei.txt']),'r');
data1=fread(fid1);
data2=fread(fid2);
data3=fread(fid3);
fid3=fopen('shuju.e','w');
fwrite(fid3,data1);
fwrite(fid3,data2);
fwrite(fid3,data3);
  


dt=textread(['' zitaiwenjian '']);
[m,n]=size(dt);
title=char('stk.v.4.2','BEGIN Attitude',['ScenarioEpoch 		' sjsj ''],['NumberOfAttitudePoints 		' num2str(m) ''],'BlockingFactor          20','InterpolationOrder     		1','CentralBody             Earth','CoordinateAxes        	J2000','AttitudeTimeQuaternions' );
fid=fopen((['' cd  '/zitai/zitaitou.txt']),'w');
for i=1:size(title,1)
    fprintf(fid,'%s\r\n',title(i,:));
end
fid1=fopen((['' cd  '/zitai/zitaitou.txt']),'r');
fid2=fopen(['' zitaiwenjian ''],'r');
fid3=fopen((['' cd  '/zitai/zitaiwei.txt']),'r');
data1=fread(fid1);
data2=fread(fid2);
data3=fread(fid3);
fid3=fopen('shuju.a','w');
fwrite(fid3,data1);
fwrite(fid3,data2);
fwrite(fid3,data3);



cmdstr = ['CheckScenario /'];
rtn = invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);
if isequal(str2num(rtn.Item(0)),1)
    rtn = invoke(handles.activex1.Application,'ExecuteCommand','Unload / *');
end
starttime = [' ' shijieshijian ' '];
daynum = str2num('20');
[year,month,day,h,min,sec] = datevec(starttime);
stoptime = datestr([year,month,(daynum+day),h,min,sec]);

scenaname = 'changjing';
invoke(handles.activex1.Application,'ExecuteCommand',['New / Scenario ' scenaname]);
cmdstr = ['SetTimePeriod * ' '"' sjsj '"' ' "' stoptime '"'];
invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);
cmdstr = ['SetEpoch * ','"' sjsj '"'];
invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);

cmdstr = (['SetUnits / EpSec UTCG']);
invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);

% cmdstr = ['SetAnimation * StartTime ','"' starttime '"',' TimeStep ',num2str(step),' RefreshDelta ',num2str(step),' RefreshMode RefreshDelta'];
% invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);

cmdstr = ['SetAnimation * StartTime "' sjsj '" AnimationMode XRealTime '];
invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);


invoke(handles.activex1.Application,'ExecuteCommand','Animate Scenario/* Reset');
invoke(handles.activex1.Application,'ExecuteCommand','AllowAnimationUpdate * On');


missilename = 'daodan';
cmd = ['New / */Missile ' missilename];
invoke(handles.activex1.Application,'ExecuteCommand',cmd);

%%%设置数据路径
weizhi=which('shuju.e');
zitai=which('shuju.a');
cmd=(['SetState */Missile/daodan File "' weizhi '"']);
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
cmd=(['SetAttitude */Missile/daodan File "' zitai '" ']);
invoke(handles.activex1.Application,'ExecuteCommand',cmd);


%%设置mdl路径
cmd=(['VO */Missile/daodan Model File ' moxingwenjian]);
invoke(handles.activex1.Application,'ExecuteCommand',cmd);



cmdstr = ['New / */Facility ','fashechang'];
invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);
cmdstr = ['SetPosition */Facility/fashechang Geodetic 33.334039000 44.397835000 -36.000' ];
invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);
fashechang=(['' cd  '/fashechang/fashechang.mdl']);
cmd=(['VO */Facility/fashechang Model File "' fashechang '"']);

invoke(handles.activex1.Application,'ExecuteCommand',cmd);
cmd=('VO * View FromTo FromRegName "STK Object" FromName "Facility/fashechang" ToRegName "STK Object" ToName "Facility/fashechang" ');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);

cmd=('VO */Missile/daodan DynDataText DataDisplay "LLA Position" Show On Position Left 1 Top 1 Font Small');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
cmd=('VO */Missile/daodan DynDataText DataDisplay "Yaw Pitch Roll" Show On Color yellow Position Left 1 Bottom 350 Font Small');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
% cmd=('VO * View FromTo FromRegName "STK Object" FromName "Missile/daodan" ToRegName "STK Object" ToName "Missile/daodan" ');
% invoke(handles.activex1.Application,'ExecuteCommand',cmd);
%%放大地图
cmd=('ReportCreate */Missile/daodan Type Export Style "LLA Position" File "D:\positon.txt" ');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
temp=importdata('D:\positon.txt');
data=temp.data;
[mm,nn]=size(data);
weidu1=data(1,1);
jingdu1=data(1,2);
haiba1=data(1,3);
weidu2=data(mm,1);
jingdu2=data(mm,2);
haiba2=data(mm,3);
zhongxinweidu=(weidu1+weidu2)/2;
zhongxinjingdu=(jingdu1+jingdu2)/2;
fanwei1=abs(jingdu1-zhongxinjingdu);
fanwei2=abs(weidu1-zhongxinweidu);
fanwei=max(fanwei1,fanwei2);
cmd=(['Zoom * LatLon ' num2str(zhongxinweidu) '  ' num2str(zhongxinjingdu) ' ' num2str(fanwei) ' 1']);
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
cmd=('VO * ViewerPosition 15 -15 175 2');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
cmd=('VO * GlobeDetails MapDetail Show On Map RWDB2_Coastlines  Map RWDB2_International_Borders ShowDetail ON  WindowID 2');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
cmd=('Lighting * Umbra Fill On FillColor "black" ');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
% 
[year,month,day,h,min,sec] = datevec(sjsj);
sj = datestr([year,month,day,h,min,(sec+str2num('1'))]);
shijian=datestr(sj,'dd mmm yyyy HH:MM:SS');

cmd=(['VO */Missile/daodan Articulate  "' sjsj '" 3 Booster_Flame Size 0 1 ']);
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
cmd=(['VO */Missile/daodan Articulate  "' sjsj '" 3 MainEngine_Flame Size 0 1 ']);
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
% 
% cmd=(['VO */Missile/daodan Articulate  "' shijian '" 10 Booster Drop 0 -100 ']);
% invoke(handles.activex1.Application,'ExecuteCommand',cmd);

cmd=(['VO */Facility/fashechang Articulate  "' sjsj '" 3 Graple_a Pitch 0 -55']);
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
cmd=(['VO */Facility/fashechang Articulate  "' sjsj '" 3 Graple_b Pitch 0 90']);
invoke(handles.activex1.Application,'ExecuteCommand',cmd);

cmd=(['VO */Facility/fashechang Articulate  "' sjsj '" 1 Pad_flame_a Size 0 3']);
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
cmd=(['VO */Facility/fashechang Articulate  "' sjsj '" 1 Pad_flame_b Size 0 3']);
invoke(handles.activex1.Application,'ExecuteCommand',cmd);

cmd=(['VO */Facility/fashechang Articulate  "' shijian '" 1 Pad_flame_a Size 3 0']);
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
cmd=(['VO */Facility/fashechang Articulate  "' shijian '" 1 Pad_flame_b Size 3 0']);
invoke(handles.activex1.Application,'ExecuteCommand',cmd);








function kaishi_Callback(hObject, eventdata, handles)
% hObject    handle to kaishi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cmdstr = ['Animate * Start'];
invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);
cmd=('VO * View FromTo FromRegName "STK Object" FromName "Missile/daodan" ToRegName "STK Object" ToName "Missile/daodan" ');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
cmd=('VO * ViewerPosition 145 55 120 2');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
cmd=('ReportCreate */Missile/daodan Type Export Style "LLA Position" File "D:\positon.txt" ');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
temp=importdata('D:\positon.txt');
% data=temp.data;
% weidu=data(1,1);
% jingdu=data(1,2);
% haiba=data(1,3);
% set(handles.weidu,'string',['纬度(deg):' num2str(weidu)]);
% set(handles.jingdu,'string',['经度(deg):' num2str(jingdu)]);
% set(handles.haiba,'string',['海拔(km):' num2str(haiba)]);
% 
cmd=('ReportCreate */Missile/daodan Type Export Style "Attitude Quaternions" File "D:\attitude.txt" ');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
temp=importdata('D:\attitude.txt');
% data=temp.data;
% [mm,nn]=size(data);
% for i=1:mm
% yaw=data(i,1)
% pitch=data(i,2);
% roll=data(i,3);
% set(handles.pianhang,'string',['偏航角(deg):' num2str(yaw)]);
% set(handles.fuyang,'string',['俯仰角(deg):' num2str(pitch)]);
% set(handles.gunzhuan,'string',['滚转角(deg):' num2str(roll)]);
% pause(1);
% end


% --- Executes on button press in zanting.
function zanting_Callback(hObject, eventdata, handles)
% hObject    handle to zanting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cmdstr = ['Animate * Pause'];
invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);


% --- Executes on button press in jiasu.
function jiasu_Callback(hObject, eventdata, handles)
% hObject    handle to jiasu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cmdstr = ['Animate * Faster'];
invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);


% --- Executes on button press in jiansu.
function jiansu_Callback(hObject, eventdata, handles)
% hObject    handle to jiansu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cmdstr = ['Animate * Slower'];
invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);


% --- Executes on button press in chongzhi.
function chongzhi_Callback(hObject, eventdata, handles)
% hObject    handle to chongzhi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cmdstr = ['Animate * Reset'];
invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);


% --- Executes on button press in zairushuju.
function zairushuju_Callback(hObject, eventdata, handles)
% hObject    handle to zairushuju (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global weizhiwenjian
[FileName,PathName] = uigetfile('*.txt','选择位置文件');
weizhiwenjian=[PathName,FileName];
global zitaiwenjian
[FileName1,PathName1] = uigetfile('*.txt','选择姿态文件');
zitaiwenjian=[PathName1,FileName1];
global moxingwenjian
[F,P] = uigetfile('*.mdl','选择mdl模型');
moxingwenjian=[P,F];


% --- Executes on button press in tuichu.
function tuichu_Callback(hObject, eventdata, handles)
% hObject    handle to tuichu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;


% --- Executes on button press in shishifangzhen.
function shishifangzhen_Callback(hObject, eventdata, handles)
% hObject    handle to shishifangzhen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
global weizhiwenjian
global zitaiwenjian
global moxingwenjian
global shijieshijian
sjsj=shijieshijian;

weizhiwenjian=which('weizhi1.txt');
zitaiwenjian=which('zitai.txt');
moxingwenjian=(['' cd  '/aim-9m/aim-9m.mdl']);
dt=textread(['' weizhiwenjian '']);
[m,n]=size(dt);
title=char('stk.v.4.2','BEGIN Ephemeris','    BlockingFactor		20','    InterpolationOrder 		5',['NumberOfEphemerisPoints 		' num2str(m) ''],['ScenarioEpoch 		' sjsj ''],'CentralBody 		 Earth','CoordinateSystem 		 Fixed','EphemerisTimePosVel');
fid=fopen((['' cd  '/weizhi/weizhitou.txt']),'w');
for i=1:size(title,1)
    fprintf(fid,'%s\r\n',title(i,:));
end
fid1=fopen((['' cd  '/weizhi/weizhitou.txt']),'r');
fid2=fopen(['' weizhiwenjian ''],'r');
fid3=fopen((['' cd  '/weizhi/weizhiwei.txt']),'r');
data1=fread(fid1);
data2=fread(fid2);
data3=fread(fid3);
fid3=fopen('shuju.e','w');
fwrite(fid3,data1);
fwrite(fid3,data2);
fwrite(fid3,data3);
  


dt=textread(['' zitaiwenjian '']);
[m,n]=size(dt);
title=char('stk.v.4.2','BEGIN Attitude',['ScenarioEpoch 		' sjsj ''],['NumberOfAttitudePoints 		' num2str(m) ''],'BlockingFactor          20','InterpolationOrder     		1','CentralBody             Earth','CoordinateAxes        	J2000','AttitudeTimeQuaternions' );
fid=fopen((['' cd  '/zitai/zitaitou.txt']),'w');
for i=1:size(title,1)
    fprintf(fid,'%s\r\n',title(i,:));
end
fid1=fopen((['' cd  '/zitai/zitaitou.txt']),'r');
fid2=fopen(['' zitaiwenjian ''],'r');
fid3=fopen((['' cd  '/zitai/zitaiwei.txt']),'r');
data1=fread(fid1);
data2=fread(fid2);
data3=fread(fid3);
fid3=fopen('shuju.a','w');
fwrite(fid3,data1);
fwrite(fid3,data2);
fwrite(fid3,data3);



cmdstr = ['CheckScenario /'];
rtn = invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);
if isequal(str2num(rtn.Item(0)),1)
    rtn = invoke(handles.activex1.Application,'ExecuteCommand','Unload / *');
end
starttime = [' ' shijieshijian ' '];
daynum = str2num('20');
[year,month,day,h,min,sec] = datevec(starttime);
stoptime = datestr([year,month,(daynum+day),h,min,sec]);

scenaname = 'changjing';
invoke(handles.activex1.Application,'ExecuteCommand',['New / Scenario ' scenaname]);
cmdstr = ['SetTimePeriod * ' '"' sjsj '"' ' "' stoptime '"'];
invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);
cmdstr = ['SetEpoch * ','"' sjsj '"'];
invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);

cmdstr = (['SetUnits / EpSec UTCG']);
invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);

% cmdstr = ['SetAnimation * StartTime ','"' starttime '"',' TimeStep ',num2str(step),' RefreshDelta ',num2str(step),' RefreshMode RefreshDelta'];
% invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);

cmdstr = ['SetAnimation * StartTime "' sjsj '" AnimationMode XRealTime '];
invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);


invoke(handles.activex1.Application,'ExecuteCommand','Animate Scenario/* Reset');
invoke(handles.activex1.Application,'ExecuteCommand','AllowAnimationUpdate * On');


missilename = 'daodan';
cmd = ['New / */Missile ' missilename];
invoke(handles.activex1.Application,'ExecuteCommand',cmd);

%%%设置数据路径
weizhi=which('shuju.e');
zitai=which('shuju.a');
cmd=(['SetState */Missile/daodan File "' weizhi '"']);
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
cmd=(['SetAttitude */Missile/daodan File "' zitai '" ']);
invoke(handles.activex1.Application,'ExecuteCommand',cmd);


%%设置mdl路径
cmd=(['VO */Missile/daodan Model File ' moxingwenjian]);
invoke(handles.activex1.Application,'ExecuteCommand',cmd);



% cmdstr = ['New / */Facility ','baozha'];
% invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);
% cmdstr = ['SetPosition */Facility/baozha Cartesian 3.83416394970000e+006 3.73002690740000e+006 3.51611678610000e+006' ];
% invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);
% baozha=(['' cd  '/kaboom/kaboom.mdl']);
% cmd=(['VO */Facility/baozha Model File "' baozha '"']);
% invoke(handles.activex1.Application,'ExecuteCommand',cmd);
% cmd=('VO * View FromTo FromRegName "STK Object" FromName "Facility/fashechang" ToRegName "STK Object" ToName "Facility/fashechang" ');
% invoke(handles.activex1.Application,'ExecuteCommand',cmd);

cmd=('VO */Missile/daodan DynDataText DataDisplay "LLA Position" Show On Position Left 1 Top 1 Font Small');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
cmd=('VO */Missile/daodan DynDataText DataDisplay "Yaw Pitch Roll" Show On Color yellow Position Left 1 Bottom 350 Font Small');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
% cmd=('VO * View FromTo FromRegName "STK Object" FromName "Missile/daodan" ToRegName "STK Object" ToName "Missile/daodan" ');
% invoke(handles.activex1.Application,'ExecuteCommand',cmd);
%%放大地图
cmd=('ReportCreate */Missile/daodan Type Export Style "LLA Position" File "D:\positon.txt" ');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
temp=importdata('D:\positon.txt');
data=temp.data;
[mm,nn]=size(data);
weidu1=data(1,1);
jingdu1=data(1,2);
haiba1=data(1,3);
weidu2=data(mm,1);
jingdu2=data(mm,2);
haiba2=data(mm,3);
zhongxinweidu=(weidu1+weidu2)/2;
zhongxinjingdu=(jingdu1+jingdu2)/2;
fanwei1=abs(jingdu1-zhongxinjingdu);
fanwei2=abs(weidu1-zhongxinweidu);
fanwei=max(fanwei1,fanwei2);
cmd=(['Zoom * LatLon ' num2str(zhongxinweidu) '  ' num2str(zhongxinjingdu) ' ' num2str(fanwei) ' 1']);
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
cmd=('VO * ViewerPosition 15 -15 20 2');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
cmd=('VO * GlobeDetails MapDetail Show On Map RWDB2_Coastlines  Map RWDB2_International_Borders ShowDetail ON  WindowID 2');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
cmd=('Lighting * Umbra Fill On FillColor "black" ');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);

[year,month,day,h,min,sec] = datevec(sjsj);
sj = datestr([year,month,day,h,min,(sec+num2str('3'))]);
shijian=datestr(sj,'dd mmm yyyy HH:MM:SS');

cmd=(['VO */Missile/daodan Articulate  "' sjsj '" 2 Flame Size 0 1 ']);
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
% cmd=(['VO */Facility/baozha Articulate  "' sjsj '" 3 Explode size 0 0 ']);
% invoke(handles.activex1.Application,'ExecuteCommand',cmd);
% cmd=(['VO */Facility/baozha Articulate  "' shijian '" 3 Explode size 0 3 ']);
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
cmd=('VO * View FromTo FromRegName "STK Object" FromName "Missile/daodan" ToRegName "STK Object" ToName "Missile/daodan" ');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);

cmd=('VO * ViewerPosition 145 55 10 2');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
cmdstr = ['Animate * Start'];
invoke(handles.activex1.Application,'ExecuteCommand',cmdstr);
cmd=('VO * View FromTo FromRegName "STK Object" FromName "Missile/daodan" ToRegName "STK Object" ToName "Missile/daodan" ');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
cmd=('VO * ViewerPosition 145 55 10 2');
invoke(handles.activex1.Application,'ExecuteCommand',cmd);
% 
% cmd=(['VO */Missile/daodan Articulate  "' shijian '" 10 Booster Drop 0 -100 ']);
% invoke(handles.activex1.Application,'ExecuteCommand',cmd);

% cmd=(['VO */Facility/fashechang Articulate  "' sjsj '" 3 Graple_a Pitch 0 -55']);
% invoke(handles.activex1.Application,'ExecuteCommand',cmd);
% cmd=(['VO */Facility/fashechang Articulate  "' sjsj '" 3 Graple_b Pitch 0 90']);
% invoke(handles.activex1.Application,'ExecuteCommand',cmd);
% 
% cmd=(['VO */Facility/fashechang Articulate  "' sjsj '" 1 Pad_flame_a Size 0 3']);
% invoke(handles.activex1.Application,'ExecuteCommand',cmd);
% cmd=(['VO */Facility/fashechang Articulate  "' sjsj '" 1 Pad_flame_b Size 0 3']);
% invoke(handles.activex1.Application,'ExecuteCommand',cmd);
% 
% cmd=(['VO */Facility/fashechang Articulate  "' shijian '" 1 Pad_flame_a Size 3 0']);
% invoke(handles.activex1.Application,'ExecuteCommand',cmd);
% cmd=(['VO */Facility/fashechang Articulate  "' shijian '" 1 Pad_flame_b Size 3 0']);
% invoke(handles.activex1.Application,'ExecuteCommand',cmd);


