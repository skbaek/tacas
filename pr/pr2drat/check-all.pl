#!/usr/bin/env swipl
:- [names].
:- ['~/projects/prelude/main'].
:- initialization(main, main).

check_lpr(NAME) :- 
  format('Checking problem = ~w\n', [NAME]),
  format_shell('cake_lpr ./cnfs/~w.cnf ./lprs/~w.lpr', [NAME, NAME], 0).

check_lrat(NAME) :- 
  format('Checking problem = ~w\n', [NAME]),
  format_shell('cake_lpr ./cnfs/~w.cnf ./lrats/~w.lrat', [NAME, NAME], 0).

main([lrat]) :-
  findall(NAME, name(NAME), NAMES), 
  fa_elem_cut(check_lrat, NAMES).

main([lpr]) :-
  findall(NAME, name(NAME), NAMES), 
  fa_elem_cut(check_lpr, NAMES).


