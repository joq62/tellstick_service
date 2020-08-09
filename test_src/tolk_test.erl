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
-export([start/0]).
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
    io:format("~p~n",[{?LINE,rpc:call('varmdo_1@rpi2',tolk,read_sensor,["Huset"])}]),    
    init:stop(),
    ok.
