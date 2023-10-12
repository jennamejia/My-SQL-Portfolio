/*
Covid 19 Data Exploration

Skills used: Joins, CTE's, Windows Functions, Aggregate Functionns, Converting Data Types

*/

-- Select Data that we are going to be using

Select location, date, total_cases, new_cases, total_deaths, population
From covid_project.covid_deaths
Where continent is not null
order by 1,2;


-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From covid_project.covid_deaths
Where continent is not null
Order by 1,2;


-- Looking at Total Cases vs Population
-- Shows what percentage of population infected with Covid

Select location, date, total_cases, population, (total_cases/population)*100 as PercentPopulationInfected
From covid_project.covid_deaths
-- where location like ‘%states%’
Order by 1,2;


-- Countries with Highest Infection Rate compared to Population

Select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From covid_project.covid_deaths
-- where location like '%states%'
Group by location, population
Order by PercentPopulationInfected desc;


-- Countries with Highest Death Count per Population

Select location, population, MAX(total_deaths) as HighestDeathCount, MAX((total_deaths/population))*100 as PercentPopulationDead
From covid_project.covid_deaths
-- where location like '%states%'
Group by location, population
Order by PercentPopulationDead desc;


-- BREAKING THINGS DOWN BY CONTINENT

-- Showing Continents with the Highest Death Count per Population

Select continent, population, MAX(total_deaths) as HighestDeathCount, MAX((total_deaths/population))*100 as PercentPopulationDead
From covid_project.covid_deaths
Where continent is not null
Group by continent, population
Order by PercentPopulationDead desc;


-- GLOBAL NUMBERS

Select date, SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, (SUM(New_deaths)/SUM(new_cases))*100 as deathpercentage
From covid_project.covid_deaths
-- Where location like ‘%states%’
Where continent is not null
Group by date
Order by 1,2;


-- Looking at Total Population vs Vaccinations
-- Shows Percentage of Population that has received at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(vac.new_vaccinations) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/Population)*100
From covid_project.covid_deaths as dea
Join covid_project.covid_vaccinations as vac
	On dea.location = vac.location
    and dea.date = vac.date
Where dea.continent is not null
Order by dea.location, dea.date;


-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(vac.new_vaccinations) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/Population)*100
From covid_project.covid_deaths as dea
Join covid_project.covid_vaccinations as vac
	On dea.location = vac.location
    and dea.date = vac.date
Where dea.continent is not null
-- Order by dea.location, dea.date
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac;

