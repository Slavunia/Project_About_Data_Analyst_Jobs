/*
Question: What skills are most in demand for data analysts globally and in Germany?
- Joining job postings to inner join table similar to query 2
- Identifing the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

-- globally
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;

--Germany
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_country = 'Germany' 
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;


/*
Here's the breakdown of the most demanded skills for data analysts in 2023 globally and in Germany

- SQL is the most in-demand skill globally (92,628) and in Germany (2,947), highlighting its central role in data analysis across all markets.
- Python follows closely, showing a strong demand both globally (57,326) and in Germany (2,316), indicating the growing need for programming skills in data analysis.
- Tableau is highly sought after globally (46,554) and in Germany (1,370), reflecting the increasing importance of data visualization skills.
- Excel and Power BI are in demand globally but slightly less so in Germany, where there's a stronger emphasis on Python and Tableau for more advanced analytics.

RESULTS
=======

-- globally
[
  {
    "skills": "sql",
    "demand_count": "92628"
  },
  {
    "skills": "excel",
    "demand_count": "67031"
  },
  {
    "skills": "python",
    "demand_count": "57326"
  },
  {
    "skills": "tableau",
    "demand_count": "46554"
  },
  {
    "skills": "power bi",
    "demand_count": "39468"
  }
]

-- Germany
[
  {
    "skills": "sql",
    "demand_count": "2947"
  },
  {
    "skills": "python",
    "demand_count": "2316"
  },
  {
    "skills": "tableau",
    "demand_count": "1370"
  },
  {
    "skills": "excel",
    "demand_count": "1327"
  },
  {
    "skills": "power bi",
    "demand_count": "1303"
  }
]

*/