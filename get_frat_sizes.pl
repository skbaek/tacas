#!/usr/bin/env swipl

:- initialization(main, main).
:- [prelude, problems, frat_sizes, paths].

result_exists(NUM) :- num_frat_size(NUM, _), !.

get_frat_size(NUM) :- 
  num_name(NUM, NAME),
  format(string(PATH), "./frats/~w.frat", [NAME]),
  (
    size_file(PATH, FRAT_SIZE) -> 
    add_entry('frat_sizes.pl', num_frat_size(NUM, passed(FRAT_SIZE))) ;
    add_entry('frat_sizes.pl', num_frat_size(NUM, failed)) 
  ).

main :-
  range(1, 97, RANGE),
  exclude(result_exists, RANGE, NUMS),
  write_list(NUMS), !,
  cmap(get_frat_size, NUMS).