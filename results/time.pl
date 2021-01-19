#!/usr/bin/env swipl

:- initialization(main, main).

:- ["/home/sk/prelude", problems, results].

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
  format("drat_elab_times = ~w\n",  [DRAT_ELAB_TIMES]),
  format("frat_elab_times = ~w\n",  [FRAT_ELAB_TIMES]),
  format("drat_total_times = ~w\n", [DRAT_TOTAL_TIMES]),
  format("frat_total_times = ~w\n", [FRAT_TOTAL_TIMES]).
  