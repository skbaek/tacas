#!/usr/bin/env swipl
:- [names].
:- ['~/projects/prelude/main'].
:- initialization(main, main).

check('dpr-trim', NAME) :- 
  format('Checking problem = ~w\n', [NAME]),
  format_shell('cake_lpr ./cnfs/~w.cnf ./dpr-trim/lprs/~w.lpr', [NAME, NAME], 0).

check('d-frat', NAME) :- 
  format('Checking problem = ~w\n', [NAME]),
  format_shell('cake_lpr ./cnfs/~w.cnf ./d-frat/lrats/~w.lrat', [NAME, NAME], 0).

check('f-frat', NAME) :- 
  format('Checking problem = ~w\n', [NAME]),
  format_shell('cake_lpr ./cnfs/~w.cnf ./f-frat/lrats/~w.lrat', [NAME, NAME], 0).

main([PATH]) :-
  format("Checking elab path = ~w\n\n", [PATH]),
  findall(NAME, name(NAME), NAMES), 
  fa_elem_cut(check(PATH), NAMES).


