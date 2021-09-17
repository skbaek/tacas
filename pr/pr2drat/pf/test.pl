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

  format(string(LRAT), "./~w.lrat", [NAME]), !,
  format(string(DRAT), "./~w.drat", [NAME]), !,
  
  format(string(DRAT_STORE), "./lrats/~w.lrat", [NAME]), !,
  format(string(LRAT_STORE), "./drats/~w.drat", [NAME]), !,

  write("Converting to DRAT...\n"),

  format_shell("time -v pr2drat ~w ~w 1>> ~w 2> measure", [CNF, PR, DRAT], 0), !,

  % DRAT, measure

  read_item(read_time, "measure", CONV_SEC),
  s_to_ms(CONV_SEC, CONV_TIME),
  read_item(read_mem, "measure", CONV_MEM),
  size_file(DRAT, DRAT_SIZE), !, 

  delete_file("measure"),

  % DRAT

  format_shell("time -v frat-rs drat-trim ~w ~w -L ~w 1>> stdout 2> measure", [CNF, DRAT, LRAT], 0), !,

  read_item(read_time, "measure", ELAB_SEC),
  s_to_ms(ELAB_SEC, ELAB_TIME),
  read_item(read_mem, "measure", ELAB_MEM),
  size_file(LRAT, LRAT_SIZE), !, 

  add_entry('conv-mems.pl', conv_mem(NAME, CONV_MEM)),
  add_entry('conv-times.pl', conv_time(NAME, CONV_TIME)),

  add_entry('elab-mems.pl', elab_mem(NAME, ELAB_MEM)),
  add_entry('elab-times.pl', elab_time(NAME, ELAB_TIME)),

  add_entry('drat-sizes.pl', drat_size(NAME, DRAT_SIZE)),
  add_entry('lrat-sizes.pl', lrat_size(NAME, LRAT_SIZE)),

  delete_file("stdout"),
  delete_file("measure"),

  format_shell("mv ~w ~w", [DRAT, DRAT_STORE], 0), !,
  format_shell("mv ~w ~w", [LRAT, LRAT_STORE], 0), !,

  true.
  
test_frat_to_lrat(NAME) :- 
  add_entry('conv-times.pl', failed(NAME)),
  add_entry('conv-mems.pl',  failed(NAME)),
  add_entry('elab-times.pl', failed(NAME)),
  add_entry('elab-mems.pl',  failed(NAME)),
  add_entry('drat-sizes.pl', failed(NAME)),
  add_entry('lrat-sizes.pl', failed(NAME)),
  true.

main :- 
  findall(NAME, name(NAME), NAMES),
  cmap(test_dpr_trim, NAMES),
  true.

  
  