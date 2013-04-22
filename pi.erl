-module(pi).
-export([run/0, swarm/3, calc/2, sumup/2]).
-define(Max, 10000000).

sumup(Sum, Max) when Max > 0 ->
	receive
		{add, X} ->
			sumup(Sum + X, Max - 1)
	end;

sumup(Sum, 0) ->
	Res = Sum / ?Max,
	io:format("PI = ~w~n", [Res]),
	finish.

calc(PID, {N, C, Sum}) ->
	X = (N + 0.5) / ?Max,
	Delta = 4 / (1 + X * X),
	Temp = Sum + Delta,
	if
		C == 1 ->
			PID ! {add, Temp};
		C > 1 ->
			calc(PID, {N + 1, C - 1, Temp})
	end.

swarm(N, Actors, PID) when N > 0 ->
	Delta = ?Max / Actors,
	Args = {(N - 1) * Delta, Delta, 0},
	spawn(pi, calc, [PID, Args]),
	io:format("Spawned ~w~n", [N]),
	swarm(N - 1, Actors, PID);

swarm(0, _, _) ->
	spawn_finished.


run() ->
	Actors = 100,
	PID = spawn(pi, sumup, [0, Actors]),
	swarm(Actors, Actors, PID).