%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Created : 7 March 2015
%%% Revsion : 2015-06-19: 1.0.0 :  Created
%%% Description :

%%% -------------------------------------------------------------------
-module(test1).

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
    ok=t1_test(),
    ok=t2_test(),
    ok=t2_test(),
%    ok=t3_test(),
    init:stop(),
    ok.
t1_test()->
    ok=application:start(tellstick_service),
    ?assertEqual(ok,tellstick_service:restart()),
    ok.

t2_test()->	
    ?assertEqual(ok,tellstick_service:get_all_info()),    
    ok.
    

%%
%% Local Functions
%%
%% --------------------------------------------------------------------
%% Function: fun/x
%% Description: fun x skeleton 
%% Returns:ok|error
%% --------------------------------------------------------------------
