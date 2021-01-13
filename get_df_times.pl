#!/usr/bin/env swipl

:- initialization(main, main).
:- [prelude, problems, df_times, paths].

result_exists(NUM) :- num_df_time(NUM, _), !.

get_df_time(NUM) :- 
  num_name(NUM, NAME),
  format("Solving problem = ~w with Hackdical...", [NAME]),
  hackdical(HACK), 
  cnf(CNF), 
  format(string(CMD), "~w -t 20000 ~w~w.cnf temp.frat --lrat=true", [HACK, CNF, NAME]),
  (
    goal_time(shell(CMD, 20), TIME) ->
    add_entry('df_times.pl', num_df_time(NUM, passed(TIME))),
    format_shell("cp temp.frat frats/~w.frat", [NAME], 0)
  ;
    add_entry('df_times.pl', num_df_time(NUM, failed))
  ),
  shell("rm temp.frat", 0).

main :-
  range(1, 97, RANGE),
  exclude(result_exists, RANGE, NUMS),
  write_list(NUMS), !,
  cmap(get_df_time, NUMS).