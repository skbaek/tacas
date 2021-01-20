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
  cmap(drat_to_lrat_mem, NUMS, DRAT_MEMS),
  cmap(frat_to_lrat_mem, NUMS, FRAT_MEMS),
  format("drat_mems = ~w\n", [DRAT_MEMS]),
  format("frat_mems = ~w\n", [FRAT_MEMS]).
  