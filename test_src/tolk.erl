%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Created : 7 March 2015
%%% Revsion : 2015-06-19: 1.0.0 :  Created
%%% Description :

%%% -------------------------------------------------------------------
-module(tolk).

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-include_lib("eunit/include/eunit.hrl").

%% --------------------------------------------------------------------
%% Definitions
%% --------------------------------------------------------------------


%% --------------------------------------------------------------------
%% External exports
%% --------------------------------------------------------------------
-export([start/0]).
%%
%% API Functions
%%
-define(DEVICES,[{"1","ej anvand"},
		  {"2","element_koket"},
		  {"3","ej anvand"},
		  {"4","lampa 2 hall huset"},
		  {"5","element_vardagsrum"},
		  {"6","lampa 1 hall huset"}]).
-define(SENSORS,[{"167","Uterummet"},{"248","Utomhus"},{"247","Huset inne"}]).
%% --------------------------------------------------------------------
%% Function: fun/x
%% Description: fun x skeleton 
%% Returns:ok|error
%% --------------------------------------------------------------------
start()->
    A=rpc:call('varmdo_1@rpi2',tellstick_service,get_all_info,[]),
    B=string:tokens(A,"\n\t"),
    %Get Num Devices
    [NumDevStr|T1]=B,
    [_,NumStrInfo]=string:tokens(NumDevStr,":"),
    [NumStr]=string:tokens(NumStrInfo," "),
    NumDev=list_to_integer(NumStr),
    % Get device info
    {DeviceInfo,T}=device(T1,NumDev,0,[]),

    %Get sensor info
    X1=[string:tokens(Str," ")||Str<-T],
    X=lists:append(X1),
    SensorInfo=sensor(X,[]),
    


    R=[{device_info,DeviceInfo},{sensor_info,SensorInfo}],
    io:format("Result ~p~n",[R]),
    
    init:stop(),
    ok.
sensor([],SensorInfo)->
    
    SensorInfo;
sensor(["temperature",Id,Temp|T],Acc)->
    NewId=case lists:keyfind(Id,1,?SENSORS) of
	      false->
		  "not found";
	      {Id,NewId1}->
		  NewId1
	  end,
    sensor(T,[{NewId,Temp}|Acc]);
sensor(["temperaturehumidity",Id,Temp,Humidity|T],Acc) ->
   NewId=case lists:keyfind(Id,1,?SENSORS) of
	      false->
		  "not found";
	      {Id,NewId1}->
		  NewId1
	  end,
    sensor(T,[{NewId,Temp,Humidity}|Acc]);
sensor([_|T],Acc) ->
    sensor(T,Acc).

device(T,NumDev,NumDev,DeviceInfo)->
    {lists:reverse(DeviceInfo),T};
device([Num,Id,State|T],NumDev,N,Acc) ->
    NewId=case lists:keyfind(Num,1,?DEVICES) of
	      false->
		  "not found";
	      {Num,NewId1}->
		  NewId1
	  end,
    device(T,NumDev,N+1,[{Num,NewId,State}|Acc]).


%"Number of devices: 6",
%  Nr,       Name,                             State
% "1",      "glurk_1",                         "OFF",
% "2", "vaermdo_main_kitchen_heater_1",        "ON",
% "3",       "glurk_3",                        "OFF",
% "4", "vaermdo_main_entrance_indoor_lamp_2",  "ON",
% "5", "vaermdo_main_livingroom_heater_1",     "ON",
% "6", "vaermdo_main_entrance_indoor_lamp_1",  "OFF",

%"SENSORS:",
%  "PROTOCOL",  "MODEL","ID", "TEMP ","HUMIDITY","LAST UPDATED","fineoffset",
%"temperaturehumidity ","167  ","22.7°","65%",  "2020-08-08 00:20:13 ","fineoffset",
% "temperature",        "248  ","15.8°","        ","2020-08-08 00:19:48 ","fineoffset",
%"temperaturehumidity ","247  ","23.9°","55%     ","2020-08-08 00:20:48 "
