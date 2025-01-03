/*
Question: What are the top-paying data analyst roles in Germany vs. globally?
- Identifing the top 10 highest-paying Data Analyst roles in 2023 globally and in Germany
- Drawing insights about Germany’s specific role in the global market and therefore including Germany in the global dataset
- Focusing on job postings with specified salaries (remove nulls)
- Renaming entries with the same salary or title, as manual checks reveal that they are coincidentally identical
- BONUS: Including company names of top 10 roles
- Highlight the top-paying opportunities for Data Analysts, providing insights into employment options and a comparison between the global and German markets
*/

-- Top-paying roles globally with distinct titles
WITH RankedJobs AS (
    SELECT
        job_id,
        job_title,
        job_location,
        job_country,
        job_schedule_type,
        salary_year_avg,
        job_posted_date,
        company_dim.name AS company_name,
        ROW_NUMBER() OVER (PARTITION BY job_title ORDER BY salary_year_avg DESC) AS row_num
    FROM
        job_postings_fact
    LEFT JOIN company_dim 
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
)

SELECT
    job_id,
    CASE
        WHEN row_num > 1 THEN CONCAT(job_title, ' ', row_num)
        ELSE job_title
    END AS new_job_title, -- Renaming entries with the same title
    job_location,
    job_country,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    company_name
FROM RankedJobs
ORDER BY salary_year_avg DESC
LIMIT 10;

-- Top-paying roles in Germany with distinct titles
WITH RankedJobsGermany AS (
    SELECT
        job_id,
        job_title,
        job_location,
        job_country,
        job_schedule_type,
        salary_year_avg,
        job_posted_date,
        company_dim.name AS company_name,
        ROW_NUMBER() OVER (PARTITION BY job_title ORDER BY salary_year_avg DESC) AS row_num
    FROM
        job_postings_fact
    LEFT JOIN company_dim 
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_country = 'Germany'
)

SELECT
    job_id,
    CASE
        WHEN row_num > 1 THEN CONCAT(job_title, ' ', row_num) 
        ELSE job_title
    END AS new_job_title, -- Renaming entries with the same title
    job_location,
    job_country,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    company_name
FROM RankedJobsGermany
ORDER BY salary_year_avg DESC
LIMIT 10;

