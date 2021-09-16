#!/usr/bin/env swipl

:- initialization(main, main).
:- ['../../../basic'].
:- ['../names'].

read_time(String, Time) :- 
  string_concat("\tUser time (seconds): ", TimeString, String),
  number_string(Time, TimeString).

read_mem(String, PeakMem) :-
  string_concat("\tMaximum resident set size (kbytes): ", PeakMemStr, String), 
  number_string(PeakMem, PeakMemStr).

s_to_ms(S, MS) :- MS is round(S * 1000).

test_dpr_trim(NAME) :- 
  format("Processing problem = ~w\n", [NAME]),
  format(string(CNF), "../cnfs/~w.cnf", [NAME]),
  format(string(PR), "../prs/~w.pr", [NAME]),
  format(string(LRAT), "./lrats/~w.lrat", [NAME]), !,
  format(string(LRAT_TEMP), "./~w.lrat", [NAME]), !,

  write("Elaborating...\n"),
  format_shell("time -v frat-rs drat-trim -F ~w ~w -L ~w 1>> stdout.txt 2> measure", [CNF, PR, LRAT_TEMP], 0), !,

  % LRAT_TEMP, stdout.txt, measure

  read_item(read_time, "measure", TIME_SEC),
  s_to_ms(TIME_SEC, TIME),
  read_item(read_mem, "measure", MEM),
  size_file(LRAT_TEMP, LRAT_SIZE), !, 

  add_entry('times.pl', dpr_trim_time(NAME, TIME)),
  add_entry('mems.pl',  dpr_trim_mem(NAME, MEM)),
  add_entry('sizes.pl', lrat_size(NAME, LRAT_SIZE)), !,

  delete_file("measure"),
  delete_file("stdout.txt"),
  format_shell("mv ~w ~w", [LRAT_TEMP, LRAT], 0), !,

  true.
  
test_frat_to_lrat(NAME) :- 
  add_entry('times.pl', failed(NAME)),
  add_entry('mems.pl',  failed(NAME)),
  add_entry('sizes.pl', failed(NAME)),
  true.

main :- 
  findall(NAME, name(NAME), NAMES),
  cmap(test_dpr_trim, NAMES),
  true.

  
  