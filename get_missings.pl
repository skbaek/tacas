#!/usr/bin/env swipl

:- initialization(main, main).
:- [prelude, problems, missings, paths].

result_exists(NUM) :- num_missing(NUM, _), !.

read_missing(String, Missing) :- 
  split_string(String, " ", "", [_, "missing", "proofs", Temp0]), 
  string_concat("(", Temp1, Temp0), 
  string_concat(MissingStr, "%)", Temp1), 
  number_string(Missing, MissingStr).

get_df_time(NUM) :- 
  num_name(NUM, NAME),
  format("Computing missing hints for problem = ~w...\n", [NAME]),
  frat_rs(FRAT_RS), 
  format_shell("~w fratchk ./frats/~w.frat > temp", [FRAT_RS, NAME], 0),
  read_item(read_missing, "temp", MISSING),
  add_entry('missings.pl', num_missing(NUM, passed(MISSING))),
  delete_file("temp").

main :-
  range(1, 97, RANGE),
  exclude(result_exists, RANGE, NUMS),
  write_list(NUMS), !,
  cmap(get_df_time, NUMS).