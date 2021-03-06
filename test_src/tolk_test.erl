%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Created : 7 March 2015
%%% Revsion : 2015-06-19: 1.0.0 :  Created
%%% Description :

%%% -------------------------------------------------------------------
-module(tolk_test).

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
-export([start/0,dev/1]).
%%
%% API Functions
%%

%% --------------------------------------------------------------------
%% Function: fun/x
%% Description: fun x skeleton 
%% Returns:ok|error
%% --------------------------------------------------------------------
start()->
    io:format("~p~n",[{?LINE,rpc:call('varmdo_1@rpi2',tellstick_service,get_all_info,[])}]),
    io:format("~p~n",[{?LINE,rpc:call('varmdo_1@rpi2',tellstick_service,read_sensor,["Huset"])}]),    
    io:format("~p~n",[{?LINE,rpc:call('varmdo_1@rpi2',tellstick_service,read_device,["element_koket"])}]),    
    ok.
dev(Value)->
    io:format("~p~n",[{?LINE,rpc:call('varmdo_1@rpi2',tellstick_service,set_device,["element_koket",Value])}]),   
    io:format("~p~n",[{?LINE,rpc:call('varmdo_1@rpi2',tellstick_service,read_device,["element_koket"])}]),
    ok.
