#!/usr/bin/env swipl

:- ['../names'].
:- [mems, times, sizes].
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
  findall(TIME, dpr_trim_time(_, TIME), TIMES), 
  sort(0, @=<, TIMES, SORTED),
  bar(1, SORTED).

