#!/usr/bin/env swipl

:- initialization(main, main).
:- ['../../basic'].
:- [names].

read_time(String, Time) :- 
  string_concat("\tUser time (seconds): ", TimeString, String),
  number_string(Time, TimeString).

read_mem(String, PeakMem) :-
  string_concat("\tMaximum resident set size (kbytes): ", PeakMemStr, String), 
  number_string(PeakMem, PeakMemStr).

s_to_ms(S, MS) :- MS is round(S * 1000).

test_dpr_trim(NAME) :- 
  format("Processing problem = ~w\n", [NAME]),
  format(string(CNF), "./cnfs/~w.cnf", [NAME]),
  format(string(PR), "./prs/~w.pr", [NAME]),
  format(string(LPR), "./lprs/~w.lpr", [NAME]), !,
  format(string(LPR_TEMP), "./~w.lpr", [NAME]), !,

  write("Elaborating...\n"),
  format_shell("time -v dpr-trim ~w ~w -L ~w 1>> stdout.txt 2> measure", [CNF, PR, LPR_TEMP], 0), !,

  % LPR_TEMP, stdout.txt, measure

  read_item(read_time, "measure", TIME_SEC),
  s_to_ms(TIME_SEC, TIME),
  read_item(read_mem, "measure", MEM),
  size_file(LPR_TEMP, LPR_SIZE), !, 

  add_entry('dpr-trim-times.pl', dpr_trim_time(NAME, TIME)),
  add_entry('dpr-trim-mems.pl',  dpr_trim_mem(NAME, MEM)),
  add_entry('lpr-sizes.pl', lpr_size(NAME, LPR_SIZE)), !,

  delete_file("measure"),
  delete_file("stdout.txt"),
  format_shell("mv ~w ~w", [LPR_TEMP, LPR], 0), !,

  true.
  
test_frat_to_lrat(_) :- 
  add_entry('dpr-trim-times.pl',     failed),
  add_entry('dpr-trim-mems.pl',      failed),
  add_entry('lpr-sizes.pl', failed),
  true.

result_exists(NUM) :- frat_to_lrat_time(NUM, _), !.

main :- 
  findall(NAME, name(NAME), NAMES),
  cmap(test_dpr_trim, NAMES),
  true.

  
  