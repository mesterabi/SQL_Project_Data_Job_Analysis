/*
Project: Skills for Top-Paying Data Analyst Jobs

Question: What skills are required for the top-paying data analyst roles (2025)?
- Dataset: Top 10 highest-paying Data Analyst jobs (Toronto or remote, salary specified)
- Key Findings:
    • SQL is universal across all top-paying roles.
    • Python and Tableau are the top complementary skills.
    • Cloud/data platforms (Azure, AWS, Snowflake, Databricks) 
      are increasingly common in senior-level postings.
    • Excel remains relevant, while collaboration tools (Git, Jira, Confluence) 
      show importance of teamwork at senior/principal levels.
    • Visualization + communication skills (Tableau, Power BI, PowerPoint) 
      are critical for translating insights to stakeholders.
- Why: Helps job seekers focus on high-value technical + communication skills 
       that align with top-paying opportunities.
*/



WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        company.name AS company_name,
        salary_year_avg
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
    LIMIT 10
)


-- Approach 1: Row-per-skill
-- Provides a detailed look at each skill required per job.
-- Useful for analyzing skill frequencies and building visualizations.
-- Full JSON results saved to: top_paying_job_skills_result_approach_1.json
SELECT 
    top_paying_jobs.*,
    skill.skills
FROM 
    top_paying_jobs
JOIN 
    skills_job_dim skill_job ON top_paying_jobs.job_id = skill_job.job_id
JOIN 
    skills_dim skill ON skill_job.skill_id = skill.skill_id
ORDER BY 
    top_paying_jobs.salary_year_avg DESC;


-- Approach 2: Aggregated skills
-- Summarizes all skills for each job into a single row.
-- Useful for human-readable reporting and stakeholder presentations.
-- Full JSON results saved to: top_paying_job_skills_result_approach_2.json
SELECT 
    top_paying_jobs.*,
    STRING_AGG(skill.skills, ', ') AS required_skills
FROM 
    top_paying_jobs
JOIN 
    skills_job_dim skill_job ON top_paying_jobs.job_id = skill_job.job_id
JOIN 
    skills_dim skill ON skill_job.skill_id = skill.skill_id
GROUP BY 
    top_paying_jobs.job_id,
    top_paying_jobs.job_title,
    top_paying_jobs.company_name,
    top_paying_jobs.salary_year_avg
ORDER BY 
    top_paying_jobs.salary_year_avg DESC;
