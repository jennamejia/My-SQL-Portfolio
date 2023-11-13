/*
For this project I queried retail scan data on avocados sold in the US in 2018, utilizing aggregate and mathematical functions

Data from Kaggle: https://www.kaggle.com/datasets/neuromusic/avocado-prices
*/

SELECT * FROM sql_projects.avocado where region='TotalUS';

-- The most to least sold avocados by specific region
select *
from sql_projects.avocado
where region != 'TotalUS'
order by totalvolume desc;

-- Comparing average price and total volume sold of conventional vs organic avocados
select type, round(avg(averageprice),2) as averageprice, round(sum(totalvolume),2) as totalvolume
from sql_projects.avocado
group by type
order by averageprice;

-- List of avocado types ordered by average price per avocado
select averageprice, totalvolume, type, region
from sql_projects.avocado
order by averageprice;

-- Top 10 revenue values of conventional avocados by specific region
select round((averageprice)*(totalvolume),2) as total_revenue,
	type,
    region
from sql_projects.avocado
where region != 'TotalUS' and type = 'conventional'
order by total_revenue desc
limit 10;

-- Top 10 revenue values of organic avocados by specific region
select round((averageprice)*(totalvolume),2) as total_revenue,
	type,
    region
from sql_projects.avocado
where region != 'TotalUS' and type = 'organic'
order by total_revenue desc
limit 10;

-- Top 10 average total revenue values by specific region
select round(avg(totalvolume),2) as avg_revenue, region
from sql_projects.avocado
where region != 'TotalUS'
group by region
order by avg_revenue desc
limit 10;

-- Yearly average total revenue and total volume of avocados sold in all of the U.S.
select year, round((totalvolume),2) as avg_revenue, totalvolume, type
from sql_projects.avocado
where region = 'TotalUS'
order by avg_revenue desc;
-- According to our output, conventional avocados in 2018 returned the highest average total revenue

-- Compares the average total volume of organic vs conventional avocados sold
SELECT
  round(avg(CASE WHEN type = 'organic' THEN totalvolume END), 2) AS avg_organic_sold,
  round(avg(CASE WHEN type = 'conventional' THEN totalvolume END), 2) AS avg_conventional_sold,
  region
FROM sql_projects.avocado
WHERE region != 'TotalUS' AND type IN ('organic', 'conventional')
GROUP BY region;

-- Compares the average total revenue of organic vs conventinoal avocados sold
SELECT
  round(avg(CASE WHEN type = 'organic' THEN (averageprice*totalvolume) END), 2) AS avg_organic_revenue,
  round(avg(CASE WHEN type = 'conventional' THEN (averageprice*totalvolume) END), 2) AS avg_conventional_revenue,
  region
FROM sql_projects.avocado
WHERE region != 'TotalUS' AND type IN ('organic', 'conventional')
GROUP BY region;
