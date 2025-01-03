/* Question: Is a degree required for data analyst roles? 
- Calculating how many job postings for data analysts do not mention degree on the global market and in Germany, 
as well as their percentage
- Why? Provides valuable insight for job seekers, showing if employers prioritize practical skills over formal education 
and guiding career and skill development decisions.
*/

SELECT
    -- Global market (no degree mentioned)
    COUNT(CASE WHEN job_no_degree_mention = TRUE THEN 1 END) AS no_degree_required_count_global,
    -- Total postings globally
    COUNT(*) AS total_postings_global,
   
    -- Percentage of job postings with no degree mentioned globally
    ROUND(
        (COUNT(CASE WHEN job_no_degree_mention = TRUE THEN 1 END) * 100.0) / COUNT(*), 
        0
    ) AS percentage_no_degree_global,

    -- Germany market (no degree mentioned)
    COUNT(CASE WHEN job_country = 'Germany' AND job_no_degree_mention = TRUE THEN 1 END) AS no_degree_required_count_germany,
    -- Total postings in Germany
    COUNT(CASE WHEN job_country = 'Germany' THEN 1 END) AS total_postings_germany,
    -- Percentage of job postings with no degree mentioned in Germany
    ROUND(
        (COUNT(CASE WHEN job_country = 'Germany' AND job_no_degree_mention = TRUE THEN 1 END) * 100.0) / COUNT(CASE WHEN job_country = 'Germany' THEN 1 END), 
        0
    ) AS percentage_no_degree_germany
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst';


/*

Here's a breakdown of how many job postings for Data Analysts mentioned the degree in 2023 globally and in Germany: 

- **Global Market**: While 39% of Data Analyst roles globally do not mention a degree, this may not necessarily mean it's not required. Around 60% of job postings still reference a degree requirement.
- **Germany**: Approximately 69% of Data Analyst roles in Germany do not mention a degree, but this doesn't guarantee that it’s not a factor. Around 40% of job postings still mention a degree requirement.
- **Implication**: Job seekers may still find many opportunities without a degree, especially in Germany, but it's important to consider that degree requirements may still apply even if not explicitly mentioned in the postings.

RESULTS
=======
[
  {
    "no_degree_required_count_global": "76057",
    "total_postings_global": "196593",
    "percentage_no_degree_global": "39",
    "no_degree_required_count_germany": "4894",
    "total_postings_germany": "7141",
    "percentage_no_degree_germany": "69"
  }
]

*/