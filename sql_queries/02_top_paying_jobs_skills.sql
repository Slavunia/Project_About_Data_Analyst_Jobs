/*
Question: What skills are needed for top-paying data analyst roles in Germany vs. globally?
- Using the top 10 highest-paying Data Analyst jobs from first query
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/

-- globally, overview

WITH top_paying_jobs_globally AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs_globally.*,
    skills
FROM top_paying_jobs_globally
INNER JOIN skills_job_dim ON top_paying_jobs_globally.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;

--globally, only count of skills

WITH count_top_paying_jobs_globally AS (
    SELECT	
        job_id,
        job_title_short,
        salary_year_avg
    FROM
        job_postings_fact
    WHERE
        job_title_short = 'Data Analyst' AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    skills_dim.skills,
    COUNT(*) AS skill_count  -- Counting the number of times each skill is mentioned
FROM count_top_paying_jobs_globally
INNER JOIN skills_job_dim ON count_top_paying_jobs_globally.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY 
    skills_dim.skills -- Grouping by skill to count occurrences
HAVING COUNT(*) > 1 -- only showing skills mentioned more than once
ORDER BY
    skill_count DESC; -- Ordering by the count of skills in descending order 

-- Germany, overview

WITH top_paying_jobs_germany AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_country = 'Germany' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs_germany.*,
    skills
FROM top_paying_jobs_germany
INNER JOIN skills_job_dim ON top_paying_jobs_germany.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;

-- Germany, only count of skills

WITH top_paying_jobs_germany AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_country = 'Germany' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    skills_dim.skills,
    COUNT(*) AS skill_count  -- Counting the number of times each skill is mentioned
FROM top_paying_jobs_germany
INNER JOIN skills_job_dim ON top_paying_jobs_germany.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY 
    skills_dim.skills  -- Grouping by skill to count occurrences
HAVING COUNT(*) > 1 -- only showing skills mentioned more than once
ORDER BY
    skill_count DESC;  -- Ordering by the count of skills in descending order
    
/*
Here's the breakdown of the most demanded skills for data analysts in 2023 globally and in Germany, based on top-paying job postings:

- Python: Most demanded skill globally (4 mentions) and in Germany (5 mentions), central to data analysis.
- SQL: Essential for database management and querying in both markets.
- R, Tableau, Excel: Highly in demand globally, while Spark, GCP, Looker, GitHub are more prominent in Germany.
- Overlap: Python, R, SQL, and Tableau are key skills in both markets.

RESULTS
=======

-- GLOBALLY, overview

[
  {
    "job_id": 209315,
    "job_title": "Data base administrator",
    "salary_year_avg": "400000.0",
    "company_name": "ЛАНИТ",
    "skills": "oracle"
  },
  {
    "job_id": 209315,
    "job_title": "Data base administrator",
    "salary_year_avg": "400000.0",
    "company_name": "ЛАНИТ",
    "skills": "kafka"
  },
  {
    "job_id": 209315,
    "job_title": "Data base administrator",
    "salary_year_avg": "400000.0",
    "company_name": "ЛАНИТ",
    "skills": "linux"
  },
  {
    "job_id": 209315,
    "job_title": "Data base administrator",
    "salary_year_avg": "400000.0",
    "company_name": "ЛАНИТ",
    "skills": "git"
  },
  {
    "job_id": 209315,
    "job_title": "Data base administrator",
    "salary_year_avg": "400000.0",
    "company_name": "ЛАНИТ",
    "skills": "svn"
  },
  {
    "job_id": 1110602,
    "job_title": "HC Data Analyst , Senior",
    "salary_year_avg": "375000.0",
    "company_name": "Illuminate Mission Solutions",
    "skills": "python"
  },
  {
    "job_id": 1110602,
    "job_title": "HC Data Analyst , Senior",
    "salary_year_avg": "375000.0",
    "company_name": "Illuminate Mission Solutions",
    "skills": "r"
  },
  {
    "job_id": 1110602,
    "job_title": "HC Data Analyst , Senior",
    "salary_year_avg": "375000.0",
    "company_name": "Illuminate Mission Solutions",
    "skills": "vba"
  },
  {
    "job_id": 1110602,
    "job_title": "HC Data Analyst , Senior",
    "salary_year_avg": "375000.0",
    "company_name": "Illuminate Mission Solutions",
    "skills": "excel"
  },
  {
    "job_id": 1110602,
    "job_title": "HC Data Analyst , Senior",
    "salary_year_avg": "375000.0",
    "company_name": "Illuminate Mission Solutions",
    "skills": "tableau"
  },
  {
    "job_id": 229253,
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0",
    "company_name": "Torc Robotics",
    "skills": "sql"
  },
  {
    "job_id": 229253,
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0",
    "company_name": "Torc Robotics",
    "skills": "python"
  },
  {
    "job_id": 229253,
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0",
    "company_name": "Torc Robotics",
    "skills": "r"
  },
  {
    "job_id": 229253,
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0",
    "company_name": "Torc Robotics",
    "skills": "sas"
  },
  {
    "job_id": 229253,
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0",
    "company_name": "Torc Robotics",
    "skills": "matlab"
  },
  {
    "job_id": 229253,
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0",
    "company_name": "Torc Robotics",
    "skills": "spark"
  },
  {
    "job_id": 229253,
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0",
    "company_name": "Torc Robotics",
    "skills": "airflow"
  },
  {
    "job_id": 229253,
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0",
    "company_name": "Torc Robotics",
    "skills": "excel"
  },
  {
    "job_id": 229253,
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0",
    "company_name": "Torc Robotics",
    "skills": "tableau"
  },
  {
    "job_id": 229253,
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0",
    "company_name": "Torc Robotics",
    "skills": "power bi"
  },
  {
    "job_id": 229253,
    "job_title": "Director of Safety Data Analysis",
    "salary_year_avg": "375000.0",
    "company_name": "Torc Robotics",
    "skills": "sas"
  },
  {
    "job_id": 641501,
    "job_title": "Head of Infrastructure Management & Data Analytics - Financial...",
    "salary_year_avg": "375000.0",
    "company_name": "Citigroup, Inc",
    "skills": "excel"
  },
  {
    "job_id": 641501,
    "job_title": "Head of Infrastructure Management & Data Analytics - Financial...",
    "salary_year_avg": "375000.0",
    "company_name": "Citigroup, Inc",
    "skills": "word"
  },
  {
    "job_id": 101757,
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "350000.0",
    "company_name": "Care.com",
    "skills": "sql"
  },
  {
    "job_id": 101757,
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "350000.0",
    "company_name": "Care.com",
    "skills": "python"
  },
  {
    "job_id": 101757,
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "350000.0",
    "company_name": "Care.com",
    "skills": "r"
  },
  {
    "job_id": 101757,
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "350000.0",
    "company_name": "Care.com",
    "skills": "bigquery"
  },
  {
    "job_id": 101757,
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "350000.0",
    "company_name": "Care.com",
    "skills": "snowflake"
  },
  {
    "job_id": 101757,
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "350000.0",
    "company_name": "Care.com",
    "skills": "tableau"
  },
  {
    "job_id": 101757,
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "350000.0",
    "company_name": "Care.com",
    "skills": "power bi"
  },
  {
    "job_id": 101757,
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "350000.0",
    "company_name": "Care.com",
    "skills": "looker"
  },
  {
    "job_id": 1059665,
    "job_title": "Data Analyst",
    "salary_year_avg": "350000.0",
    "company_name": "Anthropic",
    "skills": "sql"
  },
  {
    "job_id": 1059665,
    "job_title": "Data Analyst",
    "salary_year_avg": "350000.0",
    "company_name": "Anthropic",
    "skills": "python"
  },
  {
    "job_id": 894135,
    "job_title": "Research Scientist",
    "salary_year_avg": "285000.0",
    "company_name": "OpenAI",
    "skills": "github"
  }
]

-- global, only count of skills

[
  {
    "skills": "python",
    "skill_count": "4"
  },
  {
    "skills": "r",
    "skill_count": "3"
  },
  {
    "skills": "sql",
    "skill_count": "3"
  },
  {
    "skills": "tableau",
    "skill_count": "3"
  },
  {
    "skills": "excel",
    "skill_count": "3"
  },
  {
    "skills": "power bi",
    "skill_count": "2"
  },
  {
    "skills": "sas",
    "skill_count": "2"
  }
]

-- GERMANY

[
  {
    "job_id": 1202839,
    "job_title": "Technology Research Engineer for Power Semiconductors (f/m/div.)",
    "salary_year_avg": "200000.0",
    "company_name": "Bosch Group",
    "skills": "spark"
  },
  {
    "job_id": 1202839,
    "job_title": "Technology Research Engineer for Power Semiconductors (f/m/div.)",
    "salary_year_avg": "200000.0",
    "company_name": "Bosch Group",
    "skills": "github"
  },
  {
    "job_id": 107183,
    "job_title": "Research Engineer (f/m/div.)",
    "salary_year_avg": "200000.0",
    "company_name": "Bosch Group",
    "skills": "spark"
  },
  {
    "job_id": 156108,
    "job_title": "Research Engineer for Security and Privacy  (f/m/div.)",
    "salary_year_avg": "199675.0",
    "company_name": "Bosch Group",
    "skills": "spark"
  },
  {
    "job_id": 156108,
    "job_title": "Research Engineer for Security and Privacy  (f/m/div.)",
    "salary_year_avg": "199675.0",
    "company_name": "Bosch Group",
    "skills": "github"
  },
  {
    "job_id": 59701,
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "166419.5",
    "company_name": "Volt.io",
    "skills": "sql"
  },
  {
    "job_id": 59701,
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "166419.5",
    "company_name": "Volt.io",
    "skills": "python"
  },
  {
    "job_id": 59701,
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "166419.5",
    "company_name": "Volt.io",
    "skills": "tableau"
  },
  {
    "job_id": 59701,
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "166419.5",
    "company_name": "Volt.io",
    "skills": "power bi"
  },
  {
    "job_id": 20461,
    "job_title": "Head of Data Analytics (F/M/X)",
    "salary_year_avg": "166419.5",
    "company_name": "PPRO",
    "skills": "python"
  },
  {
    "job_id": 20461,
    "job_title": "Head of Data Analytics (F/M/X)",
    "salary_year_avg": "166419.5",
    "company_name": "PPRO",
    "skills": "nosql"
  },
  {
    "job_id": 20461,
    "job_title": "Head of Data Analytics (F/M/X)",
    "salary_year_avg": "166419.5",
    "company_name": "PPRO",
    "skills": "bigquery"
  },
  {
    "job_id": 20461,
    "job_title": "Head of Data Analytics (F/M/X)",
    "salary_year_avg": "166419.5",
    "company_name": "PPRO",
    "skills": "redshift"
  },
  {
    "job_id": 20461,
    "job_title": "Head of Data Analytics (F/M/X)",
    "salary_year_avg": "166419.5",
    "company_name": "PPRO",
    "skills": "gcp"
  },
  {
    "job_id": 20461,
    "job_title": "Head of Data Analytics (F/M/X)",
    "salary_year_avg": "166419.5",
    "company_name": "PPRO",
    "skills": "kafka"
  },
  {
    "job_id": 20461,
    "job_title": "Head of Data Analytics (F/M/X)",
    "salary_year_avg": "166419.5",
    "company_name": "PPRO",
    "skills": "tableau"
  },
  {
    "job_id": 20461,
    "job_title": "Head of Data Analytics (F/M/X)",
    "salary_year_avg": "166419.5",
    "company_name": "PPRO",
    "skills": "looker"
  },
  {
    "job_id": 20461,
    "job_title": "Head of Data Analytics (F/M/X)",
    "salary_year_avg": "166419.5",
    "company_name": "PPRO",
    "skills": "terraform"
  },
  {
    "job_id": 931367,
    "job_title": "Data Architect (m/w/d)",
    "salary_year_avg": "165000.0",
    "company_name": "Datalogue GmbH",
    "skills": "sql"
  },
  {
    "job_id": 931367,
    "job_title": "Data Architect (m/w/d)",
    "salary_year_avg": "165000.0",
    "company_name": "Datalogue GmbH",
    "skills": "python"
  },
  {
    "job_id": 931367,
    "job_title": "Data Architect (m/w/d)",
    "salary_year_avg": "165000.0",
    "company_name": "Datalogue GmbH",
    "skills": "gcp"
  },
  {
    "job_id": 537995,
    "job_title": "Data Analyst/Manager - Last Mile Planning (m/f/d)",
    "salary_year_avg": "111202.0",
    "company_name": "Flink",
    "skills": "python"
  },
  {
    "job_id": 537995,
    "job_title": "Data Analyst/Manager - Last Mile Planning (m/f/d)",
    "salary_year_avg": "111202.0",
    "company_name": "Flink",
    "skills": "r"
  },
  {
    "job_id": 1314636,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175.0",
    "company_name": "Lilium",
    "skills": "python"
  },
  {
    "job_id": 1314636,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175.0",
    "company_name": "Lilium",
    "skills": "pyspark"
  },
  {
    "job_id": 1314636,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175.0",
    "company_name": "Lilium",
    "skills": "terminal"
  },
  {
    "job_id": 573605,
    "job_title": "Principal Data Analyst - Growth",
    "salary_year_avg": "111175.0",
    "company_name": "SumUp",
    "skills": "sql"
  },
  {
    "job_id": 573605,
    "job_title": "Principal Data Analyst - Growth",
    "salary_year_avg": "111175.0",
    "company_name": "SumUp",
    "skills": "python"
  },
  {
    "job_id": 573605,
    "job_title": "Principal Data Analyst - Growth",
    "salary_year_avg": "111175.0",
    "company_name": "SumUp",
    "skills": "r"
  },
  {
    "job_id": 573605,
    "job_title": "Principal Data Analyst - Growth",
    "salary_year_avg": "111175.0",
    "company_name": "SumUp",
    "skills": "matlab"
  },
  {
    "job_id": 573605,
    "job_title": "Principal Data Analyst - Growth",
    "salary_year_avg": "111175.0",
    "company_name": "SumUp",
    "skills": "tableau"
  }
]

-- Germany, only count of skills

[
  {
    "skills": "python",
    "skill_count": "5"
  },
  {
    "skills": "spark",
    "skill_count": "3"
  },
  {
    "skills": "sql",
    "skill_count": "3"
  },
  {
    "skills": "r",
    "skill_count": "2"
  },
  {
    "skills": "gcp",
    "skill_count": "2"
  },
  {
    "skills": "tableau",
    "skill_count": "2"
  },
  {
    "skills": "github",
    "skill_count": "2"
  },
  {
    "skills": "looker",
    "skill_count": "2"
  }
]