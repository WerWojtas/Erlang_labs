%%%-------------------------------------------------------------------
%%% @author weron
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 08. mar 2024 13:19
%%%-------------------------------------------------------------------
-module(calculator).
-author("weron").

%% API
-export([calculate_max/2, number_of_readings/2, calculate_mean/2]).

-define(parTup, {pm10,pm2_5,pm1,temp,humid,hPa,wind}).

is_data({_,Date,_,_},Date) -> 1.

number_of_readings([],_) -> 0;
number_of_readings([H|T], Date) -> is_data(H,Date) + number_of_readings(T,Date);
number_of_readings(_,_) -> io:format("Error occured: wrong arguments~n").

ret_list({_,_,_,List}) -> List;
ret_list(_) -> io:format("Error occured: arg 0 is not {_,_,_,List} type~n").

in_tuple(Elem,Tuple) when is_tuple(Tuple) ->
  in_tuple(1,Elem,Tuple, tuple_size(Tuple)+1).
in_tuple(Index,_,_,Index) -> false;
in_tuple(Index,Elem,Tuple,Tup_size) ->
  case element(Index,Tuple) of
    Elem -> true;
    _ -> in_tuple(Index+1,Elem,Tuple,Tup_size)
  end.

get_parameter([],_) -> 0;
get_parameter([{Type,Num}|_],Type) -> Num;
get_parameter([_|T], Par) -> get_parameter(T,Par).

calculate_max([],_) -> 0;
calculate_max([H|T],Type) ->
  case in_tuple(Type,?parTup) of
    false -> io:format("Error occured: wrong Type~n");
    true -> calculate_max(T,Type,get_parameter(ret_list(H),Type))
  end.
calculate_max([], _, Max) -> Max;
calculate_max([H|T],Type,Max) ->
  calculate_max(T,Type,max(Max,get_parameter(ret_list(H), Type))).



calculate_mean([],_) -> io:format("Error occured: empty list~n");
calculate_mean([H|T],Type) ->
  case in_tuple(Type,?parTup) of
    false -> io:format("Error occured: wrong Type~n");
    true -> (get_parameter(ret_list(H), Type) + calculate_mean(T,Type,sum))/(length(T)+1)
  end.
calculate_mean([], _, sum) -> 0;
calculate_mean([H|T], Type, sum) ->
  get_parameter(ret_list(H), Type) + calculate_mean(T,Type,sum).

