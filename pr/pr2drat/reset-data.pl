#!/usr/bin/env swipl
:- initialization(main, main).

main :- 
  shell("echo \"\" > dpr-trim-mems.pl", 0),
  shell("echo \"\" > dpr-trim-times.pl", 0),
  shell("echo \"\" > lpr-sizes.pl", 0),

  shell("echo \"\" > conv-mems.pl", 0),
  shell("echo \"\" > conv-times.pl", 0),
  shell("echo \"\" > elab-mems.pl", 0),
  shell("echo \"\" > elab-times.pl", 0),
  shell("echo \"\" > frat-sizes.pl", 0),
  shell("echo \"\" > temp-sizes.pl", 0),
  shell("echo \"\" > lrat-sizes.pl", 0),

  shell("rm -f -- lprs/*", 0),
  shell("rm -f -- frats/*", 0),
  shell("rm -f -- lrats/*", 0),
  shell("rm -f -- measure", 0),
  shell("rm -f -- stdout.txt", 0),
  true.