-- Basic statistics:

select  COUNTRY , sum(TOTAL_VACCINATIONS) as Total_vaccination
from vaccination
WHERE TOTAL_VACCINATIONS IS Not NULL
group by COUNTRY
order by Total_vaccination desc;

select  WHO_REGION as Region , sum(TOTAL_VACCINATIONS) as Total_vaccination
from vaccination
WHERE TOTAL_VACCINATIONS IS Not NULL
group by Region
order by Total_vaccination desc;

select Country , sum(New_cases) as infection, sum(New_deaths) as deaths
from COVID_19_global_data
group by Country
order by infection desc;

select country , avg(New_cases) as avg_num_vaccination , avg(New_deaths) as avg_num_deaths
from  COVID_19_global_data
group by country
order by avg_num_vaccination desc ;


-- Comparative analysis:

select Country , max(PERSONS_FULLY_VACCINATED) as highest_vacc_rate from vaccination;
select Country , min(PERSONS_FULLY_VACCINATED) as highest_vacc_rate from vaccination;

select country , PERSONS_FULLY_VACCINATED_PER100 ,
       case
           when PERSONS_FULLY_VACCINATED_PER100 between 1 and 29  THEN  'Low Vaccination'
           when PERSONS_FULLY_VACCINATED_PER100 between 30 and 49 THEN 'Partially Vaccinated'
           when PERSONS_FULLY_VACCINATED_PER100 between 50 and 70 THEN 'Moderately Vaccinated'
           when PERSONS_FULLY_VACCINATED_PER100 > 70 THEN 'Highly Vaccinated'
           ELSE 'Unvaccinated'
END AS Category
from vaccination
order by Category ;

-- How does the infection rate vary based on the vaccination status (Highly vaccinated, partially vaccinated, unvaccinated) of   individuals?
select v.country , ROUND(sum(c.New_cases) ,2) as Total_infection
       , v.PERSONS_FULLY_VACCINATED_PER100 || " %"  as FULLY_VACCINATED ,
       case
           when v.PERSONS_FULLY_VACCINATED_PER100 between 1 and 29  THEN  'Low Vaccination'
           when v.PERSONS_FULLY_VACCINATED_PER100 between 30 and 49 THEN 'Partially Vaccinated'
           when v.PERSONS_FULLY_VACCINATED_PER100 between 50 and 70 THEN 'Moderately Vaccinated'
           when v.PERSONS_FULLY_VACCINATED_PER100 > 70 THEN 'Highly Vaccinated'
           ELSE 'Unvaccinated'
END AS Category
from vaccination v
inner join COVID_19_global_data c on v.COUNTRY = c.Country
group by c.Country
order by c.Country desc ;

--How has the number of vaccinations changed over time in a specific country/region?
select country ,sum(New_cases) ,strftime('%m/%Y',Date_reported) as Month_reported
from COVID_19_global_data
where Country_code == 'US'
group by Month_reported
order by  Date_reported ;

-- What is the daily average of new cases and deaths over a given period?

select country ,Country_code , round(avg(New_cases) ,2) as Avg_infection ,
       round(avg(New_deaths)) as Avg_deaths
from COVID_19_global_data
where Date_reported between '2020-01-01' and '2023-01-01'
group by Country
order by Avg_infection desc ;

-- Are there any seasonal patterns in infection rates?

select WHO_region ,max(New_cases)  ,strftime('%m/%Y',Date_reported) as Month_reported
from COVID_19_global_data
group by WHO_region
order by  WHO_region ;

-- the regions had the maximum infection cases between 05/2021 and 01/2022

select Country ,max(PERSONS_FULLY_VACCINATED )
from vaccination ;
select Country ,max(New_cases )
from COVID_19_global_data ;
select Country ,max(New_deaths )
from COVID_19_global_data;

-- china has the top cases of infection and death cases and persons fully vaccinated but ..
select Country ,PERSONS_FULLY_VACCINATED_PER100
from vaccination where COUNTRY=='China';
-- the population of china is : 1,439,323,776
select Country ,max(New_deaths ) as max_death ,
       ((max(New_deaths )* 100)/1439323776 ) || " %" as persontage_of_deaths
from COVID_19_global_data where COUNTRY=='China';

select Country ,max(New_cases ) as max_death ,
       ((max(New_deaths )* 100)/1439323776 ) || " %" as persontage_of_deaths
from COVID_19_global_data where COUNTRY=='China' ;

-- but the percentages is low then 0 %

select country ,NUMBER_VACCINES_TYPES_USED
from vaccination
where NUMBER_VACCINES_TYPES_USED is not null
order by NUMBER_VACCINES_TYPES_USED desc ;

select v.country ,PERSONS_FULLY_VACCINATED_PER100 , sum(New_cases) , sum(New_deaths)
from COVID_19_global_data c
join vaccination v on c.Country = v.COUNTRY
group by v.COUNTRY ;

select v.country , v.WHO_REGION ,PERSONS_FULLY_VACCINATED_PER100 ,  sum(New_deaths) as sum_deaths
from COVID_19_global_data c
join vaccination v on c.Country = v.COUNTRY
group by v.WHO_REGION , v.COUNTRY
order by v.WHO_REGION , v.COUNTRY , sum_deaths ;












