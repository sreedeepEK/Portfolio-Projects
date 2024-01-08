select * from coviddeaths;
select * from covidvaccinations;

 -- Looking at Total Cases vs Total Deaths
select Location  ,date , total_cases,total_deaths,
(total_deaths/total_cases)*100 as DeathPercentage
from coviddeaths;

-- Looking at Total Cases vs Population
select Location , date , total_cases, Population,
(total_cases/population)*100 as Populationpercentage
from coviddeaths;

-- Looking at countries with High Infection Rate 
select Location,population , MAX(total_cases) as HighInfection,
MAX(total_deaths/Population)*100 as Infected
from coviddeaths
group by location,population
order by HighInfection desc;

-- Showing countries with Highest Death Count per Population
select Location, MAX(total_deaths ) as TotalDeath
from coviddeaths
group by location
order by TotalDeath desc;

-- Sorting Highest death count by Continent
select Continent, max(total_deaths) as TotalDeath
from coviddeaths
where continent is not null
group by continent
order by TotalDeath desc;

-- Sorting the total global numbers
select SUM(new_cases) as total_cases, SUM(new_deaths)as total_deaths,
 SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
from coviddeaths where continent is not null;

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3

-- Creating View to store data for later visualizations
Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
On dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null 











 
