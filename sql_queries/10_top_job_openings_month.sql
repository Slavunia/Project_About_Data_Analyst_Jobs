/* Question: When are data analyst job postings most frequent?
- Calculating the number of job postings for data analysts per month in 2023, both globally and in Germany.
Why: Identify potential seasonal trends that can help job seekers optimize their job search strategies.
*/

SELECT 
    EXTRACT(MONTH FROM job_posted_date) AS month,
    COUNT(CASE WHEN job_country = 'Germany' THEN job_id END) AS number_of_postings_germany,
    COUNT(job_id) AS number_of_postings_global
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
AND EXTRACT(YEAR FROM job_posted_date) = 2023
GROUP BY month
ORDER BY month;

/*
Here's the breakdown of Monthly Job Postings for Data Analysts in 2023 globally and in Germany:
- January stands out globally as the highest month for job postings, likely due to companies' increased hiring activity in the new year.
- October is the peak month in Germany, suggesting a strong push towards year-end hiring, possibly influenced by organizational needs for Q4.
- Both regions saw a notable decline in December, suggesting a common slowdown in recruitment efforts due to holidays and year-end budget cycles.

RESULTS
=======
[
  {
    "month": "1",
    "number_of_postings_germany": "592",
    "number_of_postings_global": "23697"
  },
  {
    "month": "2",
    "number_of_postings_germany": "602",
    "number_of_postings_global": "16479"
  },
  {
    "month": "3",
    "number_of_postings_germany": "576",
    "number_of_postings_global": "16342"
  },
  {
    "month": "4",
    "number_of_postings_germany": "457",
    "number_of_postings_global": "15499"
  },
  {
    "month": "5",
    "number_of_postings_germany": "426",
    "number_of_postings_global": "13457"
  },
  {
    "month": "6",
    "number_of_postings_germany": "560",
    "number_of_postings_global": "15932"
  },
  {
    "month": "7",
    "number_of_postings_germany": "544",
    "number_of_postings_global": "16150"
  },
  {
    "month": "8",
    "number_of_postings_germany": "485",
    "number_of_postings_global": "18602"
  },
  {
    "month": "9",
    "number_of_postings_germany": "661",
    "number_of_postings_global": "14997"
  },
  {
    "month": "10",
    "number_of_postings_germany": "754",
    "number_of_postings_global": "16260"
  },
  {
    "month": "11",
    "number_of_postings_germany": "746",
    "number_of_postings_global": "15133"
  },
  {
    "month": "12",
    "number_of_postings_germany": "724",
    "number_of_postings_global": "13560"
  }
]

*/