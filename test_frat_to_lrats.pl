#!/usr/bin/env swipl

:- initialization(main, main).
:- [basic, problems, frat_to_lrat_times].

read_time(String, Time) :- 
  string_concat("\tUser time (seconds): ", TimeString, String),
  number_string(Time, TimeString).

read_mem(String, PeakMem) :-
  string_concat("\tMaximum resident set size (kbytes): ", PeakMemStr, String), 
  number_string(PeakMem, PeakMemStr).

s_to_ms(S, MS) :- MS is round(S * 1000).

test_frat_to_lrat(NUM) :- 
  num_name(NUM, NAME),
  format("Processing problem = ~w\n", [NAME]),
  format(string(FRAT), "./frats/~w.frat", [NAME]),
  format(string(FRAT_ZIP), "~w.gz", [FRAT]),
  format(string(TARF), "~w.temp", [FRAT]),
  format(string(LRAT), "./lrats/~w.lrat", [NAME]), !,
  format(string(LRAT_TEMP), "./~w.lrat", [NAME]), !,

  format_shell("pigz -kd ~w", [FRAT_ZIP], 0), !,

  % FRAT_ZIP, FRAT 

  format_shell("time -v $FRAT/target/release/frat-rs elab $CNF/~w.cnf ~w ~w 1>> stdout.txt 2> measure", [NAME, FRAT, LRAT_TEMP], 0), !,

  % FRAT_ZIP, FRAT, TARF, LRAT_TEMP, stdout.txt, measure

  read_item(read_time, "measure", TIME_SEC),
  s_to_ms(TIME_SEC, TIME),
  read_item(read_mem, "measure", MEM),
  size_file(TARF, TARF_SIZE), 
  size_file(LRAT_TEMP, LRAT_SIZE), !, 

  add_entry('frat_to_lrat_times.pl',   frat_to_lrat_time(NUM, TIME)),
  add_entry('frat_to_lrat_mems.pl',    frat_to_lrat_mem(NUM, MEM)),
  add_entry('temp_sizes.pl',           temp_size(NUM, TARF_SIZE)),
  add_entry('lrat_from_frat_sizes.pl', lrat_from_frat_size(NUM, LRAT_SIZE)), !,

  delete_file("measure"),
  delete_file("stdout.txt"),
  format_shell("mv ~w ~w", [LRAT_TEMP, LRAT], 0), !,
  format_shell("pigz ~w", [LRAT], 0), !,

  % FRAT_ZIP, FRAT, TARF, LRAT_ZIP
  
  delete_file(FRAT),
  delete_file(TARF),

  % FRAT_ZIP, LRAT_ZIP

  true.
  
test_frat_to_lrat(_) :- 
  add_entry('frat_to_lrat_times.pl',   failed),
  add_entry('frat_to_lrat_mems.pl',    failed),
  add_entry('temp_sizes.pl',           failed),
  add_entry('lrat_from_frat_sizes.pl', failed).

result_exists(NUM) :- frat_to_lrat_time(NUM, _), !.

main(ARGS) :-
  select_nums(result_exists, ARGS, NUMS),
  write_list(NUMS), !,
  cmap(test_frat_to_lrat, NUMS).