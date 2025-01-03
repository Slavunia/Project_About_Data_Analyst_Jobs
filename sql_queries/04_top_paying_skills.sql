/*
Question: What are the top skills based on salary globally and in Germany?
- Looking at the average salary associated with each skill for Data Analyst positions globally and in Germany
- Focusing on roles with specified salaries
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

-- globally
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;

-- Germany
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_country = 'Germany'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;

/*
Here's a breakdown of the results for top paying skills for Data Analysts globally and in Germany:

- Global market offers the highest-paying roles for specialized skills like SVN ($400,000) and Solidity ($179,000), indicating demand for niche technologies.
- Germany focuses on cloud and big data tools like Kafka, Terraform, and BigQuery, with average salaries of $166,420.
- Global vs. Germany: The global market values specialized, emerging technologies more, while Germany emphasizes foundational cloud and big data skills.
- Salary Insights: Global salaries are higher for certain specialized skills, but Germany’s salaries align around $166,420 for top-demand skills.

RESULTS
=======

-- globally
[
  {
    "skills": "svn",
    "avg_salary": "400000"
  },
  {
    "skills": "solidity",
    "avg_salary": "179000"
  },
  {
    "skills": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skills": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skills": "golang",
    "avg_salary": "155000"
  },
  {
    "skills": "mxnet",
    "avg_salary": "149000"
  },
  {
    "skills": "dplyr",
    "avg_salary": "147633"
  },
  {
    "skills": "vmware",
    "avg_salary": "147500"
  },
  {
    "skills": "terraform",
    "avg_salary": "146734"
  },
  {
    "skills": "twilio",
    "avg_salary": "138500"
  },
  {
    "skills": "gitlab",
    "avg_salary": "134126"
  },
  {
    "skills": "kafka",
    "avg_salary": "129999"
  },
  {
    "skills": "puppet",
    "avg_salary": "129820"
  },
  {
    "skills": "keras",
    "avg_salary": "127013"
  },
  {
    "skills": "pytorch",
    "avg_salary": "125226"
  },
  {
    "skills": "perl",
    "avg_salary": "124686"
  },
  {
    "skills": "ansible",
    "avg_salary": "124370"
  },
  {
    "skills": "hugging face",
    "avg_salary": "123950"
  },
  {
    "skills": "tensorflow",
    "avg_salary": "120647"
  },
  {
    "skills": "cassandra",
    "avg_salary": "118407"
  },
  {
    "skills": "notion",
    "avg_salary": "118092"
  },
  {
    "skills": "atlassian",
    "avg_salary": "117966"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "116712"
  },
  {
    "skills": "airflow",
    "avg_salary": "116387"
  },
  {
    "skills": "scala",
    "avg_salary": "115480"
  }
]

-- Germany
[
  {
    "skills": "kafka",
    "avg_salary": "166420"
  },
  {
    "skills": "terraform",
    "avg_salary": "166420"
  },
  {
    "skills": "bigquery",
    "avg_salary": "166420"
  },
  {
    "skills": "nosql",
    "avg_salary": "166420"
  },
  {
    "skills": "redshift",
    "avg_salary": "166420"
  },
  {
    "skills": "github",
    "avg_salary": "150896"
  },
  {
    "skills": "spark",
    "avg_salary": "138261"
  },
  {
    "skills": "gcp",
    "avg_salary": "127478"
  },
  {
    "skills": "no-sql",
    "avg_salary": "111175"
  },
  {
    "skills": "terminal",
    "avg_salary": "111175"
  },
  {
    "skills": "databricks",
    "avg_salary": "111175"
  },
  {
    "skills": "elasticsearch",
    "avg_salary": "111175"
  },
  {
    "skills": "flask",
    "avg_salary": "111175"
  },
  {
    "skills": "react",
    "avg_salary": "111175"
  },
  {
    "skills": "pyspark",
    "avg_salary": "111175"
  },
  {
    "skills": "javascript",
    "avg_salary": "111175"
  },
  {
    "skills": "matlab",
    "avg_salary": "111175"
  },
  {
    "skills": "pandas",
    "avg_salary": "108413"
  },
  {
    "skills": "matplotlib",
    "avg_salary": "107492"
  },
  {
    "skills": "numpy",
    "avg_salary": "105650"
  },
  {
    "skills": "sas",
    "avg_salary": "105650"
  },
  {
    "skills": "git",
    "avg_salary": "105000"
  },
  {
    "skills": "python",
    "avg_salary": "104243"
  },
  {
    "skills": "atlassian",
    "avg_salary": "102500"
  },
  {
    "skills": "power bi",
    "avg_salary": "97749"
  }
]

*/