%%%-------------------------------------------------------------------
%%% @author weron
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 08. mar 2024 10:21
%%%-------------------------------------------------------------------
-module(data).
-import(rand, [uniform/1]).
-import(lists, [seq/2,nth/2]).
-author("weron").

%% API
-export([generateLines/2]).

-define(parameterTuple, { {pm10,20,10}, {pm2_5,20,10}, {pm1,10,10}, {temp,30,0}, {humid,70,15}, {hPa,24,1000}, {wind,25,0} }).

generateName(0,[H|T]) -> [H|T];
generateName(Lenght,[]) -> generateName(Lenght-1, [rand:uniform(25)+65]);
generateName(Lenght, List) -> generateName(Lenght-1, List ++ [rand:uniform(25)+97]).

generateDate() -> {rand:uniform(30), rand:uniform(12), rand:uniform(4)+2020}.
generateTime() -> {rand:uniform(24), rand:uniform(60)}.

generateIndexes(0,_,List) -> List;
generateIndexes(Num,ListInd,List) ->
  X = lists:nth(rand:uniform(length(ListInd)), ListInd),
  generateIndexes(Num-1,ListInd -- [X],List ++ [X]).


generateElement(Ind) -> element(Ind,?parameterTuple).

generateParameters(0,[],[]) ->  generateParameters(rand:uniform(3)+3,[],[]);
generateParameters(0,_,[H|T]) -> [H|T];
generateParameters(Num,[],List) -> generateParameters(Num,generateIndexes(Num,[X || X <- lists:seq(1,Num)],[]),List);
generateParameters(Num,[H|T],List) ->
  {Name, Range, Plus} = generateElement(H),
  generateParameters(Num-1,T,List ++ [{Name, rand:uniform(Range)+ Plus}]).

generateLine() -> { generateName(rand:uniform(10),[]), generateDate(), generateTime(), generateParameters(0,[],[])}.

generateLines(0,List) -> List;
generateLines(Num,List) -> generateLines(Num-1,List ++ [generateLine()]).

