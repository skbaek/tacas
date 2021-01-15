#!/usr/bin/env swipl

:- initialization(main, main).
:- [prelude, problems, paths, fl_times, fl_mems, temp_sizes].

read_time(String, Time) :- 
  string_concat("\tUser time (seconds): ", TimeString, String),
  number_string(Time, TimeString).

read_mem(String, PeakMem) :-
  string_concat("\tMaximum resident set size (kbytes): ", PeakMemStr, String), 
  number_string(PeakMem, PeakMemStr).

result_exists(NUM) :- num_fl_time(NUM, _), !.

get_fl(NUM) :- 
  num_name(NUM, NAME),
  format("Processing problem = ~w\n", [NAME]),
  cnf(CNF),
  frat_rs(FRAT_RS),
  format(string(FRAT), "./frats/~w.frat", [NAME]),
  format(string(TEMP), "~w.temp", [FRAT]),
  format(string(LRAT), "./lrats/~w.lrat", [NAME]),
  format_shell("time -v ~w elab ~w~w.cnf ~w ~w 1>> stdout.txt 2> measure", [FRAT_RS, CNF, NAME, FRAT, LRAT], 0),
  read_item(read_time, "measure", TIME),
  read_item(read_mem, "measure", MEM),
  size_file(TEMP, TEMP_SIZE), 
  size_file(LRAT, LRAT_SIZE), !, 
  add_entry('fl_times.pl', num_fl_time(NUM, passed(TIME))),
  add_entry('fl_mems.pl', num_fl_mem(NUM, passed(MEM))),
  add_entry('temp_sizes.pl', num_temp_size(NUM, passed(TEMP_SIZE))),
  add_entry('lf_sizes.pl', num_lf_size(NUM, passed(LRAT_SIZE))),
  delete_file(FRAT), 
  delete_file(TEMP),
  delete_file("measure"),
  delete_file("stdout.txt").
  
get_fl(NUM) :- 
  add_entry('fl_times.pl', num_fl_time(NUM, failed)),
  add_entry('fl_mems.pl', num_fl_mem(NUM, failed)),
  add_entry('temp_sizes.pl', num_temp_size(NUM, failed)),
  add_entry('lf_sizes.pl', num_lf_size(NUM, failed)).

main :-
  range(1, 97, RANGE),
  exclude(result_exists, RANGE, NUMS),
  write_list(NUMS), !,
  cmap(get_fl, NUMS).