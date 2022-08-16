select location,str_to_date(date,'%m/%d/%y') as date, total_cases,new_cases,total_deaths, population
from portfolio.covid_death_data cd
order by 1,2;

use portfolio ;
update covid_death_data
set date = date_format(str_to_date(date,'%m/%d/%Y'),"%Y/%m/%d");
-- total cases vs total deaths

select location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 as death_percentage
from covid_death_data
order by 1,2;
-- the likehood to die in Africa on May 26, 2022 if you have covid was 2.14.%

-- total cases vs population
select location, date, population,(total_cases/ population)*100 as death_percentage
from covid_death_data
order by 1,2;

-- companies with highest infection rate compared to population
select location, date, population, max(total_cases) as highest_infection_count,max((total_cases/ population)*100) as death_percentage

from covid_death_data
group by location

order by death_percentage desc;

-- countries with highest death count per population
select location, max(cast(total_deaths as double)) as highest_death_count,max((cast(total_deaths as double)/ population)*100) as death_percentage
from covid_death_data
where continent is not null
group by location
order by death_percentage desc;


-- break things down by continent
select location, max(cast(total_deaths as double)) as highest_death_count,max(cast(total_deaths as double)/ population)*100 as death_percentage
from covid_death_data
where continent is not null
group by location
order by death_percentage desc;

-- continents with highest death count


-- global numbers


select location, date, sum(new_cases), sum(cast(new_deaths as double)), total_cases, total_deaths, sum(cast(new_deaths as double))/sum(new_cases)*100 as death_percentage, sum(new_vaccination)
over (partition by(location))
group by date
order by 1,2;

use portfolio;
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, sum(cv.new_vaccinations)
over(partition by cd.location order by location, date)
from covid_death_data as cd
join covid_vaccination_data as cv
on cd.location = cv.location
order by 1,2,3;

-- CTE

With PopvsVac(continent,location, population, date, new_vaccinations,newcol)
as(
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, sum(cv.new_vaccinations)
over(partition by cd.location order by location, date)
as newcol
from covid_death_data as cd
join covid_vaccination_data as cv
on cd.location = cv.location
-- order by 2,3
)
select * from PopvsVac;


-- creating view to store data for later visualizations
create view abs as 
select location, date,sum(cast(new_deaths as double)), total_cases, total_deaths, sum(cast(new_deaths as double))/sum(new_cases)*100 as death_percentage

from portfolio.covid_death_data
group by date
order by 1,2;
