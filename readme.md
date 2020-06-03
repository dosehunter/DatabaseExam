## NOTE! The order to run matters
If being run, run in this order:

1. school_setup
2. populate_school
3. trigger

After this order doesn't matter.
Before running use cases make sure to run _temporary_table.sql_, _transaction.sql_, _scheduled_even.sql_, and _functions.sql_

<br>

**NOTE!**
Also, if recreating the population data, subject and level should be a unique combination if possible, it may cause the system to not find enough possible solutions