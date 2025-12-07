/* 1. What are the top paying jobs for my role?
2. What are the skills required for these top paying roles?
3. What are the most in demand skills for my role?
4. What are the top skills based on salary for my role?
5. What are the most optimal skills to learn?
 a. Optimal: High demand and high paying */


--1. What are the top paying jobs for my role?--

SELECT 
    job_title_short,
     job_title,
     salary_year_avg,
     job_location,
     name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
Where job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_location = 'Anywhere'
ORDER BY salary_year_avg DESC
LIMIT 10;


