#!/usr/bin/env swipl

:- initialization(main, main).
:- [prelude, problems, lf_check_times].

result_exists(NUM) :- num_lf_check_time(NUM, _), !.
  
get_lf_check_time(NUM) :- 
  num_name(NUM, NAME), !,
  format("Checking problem = ~w with lrat-check...", [NAME]), !,
  (
    goal_time(format_shell("lrat-check $CNF/~w.cnf ./lrats/~w.lrat", [NAME, NAME], 0), TIME) ->
    add_entry('lf_check_times.pl', num_lf_check_time(NUM, passed(TIME)))
  ;
    add_entry('lf_check_times.pl', num_lf_check_time(NUM, failed))
  ).

main :-
  range(1, 97, RANGE),
  exclude(result_exists, RANGE, NUMS),
  write_list(NUMS), !,
  cmap(get_lf_check_time, NUMS).