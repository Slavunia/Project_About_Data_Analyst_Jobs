/* Question: How many junior positions and internships are available, and what is their pay? 
- Investigating whether the dataset is representative both for global and German market
- Calculating the number of junior positions and internships 
- Why? Shows how many opportunities are available for beginners or students
*/

-- counting junior positions, internships and their percentage (with NULL values in salary_year_avg column)

SELECT
    -- Global market (junior postings)
    COUNT(CASE WHEN job_title LIKE '%Junior%' THEN 1 END) AS junior_postings_count_global,
    -- Total postings globally
    COUNT(*) AS total_postings_global,
    -- Percentage of junior job postings globally
    ROUND(
        (COUNT(CASE WHEN job_title LIKE '%Junior%' THEN 1 END) * 100.0) / COUNT(*), 
        0
    ) AS percentage_junior_roles_global,

    -- Global market (internships)
    COUNT(CASE WHEN job_schedule_type LIKE '%Internship%' THEN 1 END) AS internships_count_global,
    -- Percentage of internships postings globally
    ROUND(
        (COUNT(CASE WHEN job_schedule_type LIKE '%Internship%' THEN 1 END) * 100.0) / COUNT(*), 
        0
    ) AS percentage_internships_global,

    -- Germany market (junior postings)
    COUNT(CASE WHEN job_country = 'Germany' AND job_title LIKE '%Junior%' THEN 1 END) AS junior_postings_count_germany,
    -- Total postings in Germany
    COUNT(CASE WHEN job_country = 'Germany' THEN 1 END) AS total_postings_germany,
    -- Percentage of junior job postings in Germany
    ROUND(
        (COUNT(CASE WHEN job_country = 'Germany' AND job_title LIKE '%Junior%' 
            THEN 1 END) * 100.0) / COUNT(CASE WHEN job_country = 'Germany' THEN 1 END), 
        0
    ) AS percentage_junior_roles_germany,

    -- Germany market (internships)
    COUNT(CASE WHEN job_country = 'Germany' AND job_schedule_type LIKE '%Internship%' THEN 1 END) AS internships_count_germany,
    -- Percentage of internships postings in Germany
    ROUND(
        (COUNT(CASE WHEN job_country = 'Germany' AND job_schedule_type LIKE '%Internship%' 
            THEN 1 END) * 100.0) / COUNT(CASE WHEN job_country = 'Germany' THEN 1 END), 
        0
    ) AS percentage_internships_germany
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst';

/* counting junior positions, internships and their percentage (without NULL values in salary_year_avg column); 
results of this query indicate that only further analysis of the salaries of junior vs non-junior data analyst roles 
in the global market is representative, due to the sufficient size of the dataset
*/

SELECT
    -- Global market (junior postings)
    COUNT(CASE WHEN job_title LIKE '%Junior%' THEN 1 END) AS junior_postings_count_global,
    -- Total postings globally
    COUNT(*) AS total_postings_global,
    -- Percentage of junior job postings globally
    ROUND(
        (COUNT(CASE WHEN job_title LIKE '%Junior%' THEN 1 END) * 100.0) / COUNT(*), 
        0
    ) AS percentage_junior_roles_global,

    -- Global market (internships)
    COUNT(CASE WHEN job_schedule_type LIKE '%Internship%' THEN 1 END) AS internships_count_global,
    -- Percentage of internships postings globally
    ROUND(
        (COUNT(CASE WHEN job_schedule_type LIKE '%Internship%' THEN 1 END) * 100.0) / COUNT(*), 
        2
    ) AS percentage_internships_global,

    -- Germany market (junior postings)
    COUNT(CASE WHEN job_country = 'Germany' AND job_title LIKE '%Junior%' THEN 1 END) AS junior_postings_count_germany,
    -- Total postings in Germany
    COUNT(CASE WHEN job_country = 'Germany' THEN 1 END) AS total_postings_germany,
    -- Percentage of junior job postings in Germany
    ROUND(
        (COUNT(CASE WHEN job_country = 'Germany' AND job_title LIKE '%Junior%' 
            THEN 1 END) * 100.0) / COUNT(CASE WHEN job_country = 'Germany' THEN 1 END), 
        0
    ) AS percentage_junior_roles_germany,

    -- Germany market (internships)
    COUNT(CASE WHEN job_country = 'Germany' AND job_schedule_type LIKE '%Internship%' THEN 1 END) AS internships_count_germany,
    -- Percentage of internships postings in Germany
    ROUND(
        (COUNT(CASE WHEN job_country = 'Germany' AND job_schedule_type LIKE '%Internship%' 
            THEN 1 END) * 100.0) / COUNT(CASE WHEN job_country = 'Germany' THEN 1 END), 
        2
    ) AS percentage_internships_germany
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst' 
AND salary_year_avg IS NOT NULL;

