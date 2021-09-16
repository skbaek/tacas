#!/usr/bin/env swipl
:- [names].
:- ['~/projects/prelude/main'].
:- initialization(main, main).

check(PATH, NAME) :- 
  format('Checking problem = ~w\n', [NAME]),
  format_shell('cake_lpr ./cnfs/~w.cnf ./~w/lrats/~w.lrat', [NAME, PATH, NAME], 0).

main([PATH]) :-
  format("Checking elab path = ~w\n\n", [PATH]),
  findall(NAME, name(NAME), NAMES), 
  fa_elem_cut(check(PATH), NAMES).