/*
Here's the breakdown of the top data analyst jobs in 2023 globally and in Germany:

### **Global Market: Top 10 Paying Data Analyst Jobs (2023)**
- **Salary Range**: Roles range from **$285,000** to **$650,000**, with high-paying positions in tech and finance.
- **Senior Roles**: High demand for senior leadership positions, with employers like **Citigroup** and **Meta** offering top salaries.

### **Germany Market: Top 10 Paying Data Analyst Jobs (2023)**
- **Salary Range**: Roles range from **€111,175** to **€200,000**, with top employers like **Bosch** and **Fraunhofer-Gesellschaft**.
- **Leadership Focus**: Strong demand for leadership roles like **Head of Data Analytics**.

### **Global vs. Germany Comparison**
- **Salary Difference**: Global salaries are significantly higher, with global roles reaching **$650,000** vs. **€200,000** in Germany.
- **Role Specialization**: Global market leans toward senior leadership, while Germany focuses more on specialized engineering and tech roles.

RESULTS
=======

-- globally
[
  {
    "job_id": 226942,
    "new_job_title": "Data Analyst",
    "job_location": "Anywhere",
    "job_country": "India",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "650000.0",
    "job_posted_date": "2023-02-20 15:13:33",
    "company_name": "Mantys"
  },
  {
    "job_id": 209315,
    "new_job_title": "Data base administrator",
    "job_location": "Belarus",
    "job_country": "Belarus",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "400000.0",
    "job_posted_date": "2023-10-03 11:22:20",
    "company_name": "ЛАНИТ"
  },
  {
    "job_id": 641501,
    "new_job_title": "Head of Infrastructure Management & Data Analytics - Financial...",
    "job_location": "Jacksonville, FL",
    "job_country": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "375000.0",
    "job_posted_date": "2023-07-03 11:30:01",
    "company_name": "Citigroup, Inc"
  },
  {
    "job_id": 1110602,
    "new_job_title": "HC Data Analyst , Senior",
    "job_location": "Bethesda, MD",
    "job_country": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "375000.0",
    "job_posted_date": "2023-08-18 07:00:22",
    "company_name": "Illuminate Mission Solutions"
  },
  {
    "job_id": 1147675,
    "new_job_title": "Sr Data Analyst",
    "job_location": "Bethesda, MD",
    "job_country": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "375000.0",
    "job_posted_date": "2023-04-05 12:00:12",
    "company_name": "Illuminate Mission Solutions"
  },
  {
    "job_id": 229253,
    "new_job_title": "Director of Safety Data Analysis",
    "job_location": "Austin, TX",
    "job_country": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "375000.0",
    "job_posted_date": "2023-04-21 08:01:55",
    "company_name": "Torc Robotics"
  },
  {
    "job_id": 1059665,
    "new_job_title": "Data Analyst 2",
    "job_location": "San Francisco, CA",
    "job_country": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "350000.0",
    "job_posted_date": "2023-06-22 07:00:59",
    "company_name": "Anthropic"
  },
  {
    "job_id": 101757,
    "new_job_title": "Head of Data Analytics",
    "job_location": "Austin, TX",
    "job_country": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "350000.0",
    "job_posted_date": "2023-10-23 05:01:05",
    "company_name": "Care.com"
  },
  {
    "job_id": 547382,
    "new_job_title": "Director of Analytics",
    "job_location": "Anywhere",
    "job_country": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "336500.0",
    "job_posted_date": "2023-08-23 12:04:42",
    "company_name": "Meta"
  },
  {
    "job_id": 894135,
    "new_job_title": "Research Scientist",
    "job_location": "San Francisco, CA",
    "job_country": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "285000.0",
    "job_posted_date": "2023-04-19 18:04:21",
    "company_name": "OpenAI"
  }
]

-- Germany
[
  {
    "job_id": 1202839,
    "job_title": "Technology Research Engineer for Power Semiconductors (f/m/div.)",
    "job_location": "Renningen, Germany",
    "job_country": "Germany",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "200000.0",
    "job_posted_date": "2023-01-31 21:49:57",
    "company_name": "Bosch Group"
  },
  {
    "job_id": 107183,
    "job_title": "Research Engineer (f/m/div.)",
    "job_location": "Hildesheim, Germany",
    "job_country": "Germany",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "200000.0",
    "job_posted_date": "2023-01-25 02:21:38",
    "company_name": "Bosch Group"
  },
  {
    "job_id": 156108,
    "job_title": "Research Engineer for Security and Privacy  (f/m/div.)",
    "job_location": "Renningen, Germany",
    "job_country": "Germany",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "199675.0",
    "job_posted_date": "2023-04-28 15:15:32",
    "company_name": "Bosch Group"
  },
  {
    "job_id": 1263109,
    "job_title": "Research Engineer* / Research Scientist* for Development of Radar...",
    "job_location": "Germany",
    "job_country": "Germany",
    "job_schedule_type": "Full-time and Part-time",
    "salary_year_avg": "179500.0",
    "job_posted_date": "2023-12-22 21:18:26",
    "company_name": "Fraunhofer-Gesellschaft"
  },
  {
    "job_id": 59701,
    "job_title": "Head of Data Analytics",
    "job_location": "Berlin, Germany",
    "job_country": "Germany",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "166419.5",
    "job_posted_date": "2023-04-18 06:15:58",
    "company_name": "Volt.io"
  },
  {
    "job_id": 20461,
    "job_title": "Head of Data Analytics (F/M/X)",
    "job_location": "Munich, Germany",
    "job_country": "Germany",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "166419.5",
    "job_posted_date": "2023-01-19 01:22:25",
    "company_name": "PPRO"
  },
  {
    "job_id": 931367,
    "job_title": "Data Architect (m/w/d)",
    "job_location": "Hamburg, Germany",
    "job_country": "Germany",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "165000.0",
    "job_posted_date": "2023-07-08 15:11:21",
    "company_name": "Datalogue GmbH"
  },
  {
    "job_id": 537995,
    "job_title": "Data Analyst/Manager - Last Mile Planning (m/f/d)",
    "job_location": "Berlin, Germany",
    "job_country": "Germany",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "111202.0",
    "job_posted_date": "2023-01-13 20:23:50",
    "company_name": "Flink"
  },
  {
    "job_id": 181752,
    "job_title": "Data Analyst:in mit Schwerpunkt Marketing",
    "job_location": "Berlin, Germany",
    "job_country": "Germany",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "111175.0",
    "job_posted_date": "2023-08-24 19:42:01",
    "company_name": "Vattenfall"
  },
  {
    "job_id": 155801,
    "job_title": "Financial Data Analyst & Consultant (m/f/d)",
    "job_location": "Düsseldorf, Germany",
    "job_country": "Germany",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "111175.0",
    "job_posted_date": "2023-07-04 09:12:17",
    "company_name": "Experian"
  }
]

*/