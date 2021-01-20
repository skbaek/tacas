#!/usr/bin/env swipl
:- initialization(main, main).
:- [results].

num_frat_total_time(NUM, TIME) :- 
  cnf_to_frat_time(NUM, X),
  frat_to_lrat_time(NUM, Y), 
  TIME is X + Y.

num_drat_total_time(NUM, TIME) :- 
  cnf_to_drat_time(NUM, X),
  drat_to_lrat_time(NUM, Y), 
  TIME is X + Y.

main :-
  range(1, 97, RNG), 
  delete(RNG, 38, NUMS),
  cmap(drat_to_lrat_time, NUMS, DRAT_ELAB_TIMES),
  cmap(frat_to_lrat_time, NUMS, FRAT_ELAB_TIMES),
  cmap(num_drat_total_time, NUMS, DRAT_TOTAL_TIMES),
  cmap(num_frat_total_time, NUMS, FRAT_TOTAL_TIMES),
  % format("drat_elab_times = ~w\n",  [DRAT_ELAB_TIMES]),
  % format("frat_elab_times = ~w\n",  [FRAT_ELAB_TIMES]),
  % format("drat_total_times = ~w\n", [DRAT_TOTAL_TIMES]),
  % format("frat_total_times = ~w\n", [FRAT_TOTAL_TIMES]).
  sum_list(DRAT_TOTAL_TIMES, DRAT_ALL), 
  sum_list(FRAT_TOTAL_TIMES, FRAT_ALL), 
  RATIO is FRAT_ALL / DRAT_ALL, 
  format("TIME FOR ALL DRAT = ~w\n", DRAT_ALL),
  format("TIME FOR ALL FRAT = ~w\n", FRAT_ALL),
  format("RATIO = ~w\n", RATIO),
  true.
  