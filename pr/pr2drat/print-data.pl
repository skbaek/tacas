#!/usr/bin/env swipl

:- [names].
% :- ['conv-times'].
% :- ['elab-times'].
% :- ['dpr-trim-times'].
:- ['conv-mems'].
:- ['elab-mems'].
:- ['dpr-trim-mems'].
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
  % write("CONV:\n"), 
  % findall(X, conv_mem(_, X), XS), 
  % write(XS),
  % write("ELAB:\n"), 
  % findall(Y, elab_mem(_, Y), YS), 
  % write(YS),

  % findall(NAME, name(NAME), NAMES), 
  % maplist(name_mem, NAMES, MEMS),
  findall(MEM, dpr_trim_mem(_, MEM), MEMS),
  sort(0, @=<, MEMS, SORTED),
  bar(1, SORTED).

