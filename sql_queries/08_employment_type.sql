/* Question: What are the most common employment types in data analysis? 
- Calculating how frequently different types of employment 
are being offered in job postings for data analysts globally and in Germany
- Use NLP techniques in Python to analyze job schedule types by:
    - Identifying multi-word phrases such as "Temp work" and "Per diem."
    - Splitting combined job types (e.g., "Full-time and Contractor") into individual components.
    - Grouping job types with less than 5% frequency into a category called "Others."
Why: This analysis helps beginners in the field of data analysis understand 
how flexible the industry is by showing the distribution of job types
*/

-- analyzing distinct employment types for further usage of NLP 
SELECT DISTINCT job_schedule_type,
COUNT (job_id)
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst' 
AND job_schedule_type IS NOT NULL
GROUP BY job_schedule_type;

-- Preparing the dataset of employment types in the global and German data analysis job markets for further use in NLP analysis

-- global
SELECT job_schedule_type
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst' 
AND job_schedule_type IS NOT NULL;

-- Germany
SELECT job_schedule_type
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst' 
AND job_schedule_type IS NOT NULL
AND job_country = 'Germany';

/*
Here's the breakdown of the most common employment types in data analysis job postings in 2023:

- Full-time positions dominate both global (88.78%) and German (89.38%) data analyst job markets.
- Contractor roles are more common globally (5.84%) than in Germany (0.94%).
- Part-time positions are more prevalent in Germany (6.73%) than globally (2.65%).
- Internships are common among smaller categories, with 2.32% globally and 2.55% in Germany.

RESULTS
=======

-- from Python:

Frequency of Job Schedule Types (Global)
  Job Schedule Type  Frequency  Percentage
0         Full-time     173781       88.78
3        Contractor      11428        5.84
1         Part-time       5196        2.65
2        Internship       4532        2.32
4         Temp work        768        0.39
6         Volunteer         33        0.02
5          Per diem         15        0.01

Frequency of Job Schedule Types (Germany)
  Job Schedule Type  Frequency  Percentage
0         Full-time       6625       89.38
1         Part-time        499        6.73
3        Internship        189        2.55
4        Contractor         70        0.94
2         Temp work         28        0.38
5          Per diem          1        0.01




*/