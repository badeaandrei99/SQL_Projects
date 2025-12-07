/* 1. What are the top paying jobs for my role?
2. What are the skills required for these top paying roles?
3. What are the most in demand skills for my role?
4. What are the top skills based on salary for my role?
5. What are the most optimal skills to learn?
 a. Optimal: High demand and high paying */


-- 5.What are the most optimal skills to learn?
--  a.Optimal: High demand and high paying  

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
     ROUND(AVG(salary_year_avg),0) AS avg_year_salary,
    skills,
    COUNT(*) AS demand_count
 FROM job_skills
 WHERE salary_year_avg IS NOT NULL 
 GROUP BY skills
 HAVING COUNT(*) > 10 -- Only include skills that appear in more than 10 job postings, indicating significant demand
 ORDER BY avg_year_salary DESC,
         demand_count DESC
LIMIT 50;