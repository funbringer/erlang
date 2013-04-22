-module(last).
-export([show_last/1]).

show_last([]) ->
	empty;
show_last([A]) ->
	A;
show_last([_, Last]) ->
	Last;
show_last([_ | Tail]) ->
	show_last(Tail).