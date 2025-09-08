/*
Project: Top-Paying Data Analyst Jobs

Question: What are the top-paying data analyst jobs?
- Focus: Identify the top 10 highest-paying Data Analyst roles in Toronto or remote
- Data filters: Only include postings with specified salaries (exclude nulls)
- Includes company names for additional context
- Why: Highlights top-paying opportunities for Data Analysts and provides insights 
       into employment options and location flexibility
*/


SELECT
    job_id,
    job_title,
    company.name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact job_posting
LEFT JOIN
    company_dim company ON job_posting.company_id = company.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_location IN ('Toronto, ON, Canada', 'Anywhere')
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;

-- Full JSON results saved to: top_paying_jobs_result.json
