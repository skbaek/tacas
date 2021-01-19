#!/usr/bin/env swipl

:- initialization(main, main).
:- [basic, problems, lrat_from_frat_check_times].

result_exists(NUM) :- lrat_from_frat_check_time(NUM, _), !.

test_lrat_to_verif(NUM) :- 
  num_name(NUM, NAME), !,
  format(string(LRAT), "./lrats/~w.lrat", [NAME]), !,

  format("Checking problem = ~w with lrat-check...\n", [NAME]), !,
  format_shell("pigz -kd ~w.gz", [LRAT], 0), !,
  (
    goal_time(format_shell("lrat-check $CNF/~w.cnf ~w", [NAME, LRAT], 0), TIME) ->
    add_entry('lrat_from_frat_check_times.pl', lrat_from_frat_check_time(NUM, TIME))
  ;
    add_entry('lrat_from_frat_check_times.pl', lrat_from_frat_check_time(NUM, failed))
  ),
  delete_file(LRAT), !.

main(ARGS) :-
  select_nums(result_exists, ARGS, NUMS),
  write_list(NUMS), !,
  cmap(test_lrat_to_verif, NUMS).