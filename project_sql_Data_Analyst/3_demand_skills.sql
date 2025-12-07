/* 1. What are the top paying jobs for my role?
2. What are the skills required for these top paying roles?
3. What are the most in demand skills for my role?
4. What are the top skills based on salary for my role?
5. What are the most optimal skills to learn?
 a. Optimal: High demand and high paying */


--3. What are the most in demand skills for my role?--

WITH job_skills AS (SELECT 
    job_title_short,
     job_title,
     salary_year_avg,
     job_location,
     name AS company_name,
     skills,
     type AS skill_type
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
Where job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere'
)

SELECT
    skills,
    COUNT(*) AS demand_count
FROM job_skills
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;