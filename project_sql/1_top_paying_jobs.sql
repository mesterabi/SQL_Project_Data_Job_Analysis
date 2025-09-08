/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available in Toronto or remote
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
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
