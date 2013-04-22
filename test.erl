-module(test).
-export([dummy/0, factorial/1, convert/1, list_len/1,
	list_max/1, reverse/1, is_odd/1, month_len/2]).

% Example #0
dummy() ->
	ok.


% Example #1
factorial(0) ->
	1;

factorial(N) ->
	N * factorial(N - 1).


% Example #2
convert({m, X}) ->
	{cm, X * 100};

convert({cm, X}) ->
	{m, X / 100}.


% Example #3
list_len([]) ->
	0;

list_len([_ | Rest]) ->
	1 + list_len(Rest).


% Example #4
list_max([First | Rest]) ->
	list_max(Rest, First).

list_max([], Max) ->
	Max;
	
list_max([First | Rest], Max) when First > Max ->
	list_max(Rest, First);

list_max([_ | Rest], Max) ->
	list_max(Rest, Max).


% Example #5
reverse(List) ->
	reverse(List, []).

reverse([Head | Rest], Reversed_List) ->
	reverse(Rest, [Head | Reversed_List]);

reverse([], Reversed_List) ->
	Reversed_List.


% Example #6
is_odd(X) ->
	if
		X rem 2 == 0 ->
			even;
		true ->
			odd
	end.


% Example #7
month_len(Year, Month) ->
	Leap = if
		(Year rem 4 == 0) and (Year rem 100 /= 0) ->
			leap;
		Year rem 400 == 0 ->
			leap;
		true ->
			not_leap
	end,
	case Month of
		jan -> 31;
		feb when Leap == leap -> 29;
		feb -> 28;
		mar -> 31;
		apr -> 30;
		may -> 31;
		jun -> 30;
		jul -> 31;
		aug -> 31;
		sep -> 30;
		oct -> 31;
		nov -> 30;
		dec -> 31
	end.


