%%% -------------------------------------------------------------------
%%% Author  :Joq
%%% Description : 
%%% HW controller for Tellstick DUO running on a raspberry Pi-2.
%%% The module handles the telldus deamon (Linux interface to telldus stick)
%%% Interface
%%% 1. restart : restart the telldus deamon 
%%% 2. get_all_info: reads all telldus info from telldus deamon using the 
%%%    the telldus command "tdtool --info"
%%% 3. set_state: used to set on/off to a device via telldus deamon
%%%    using the telldus command "tdtool --"++State++" "++Id" ex
%%%    "tdtool --on 1"
%%%
%%% To make the communicaton more secure the modul lib_chan is used.  
%%%
%%% Created : 12 February 2017
%%% 
%%% -------------------------------------------------------------------
-module(tellstick_service).
-behaviour(gen_server).

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
%-include("telldus_target.hlr").
%% --------------------------------------------------------------------

%% External exports
-export([restart/0,
	 get_all_info/0,
	 read_sensor/1,
	 read_device/1,
	 set_device/2,
	 start/0,
	 stop/0]).
%% gen_server callbacks
-export([init/1, handle_call/3,handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-record(state, {}).

%% ====================================================================
%% External functions
%% ====================================================================
start()-> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
stop()-> gen_server:call(?MODULE, {stop},infinity).

restart()->
      gen_server:call(?MODULE, {restart},infinity).  
get_all_info()->
    gen_server:call(?MODULE, {get_all_info},infinity).
set_device(Id,Value)->
     gen_server:call(?MODULE, {set_device,Id,Value},infinity).
read_device(Id)->
     gen_server:call(?MODULE, {read_device,Id},infinity).
read_sensor(Id)->
     gen_server:call(?MODULE, {read_sensor,Id},infinity).

%% ====================================================================
%% Server functions
%% ====================================================================

%% --------------------------------------------------------------------
%% Function: init/1
%% Description: Initiates the server
%% Returns: {ok, State}          |
%%          {ok, State, Timeout} |
%%          ignore               |
%%          {stop, Reason}
%% --------------------------------------------------------------------
init([]) ->
    os:cmd("sudo /etc/init.d/telldusd restart"),
    io:format("Started ~p~n",[{?MODULE,?LINE}]),
   {ok, #state{}}.

%% --------------------------------------------------------------------
%% Function: handle_call/3
%% Description: Handling call messages
%% Returns: {reply, Reply, State}          |
%%          {reply, Reply, State, Timeout} |
%%          {noreply, State}               |
%%          {noreply, State, Timeout}      |
%%          {stop, Reason, Reply, State}   | (terminate/2 is called)
%%          {stop, Reason, State}            (terminate/2 is called)
%% --------------------------------------------------------------------
handle_call({restart}, _From, State) ->
    Reply=os:cmd("sudo /etc/init.d/telldusd restart"),
 %   io:format("~p~n",["sudo /etc/init.d/telldusd restart"]),
 %   Reply=ok,
    {reply, Reply, State};


handle_call({read_sensor,Id}, _From, State) ->
    Reply=rpc:call(node(),tellstick,read_sensor,[Id]),
    {reply, Reply, State};

handle_call({read_device,Id}, _From, State) ->
    Reply=rpc:call(node(),tellstick,read_device,[Id]),
    {reply, Reply, State};

handle_call({set_device,Id,Value}, _From, State) ->
    Reply=rpc:call(node(),tellstick,set_device,[Id,Value]),
    {reply, Reply, State};

handle_call({get_all_info}, _From, State) ->
    Reply=rpc:call(node(),tellstick,get_all_info,[]),
    {reply, Reply, State};

handle_call({stop}, _From, State) ->
    {stop, normal, shutdown_ok, State};

handle_call(Request, From, State) ->
    Reply = {unmatched_signal,?MODULE,Request,From},
    {reply, Reply, State}.

%% --------------------------------------------------------------------
%% Function: handle_cast/2
%% Description: Handling cast messages
%% Returns: {noreply, State}          |
%%          {noreply, State, Timeout} |
%%          {stop, Reason, State}            (terminate/2 is called)
%% --------------------------------------------------------------------

handle_cast(Msg, State) ->
    io:format("unmatched match cast ~p~n",[{Msg,?MODULE,time()}]),
    {noreply, State}.

%% --------------------------------------------------------------------
%% Function: handle_info/2
%% Description: Handling all non call/cast messages
%% Returns: {noreply, State}          |
%%          {noreply, State, Timeout} |
%%          {stop, Reason, State}            (terminate/2 is called)
%% --------------------------------------------------------------------
handle_info(_Info, State) ->
    {noreply, State}.

%% --------------------------------------------------------------------
%% Function: terminate/2
%% Description: Shutdown the server
%% Returns: any (ignored by gen_server)
%% --------------------------------------------------------------------
terminate(_Reason, _State) ->
    ok.

%% --------------------------------------------------------------------
%% Func: code_change/3
%% Purpose: Convert process state when code is changed
%% Returns: {ok, NewState}
%% --------------------------------------------------------------------
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% --------------------------------------------------------------------
%%% Internal functions
%% --------------------------------------------------------------------

    
%% --------------------------------------------------------------------
%%% 

%% --------------------------------------------------------------------
%% Function: tick/1
%% Description:if needed creates dets file with name ?MODULE, and
%% initates the debase
%% Returns: non
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% Function: tick/1
%% Description:if needed creates dets file with name ?MODULE, and
%% initates the debase
%% Returns: non
%% --------------------------------------------------------------------
