#!/usr/bin/env swipl

:- ['../names'].
:- ['conv-mems'].
:- ['conv-times'].
:- ['elab-mems'].
:- ['elab-times'].

:- initialization(main, main).

name_time(NAME, TIME) :- 
  conv_time(NAME, CT),
  elab_time(NAME, ET),
  TIME is CT + ET.

name_mem(NAME, MEM) :- 
  conv_mem(NAME, CM),
  elab_mem(NAME, EM),
  max_list([CM, EM], MEM).
  
bar(NUM, [TIME | TIMES]) :- 
  format("(~w, ~w) ", [TIME, NUM]), 
  SUC is NUM + 1, 
  bar(SUC, TIMES).
bar(_, []).

main :-
  findall(NAME, name(NAME), NAMES), 
  maplist(name_mem, NAMES, MEMS),
  % findall(TIME, elab_time(_, TIME), TIMES),
  sort(0, @=<, MEMS, SORTED),
  bar(1, SORTED).

