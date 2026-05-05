# lavaan-check

This project is intended to compare the results of fitting models in lavaan with the results of previous runs.

There are three main procedures:

- all_tests_Rout.R, which generates execution reports defined in the R-files tests/*.R and stores them in .Rout files.

- all_tests_RoutSave.R, which generates execution reports defined in the R-files tests/*.R and stores them in .Rout.save files.

- all_tests_compare.R which compares the .Rout with .Rout.save files and reports the differences.


There is also  a routine to check the correct use of lav_stop, lav_warn, ... : check_stop_warn.R
