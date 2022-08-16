use portfolio;
select count(*) as num_of_rows from dataset1 ;
select count(*) from dataset2;
select * from dataset1 where
State in ('Jharkhand','Bihar');
-- total popultation of India
select sum(Population) total_population from dataset2;
-- average growth of India
select growth from dataset1;
select avg(growth) AvgGrowthPercentage from dataset1;
select state,avg(growth) AGPS from dataset1 group by state
order by state;
-- avg sex ratio
select state,round(avg(sex_ratio),0) ASR from dataset1 group by state
order by ASR desc;
-- avg literacy rate
select state,round(avg(literacy),0) ALR from dataset1 group by state
having ALR > 90
order by ALR desc;
-- top three states with highest average growth ration
select state,avg(growth) AGPS from dataset1 group by state
order by AGPS desc
limit 3;
-- bottom three states with lowest average sex ratio ration
select state,round(avg(sex_ratio),0) ASR from dataset1 group by state
order by ASR
limit 3;
-- top 3 and bottom three
select state,round(avg(literacy),0) ALR from dataset1 group by state
order by ALR desc;
drop table if exists topstates;
create table topstates
(
state char(255) null,
topstates float null
);
insert into topstates
select state,round(avg(literacy),0) ALR from dataset1 group by state
order by ALR
limit 3;
select * from topstates;

drop table if exists bottomstates;
create table bottomstates
(
state char(255) null,
topstates float null
);
insert into bottomstates
select state,round(avg(literacy),0) ALR from dataset1 group by state
order by ALR desc
limit 3;
select * from bottomstates;

select * from(select state,round(avg(literacy),0) ALR from dataset1 group by state
order by ALR desc
limit 3) bottom3
union
select * from(select state,round(avg(literacy),0) ALR from dataset1 group by state
order by ALR
limit 3) top3;

-- filter states with first letter a
select * from dataset1 where lower(state) like 'a%';
select distinct state from dataset1 where lower(state) like 'a%';
select distinct state from dataset1 where lower(state) like 'a%' or  lower(state) like 'b%';
select a.district, a.state,a.sex_ratio, b.population,b.population/(a.sex_ratio + 1) as male from dataset1 a inner join dataset2 b on
a.district = b.district;

