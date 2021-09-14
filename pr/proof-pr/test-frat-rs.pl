#!/usr/bin/env swipl

:- ['../basic', names].
:- initialization(main, main).

read_time(String, Time) :- 
  string_concat("\tUser time (seconds): ", TimeString, String),
  number_string(Time, TimeString).

read_mem(String, PeakMem) :-
  string_concat("\tMaximum resident set size (kbytes): ", PeakMemStr, String), 
  number_string(PeakMem, PeakMemStr).

s_to_ms(S, MS) :- MS is round(S * 1000).

test_frat_rs(NAME) :- 

  format("Processing problem = ~w\n", [NAME]),
  format(string(CNF), "./cnfs/~w.cnf", [NAME]),
  format(string(PR), "./prs/~w.pr", [NAME]),

  format(string(FRAT), "./~w.frat", [NAME]), !,
  format(string(TEMP), "~w.temp", [FRAT]),
  format(string(LRAT), "./~w.lrat", [NAME]), !,
  format(string(LRAT_STORE), "./lrats/~w.lrat", [NAME]), !,
  format(string(FRAT_STORE), "./frats/~w.frat", [NAME]), !,

  write("Converting PR to FRAT...\n"),
  format_shell("time -v frat-rs drat-trim -F ~w ~w ~w 1>> stdout.txt 2> measure", [CNF, PR, FRAT], 0), !,

  % FRAT, stdout.txt, measure

  read_item(read_time, "measure", CONV_SEC),
  s_to_ms(CONV_SEC, CONV_TIME),
  read_item(read_mem, "measure", CONV_MEM),
  size_file(FRAT, FRAT_SIZE), !, 
  delete_file("measure"),
  delete_file("stdout.txt"),

  % FRAT

  write("Elaborating FRAT to LRAT...\n"),

  format_shell("time -v frat-rs elab ~w ~w ~w 1>> stdout.txt 2> measure", [CNF, FRAT, LRAT], 0), !,

  read_item(read_time, "measure", ELAB_SEC),
  s_to_ms(ELAB_SEC, ELAB_TIME),
  read_item(read_mem, "measure", ELAB_MEM),
  size_file(TEMP, TEMP_SIZE), !, 
  size_file(LRAT, LRAT_SIZE), !, 
  delete_file("measure"),
  delete_file("stdout.txt"),

  add_entry('conv_times.pl', conv_time(NAME, CONV_TIME)),
  add_entry('conv_mems.pl',  conv_mem(NAME, CONV_MEM)),
  add_entry('frat_sizes.pl', frat_size(NAME, FRAT_SIZE)), !,

  add_entry('elab_times.pl', elab_time(NAME, ELAB_TIME)),
  add_entry('elab_mems.pl',  elab_mem(NAME, ELAB_MEM)),
  add_entry('temp_sizes.pl', temp_size(NAME, TEMP_SIZE)),
  add_entry('lrat_sizes.pl', lrat_size(NAME, LRAT_SIZE)), !,

  format_shell("mv ~w ~w", [LRAT, LRAT_STORE], 0), !,
  format_shell("mv ~w ~w", [FRAT, FRAT_STORE], 0), !,
  delete_file(TEMP),

  true.
  
test_frat_rs(NAME) :- 
  add_entry('conv-times.pl', failed(NAME)),
  add_entry('conv-mems.pl',  failed(NAME)),
  add_entry('elab-times.pl', failed(NAME)),
  add_entry('elab-mems.pl',  failed(NAME)),
  add_entry('frat-sizes.pl',  failed(NAME)),
  add_entry('temp-sizes.pl',  failed(NAME)),
  add_entry('lrat-sizes.pl',  failed(NAME)),
  true.

% main(ARGS) :-
%   select_nums(result_exists, ARGS, NUMS),
%   write_list(NUMS), !,
%   cmap(test_frat_to_lrat, NUMS).


main :- 
  findall(NAME, name(NAME), NAMES),
  cmap(test_frat_rs, NAMES),
  true.
