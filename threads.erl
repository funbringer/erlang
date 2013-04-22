-module(threads).
-export([start/0, ping/2, pong/0, receiver/0,
	send/0, foo/0, bar/1, run/0]).

% Example #1
receiver() ->
	receive
		finish ->
			io:format("finished~n", []);
		again ->
			receiver()
	after
		6000 ->
			io:format("error~n", [])
	end,
	io:format("hello~n", []).

send() ->
	PID = spawn(threads, receiver, []),
	PID ! again,
	PID ! finish,
	ok.


% Example #2
ping(0, Pong_PID) ->
	Pong_PID ! finished,
	io:format("Ping finished~n", []);
	
ping(N, Pong_PID) ->
	Pong_PID ! {ping, self()},
	receive
		pong ->
			io:format("Ping: received message from pong~n", [])
	end,
	ping(N - 1, Pong_PID).

pong() ->
	receive
		finished ->
			io:format("Pong finished~n", []);
		{ping, Ping_PID} ->
			io:format("Pong: received message from ping~n", []),
			Ping_PID ! pong,
			pong()
	end.

start() ->
	Pong_PID = spawn(threads, pong, []),
	spawn(threads, ping, [3, Pong_PID]).


% Example #3
foo() ->
	io:format("foo started~n"),
	receive
		{data, PID, X} ->
			io:format("Caller: ~w, data: ~w~n", [PID, X]),
			PID ! {result, (X / 2)},
			foo();
		finish ->
			io:format("foo finished~n")
	end.

bar(PID) ->
	PID ! {data, self(), 4},
	receive
		{result, X} ->
			io:format("bar: received ~w~n", [X])
	end.

run() ->
	PID = spawn(threads, foo, []),
	bar(PID),
	bar(PID),
	PID ! finish.