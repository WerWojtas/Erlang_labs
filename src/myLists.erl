%%%-------------------------------------------------------------------
%%% @author weron
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. mar 2024 12:38
%%%-------------------------------------------------------------------
-module(myLists).
-author("weron").

%% API
-export([contains1/2, contains2/2, duplicateElements/1, sumFloats/1, sumFloatsTail/2]).

contains1([],_) -> false;
contains1([H|T],X) ->
  if H=:=X -> true;
  true -> contains1(T,X)
  end.

contains2([],_) -> false;
contains2([X|_],X) -> true;
contains2([_|T],X) -> contains2(T,X).

duplicateElements([]) -> [];
duplicateElements([H|T]) -> [H ++ H | duplicateElements(T)].

sumFloats([]) -> 0;
sumFloats([H|T]) when is_float(H) -> H+ sumFloats(T);
sumFloats([_|T]) -> sumFloats(T).

sumFloatsTail([], Sum) -> Sum;
sumFloatsTail([H|T], Sum) when is_float(H) -> sumFloatsTail(T,H+Sum);
sumFloatsTail([_|T], Sum) -> sumFloatsTail(T,Sum).


