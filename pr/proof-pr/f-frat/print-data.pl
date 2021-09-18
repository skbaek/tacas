#!/usr/bin/env swipl

:- ['../names'].
% :- ['conv-mems'].
% :- ['conv-times'].
:- ['elab-mems'].
:- ['elab-times'].

:- initialization(main, main).

bar(NUM, [TIME | TIMES]) :- 
  format("(~w, ~w) ", [TIME, NUM]), 
  SUC is NUM + 1, 
  bar(SUC, TIMES).
bar(_, []).

main :-
  findall(TIME, elab_mem(_, TIME), TIMES), 
  sort(0, @=<, TIMES, SORTED),
  bar(1, SORTED).

