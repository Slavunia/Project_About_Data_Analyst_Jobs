/* Question: How common are remote and work-from-home job offers in data analysis?
- Checking if data about remote work and homeoffice contains the same information
- Calculating how frequently remote work and homeoffice are offered 
in job postings for data analysts globally and in Germany
- Why: This analysis helps beginners in the field of data analysis understand 
how flexible the industry is in regards of remote and homeoffice jobs
*/

/* The following queries, which search for job postings with remote work 
and home office options, reveal that postings labeled as 'remote work' 
are identical to those labeled as 'home office.' Therefore, only 
'remote work' is analyzed further, as it encompasses 'home office' roles.
*/

-- globally
WITH query1 AS (
    SELECT job_id, job_title, salary_year_avg
    FROM job_postings_fact
    WHERE job_location = 'Anywhere'
    AND job_title_short = 'Data Analyst'
),
query2 AS (
    SELECT job_id, job_title, salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home IS TRUE
    AND job_title_short = 'Data Analyst'
)
SELECT 
    q1.job_id, 
    q1.job_title, 
    q1.salary_year_avg AS salary_year_avg_q1,
    q2.salary_year_avg AS salary_year_avg_q2
FROM query1 q1
FULL OUTER JOIN query2 q2
    ON q1.job_id = q2.job_id
ORDER BY q1.job_id;

-- Germany
WITH query1 AS (
    SELECT job_id, job_title, salary_year_avg
    FROM job_postings_fact
    WHERE job_location = 'Anywhere'
    AND job_title_short = 'Data Analyst'
    AND job_country = 'Germany'
),
query2 AS (
    SELECT job_id, job_title, salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home IS TRUE
    AND job_title_short = 'Data Analyst'
    AND job_country = 'Germany'
)
SELECT 
    q1.job_id, 
    q1.job_title, 
    q1.salary_year_avg AS salary_year_avg_q1,
    q2.salary_year_avg AS salary_year_avg_q2
FROM query1 q1
FULL OUTER JOIN query2 q2
    ON q1.job_id = q2.job_id
ORDER BY q1.job_id;

-- Calculating how frequently remote work and homeoffice are offered globally and in Germany

SELECT
    -- Global market (remote)
    COUNT(CASE WHEN job_location = 'Anywhere' THEN 1 END) AS remote_count_global,
    -- Total postings globally
    COUNT(*) AS total_postings_global,
    -- Percentage of remote job postings globally
    ROUND(
        (COUNT(CASE WHEN job_location = 'Anywhere' THEN 1 END) * 100.0) / COUNT(*), 
        0
    ) AS percentage_remote_global,

    -- Germany market (remote)
    COUNT(CASE WHEN job_country = 'Germany' AND job_location = 'Anywhere' THEN 1 END) AS remote_count_germany,
    -- Total postings in Germany
    COUNT(CASE WHEN job_country = 'Germany' THEN 1 END) AS total_postings_germany,
    -- Percentage of remote job postings in Germany
    ROUND(
        (COUNT(CASE WHEN job_country = 'Germany' AND job_location = 'Anywhere' THEN 1 END) * 100.0) / COUNT(CASE WHEN job_country = 'Germany' THEN 1 END), 
        0
    ) AS percentage_remote_germany
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst';

/*
Here is the breakdown of the prevalence of remote and work-from-home job offers:

- Remote jobs, which are the same as work-from-home jobs, 
are those with a job location of 'Anywhere.'
- Remote and work-from-home job offers in data analysis are 
more prevalent globally (7%) compared to Germany (4%).

RESULTS
=======

[
  {
    "remote_count_global": "13331",
    "total_postings_global": "196593",
    "percentage_remote_global": "7",
    "remote_count_germany": "274",
    "total_postings_germany": "7141",
    "percentage_remote_germany": "4"
  }
]

*/