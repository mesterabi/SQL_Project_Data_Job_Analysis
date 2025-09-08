/*
Project: Most In-Demand Skills for Data Analysts

Question: What are the most in-demand skills for Data Analysts?
- Dataset: All job postings with 'Data Analyst' as the job title
- Focus: Identify the top 5 skills with the highest demand
- Why: Highlights the most sought-after skills in the job market, guiding job seekers 
       on which technical competencies to prioritize for career growth
*/



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
    job_posting.job_title_short = 'Data Analyst'
GROUP BY 
    skill.skill_id, skill.skills
ORDER BY 
    demand_count DESC
LIMIT 5;

-- Full JSON results saved to: top_demanded_skill_result.json
