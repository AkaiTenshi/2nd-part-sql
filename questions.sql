/* Question 1 */
select stop_id from stop_times where trip_id = '6351929-ΤΗΛΕΜΑ-Τ3-Σάββατο-01';

/* Question 2 */
select arrival_time from stop_times where trip_id = '7069869-ΤΗΛΕΜΑ-Τ3-Κυριακή-01' ORDER BY arrival_time DESC LIMIT 1;

/* Question 3 */
select count(*) from stops;