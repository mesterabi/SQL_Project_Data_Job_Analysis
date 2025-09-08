/*
Project: Salary Insights by Skills for Data Analysts

Question: What are the top skills based on salary for Data Analyst roles?
- Dataset: All Data Analyst job postings with specified salaries
- Focus: Compute average salary per skill to identify the most financially rewarding skills
- Filters: Only postings with non-null salaries and remote-friendly roles (work-from-home)
- Key Takeaways:
    • Big data processing: PySpark, Databricks, Scala, Airflow
    • DevOps & pipeline collaboration: GitLab, Bitbucket, Jenkins, Atlassian
    • Python + analytics libraries: Pandas, NumPy, Scikit-learn, Jupyter
    • Cloud & platform expertise: GCP, Kubernetes, Linux, Watson, DataRobot
    • These trends indicate a shift toward hybrid data engineering + analytics roles in top-paying jobs
- Why: Highlights which skills correlate with higher salaries, helping job seekers focus on high-value technical competencies
*/



SELECT 
    skill.skills,
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
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;

-- Full JSON results saved to: 4_top_paying_skills.json
