#!/usr/bin/env swipl

:- ['names'].

:- ['conv-times'].
:- ['elab-times'].
:- ['dpr-trim-times'].

:- ['conv-mems'].
:- ['dpr-trim-mems'].
:- ['elab-mems'].

:- ['frat-sizes'].
:- ['temp-sizes'].
:- ['lpr-sizes'].
:- ['lrat-sizes'].

:- initialization(main, main).

find_sum(GOAL, SUM) :- 
  findall(X, call(GOAL, _, X), XS), 
  sum_list(XS, SUM).

main :- 
  find_sum(conv_time, CT),
  find_sum(elab_time, ET),
  FT is ET + CT, 
  find_sum(dpr_trim_time, DT),

  format("Conv time = ~w\n", [CT]),
  format("Elab time = ~w\n", [ET]),
  format("frat-rs time = ~w\n", [FT]),
  format("dpr-trim time = ~w\n", [DT]),

  find_sum(dpr_trim_mem, DM),
  find_sum(conv_mem, CM),
  find_sum(elab_mem, EM),

  format("dpr-trim mem = ~w\n", [DM]),
  format("Conv mem = ~w\n", [CM]),
  format("Elab mem = ~w\n", [EM]),

  find_sum(frat_size, FS), 
  find_sum(temp_size, TS), 
  find_sum(lrat_size, LRS), 
  find_sum(lpr_size, LPS), 

  format("FRAT size = ~w\n", [FS]),
  format("Temp size = ~w\n", [TS]),
  format("LRAT size = ~w\n", [LRS]),
  format("LPR size = ~w\n", [LPS]),

  true.

  

  
