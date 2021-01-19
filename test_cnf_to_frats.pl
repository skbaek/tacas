#!/usr/bin/env swipl

:- initialization(main, main).
:- [basic, problems, cnf_to_frat_times].

result_exists(NUM) :- cnf_to_frat_time(NUM, _), !.

test_cnf_to_frat(NUM) :- 
  num_name(NUM, NAME),
  format(string(TEMP), "~w.temp", [NAME]),
  format(string(FRAT), "./frats/~w.frat", [NAME]),
  format("Solving problem = ~w with Hackdical...\n", [NAME]),
  format(string(CMD), "cadical -q -t 20000 $CNF/~w.cnf ~w --lrat=true", [NAME, TEMP]),
  (
    goal_time(shell(CMD, 20), TIME) ->
    size_file(TEMP, SIZE), 
    add_entry('frat_sizes.pl', frat_size(NUM, SIZE)),
    add_entry('cnf_to_frat_times.pl', cnf_to_frat_time(NUM, TIME)),
    format_shell("cp ~w ~w", [TEMP, FRAT], 0),
    format_shell("pigz ~w", [FRAT], 0)
  ;
    add_entry('frat_sizes.pl', frat_size(NUM, failed)),
    add_entry('cnf_to_frat_times.pl', cnf_to_frat_time(NUM, failed))
  ),
  format_shell("rm ~w", [TEMP], 0).

main(ARGS) :-
  select_nums(result_exists, ARGS, NUMS),
  write_list(NUMS), !,
  cmap(test_cnf_to_frat, NUMS).