/*
Project: Optimal Skills for High-Paying Data Analyst Roles

Question: What are the most optimal skills to learn for Data Analysts? 
- Focus: Skills that are both in high demand and associated with higher average salaries.
- Dataset: All remote Data Analyst postings with specified salaries.
- Key Findings:
    • Programming & Analytics Languages dominate: Python (236 demand, $101k), R (148 demand, $100k) are most requested; specialized languages (Go, Java, C++) correlate with slightly higher salaries.
    • Database & Cloud Expertise: Snowflake, Azure, AWS, Oracle, Redshift, BigQuery — critical for enterprise-level analytics, offering higher pay.
    • BI & Visualization: Tableau, Looker, Qlik, SSRS remain central for translating insights.
    • Big Data & Data Pipeline Skills: Hadoop, Spark, SAS, SSIS command premium salaries for large dataset processing.
    • Collaboration & Workflow Tools: Confluence, Jira, version control (Git/Bitbucket) expected in high-paying roles.
- Salary vs Demand Observations:
    • Widely used skills (Python, Tableau, R) have high demand but slightly lower salaries.
    • Niche technical skills (Go, Hadoop, Snowflake, Confluence) offer higher pay despite moderate demand.
- Why: Provides strategic guidance for career development, helping job seekers prioritize skills that offer both market demand and financial reward.
*/


-- High Demand Skills CTE
WITH high_demand_skills AS (
    SELECT 
        skill.skill_id,
        skill.skills,
        COUNT(skill.skill_id) AS demand_count
    FROM 
        job_postings_fact job_posting
    JOIN 
        skills_job_dim skill_job ON job_posting.job_id = skill_job.job_id
    JOIN
        skills_dim skill ON skill_job.skill_id = skill.skill_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY 
        skill.skill_id
),

-- Top Paying Skills CTE
top_paying_skills AS (
    SELECT 
        skill.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM 
        job_postings_fact job_posting
    JOIN 
        skills_job_dim skill_job ON job_posting.job_id = skill_job.job_id
    JOIN
        skills_dim skill ON skill_job.skill_id = skill.skill_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY 
        skill.skill_id
)

-- Final Selection: Optimal Skills
SELECT
    high_demand_skills.skill_id,
    high_demand_skills.skills,
    demand_count,
    avg_salary
FROM
    high_demand_skills
JOIN
    top_paying_skills ON high_demand_skills.skill_id = top_paying_skills.skill_id
WHERE
    demand_count > 10  -- Filter for skills with significant demand
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

-- Full JSON results saved to: 5_optimal_skills_result.json


-- Concise version without CTEs:
SELECT
    skill.skill_id,
    skill.skills,
    COUNT(skill.skill_id) AS demand_count,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact job_posting
JOIN
    skills_job_dim skill_job ON job_posting.job_id = skill_job.job_id
JOIN
    skills_dim skill ON skill_job.skill_id = skill.skill_id
WHERE
    job_posting.job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skill.skill_id, 
    skill.skills
HAVING
    COUNT(skill.skill_id) > 10  -- Filter for skills with significant demand
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;