-- Query to calculate the median salary for Junior and Non-Junior roles, analyzing only the global market

WITH JuniorSalaries AS (
    SELECT salary_year_avg,
           ROW_NUMBER() OVER (ORDER BY salary_year_avg) AS row_num,
           COUNT(*) OVER () AS total_count
    FROM job_postings_fact
    WHERE job_title_short = 'Data Analyst' 
      AND job_title LIKE '%Junior%' 
      AND salary_year_avg IS NOT NULL
),
NonJuniorSalaries AS (
    SELECT salary_year_avg,
           ROW_NUMBER() OVER (ORDER BY salary_year_avg) AS row_num,
           COUNT(*) OVER () AS total_count
    FROM job_postings_fact
    WHERE job_title_short = 'Data Analyst' 
      AND job_title NOT LIKE '%Junior%' 
      AND salary_year_avg IS NOT NULL
)
SELECT 
    'Junior' AS job_type,
    ROUND(AVG(salary_year_avg), 0) AS median_salary  -- Round to zero decimal places
FROM JuniorSalaries
WHERE row_num IN (
    SELECT FLOOR((total_count + 1) / 2)
    UNION ALL
    SELECT FLOOR(total_count / 2)
    UNION ALL
    SELECT FLOOR(total_count / 2) + 1
)
UNION ALL
SELECT 
    'Non-Junior' AS job_type,
    ROUND(AVG(salary_year_avg), 0) AS median_salary  -- Round to zero decimal places
FROM NonJuniorSalaries
WHERE row_num IN (
    SELECT FLOOR((total_count + 1) / 2)
    UNION ALL
    SELECT FLOOR(total_count / 2)
    UNION ALL
    SELECT FLOOR(total_count / 2) + 1
);

/* Preparing the data for cleaning (removing outliers) 
and for creating the salary distribution 
of Junior vs Non-Junior Data Analyst job postings in Python */

SELECT
    'Junior' AS job_type,
    salary_year_avg
FROM job_postings_fact
WHERE job_title LIKE '%Junior%' 
    AND job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC;

SELECT
    'Non-Junior' AS job_type,
    salary_year_avg
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst' 
    AND job_title NOT LIKE '%Junior%' 
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC;

/*
Here’s a breakdown of the number of junior positions, internships, and their corresponding pay:

Global Market: 
- 3% of job postings are for junior data analysts, and 2% are internships; 
- over 99% of internships globally have NULL salary values, 
making the analysis of internship salaries unrepresentative.

Germany: 
- 6% of job postings in Germany are junior roles, and 3% are internships; 
- no internship postings in Germany had salary data, 
making salary analysis for internships non-representative.

Salary Analysis: 
- Only the analysis of junior vs non-junior salaries globally is representative.
The median salary for junior data analysts globally is $57,500, 
while non-junior roles have a higher median salary of $90,000, 
indicating a clear salary gap.
- Based on the histograms (see in README.md), 
Junior roles have a salary range mainly between $40,000 and $80,000, 
peaking around $50,000-$60,000, indicating concentration in lower salary brackets.
- Non-Junior roles span a wider range from $25,000 to over $200,000, 
with a concentration around $60,000-$120,000, 
reflecting higher and more varied salary offerings.

RESULTS
=======

-- counting junior positions, internships and their percentage (with NULL values in salary_year_avg column)
[
  {
    "junior_postings_count_global": "5755",
    "total_postings_global": "196593",
    "percentage_junior_roles_global": "3",
    "internships_count_global": "4532",
    "percentage_internships_global": "2",
    "junior_postings_count_germany": "396",
    "total_postings_germany": "7141",
    "percentage_junior_roles_germany": "6",
    "internships_count_germany": "189",
    "percentage_internships_germany": "3"
  }
]

-- counting junior positions, internships and their percentage (without NULL values in salary_year_avg column)
[
  {
    "junior_postings_count_global": "114",
    "total_postings_global": "5463",
    "percentage_junior_roles_global": "2",
    "internships_count_global": "17",
    "percentage_internships_global": "0.31",
    "junior_postings_count_germany": "4",
    "total_postings_germany": "48",
    "percentage_junior_roles_germany": "8",
    "internships_count_germany": "0",
    "percentage_internships_germany": "0.00"
  }
]

-- median salary for Junior and Non-Junior roles globally
[
  {
    "job_type": "Junior",
    "median_salary": "57500"
  },
  {
    "job_type": "Non-Junior",
    "median_salary": "90000"
  }
]
*/