select * 
from dbo.videogames

-- Alle Nintendo Games -- 
select *
from dbo.videogames
where Publisher = 'Nintendo' 


 /* Alle Pokemongames in den 90er Jahren*/
select * 
from dbo.videogames
where Publisher = 'Nintendo' AND Year_of_Release < 2000  AND Year_of_Release >= 1990 AND Name LIKE '%pokemon%'
ORDER BY Year_of_Release ASC


/* Das meistverkaufte Pokemonspiel der 90er in Japan */ 

SELECT Name, JP_Sales as 'Japan Sales' 
from dbo.videogames
WHERE JP_Sales = (Select MAX(JP_SALES) as bestseller
from dbo.videogames
where Publisher = 'Nintendo' AND Year_of_Release < 2000  AND Year_of_Release >= 1990 AND Name LIKE '%pokemon%')

/* Das meistverkaufte Pokemonspiel der 90er in Europa */ 

SELECT Name, EU_Sales as 'Europe Sales' 
from dbo.videogames
WHERE EU_Sales = (Select MAX(EU_Sales ) as bestseller
from dbo.videogames
where Publisher = 'Nintendo' AND Year_of_Release < 2000  AND Year_of_Release >= 1990 AND Name LIKE '%pokemon%')


/* Wo wurde Pokemon ausserhalb von Japan am meisten verkauft */ 

SELECT Name, Platform,
	CASE
		WHEN EU_Sales > NA_Sales AND EU_Sales > Other_Sales THEN 'Europa'
		WHEN NA_Sales > EU_Sales AND NA_Sales > Other_Sales THEN 'North America'
		ELSE 'Other'
	END AS 'Most Sold'
from dbo.videogames
where Publisher = 'Nintendo' AND Year_of_Release < 2000  AND Year_of_Release >= 1990 AND Name LIKE '%pokemon%'


/* Alle PS Games */ 
select *
from dbo.videogames
where Platform LIKE '%ps%'
ORDER BY Global_Sales DESC

/* meist verkaufteste PS Spiel allerzeiten */ 

select Name, Platform, Year_of_Release, Genre, Publisher, Global_Sales
from dbo.videogames
WHERE Global_Sales = (
	SELECT MAX(Global_Sales)
	from dbo.videogames
	WHERE Platform LIKE '%ps%'
	)


/* Verkaufsflopps von PS SPielen*/

select Name, Platform, Year_of_Release, Genre, Publisher, Global_Sales
from dbo.videogames
WHERE Platform LIKE '%ps%' AND  Global_Sales = (
	SELECT MIN(Global_Sales)
	from dbo.videogames
	)

	------------------------------------------------------------------------------------------

/* Anzahl der Spiele pro Genre */ 
select Genre, COUNT(Genre) as 'count'
from dbo.videogames
WHERE Genre IS NOT NULL
Group by Genre
ORDER BY count DESC 

/* Welche Platform hat die meisten Actionspiele */ 
SELECT Platform, COUNT(Platform) as 'Anzahl der Actiongames' 
FROM dbo.videogames
WHERE Genre = 'Action'
GROUP BY Platform
ORDER BY 'Anzahl der Actiongames' DESC 

-- Durschnittle Global Sales im Gerne Action für Playstations

SELECT Platform, ROUND(AVG(Global_Sales),2) as 'Average Global Sales' 
from dbo.videogames
WHERE Genre = 'Action' AND Platform LIKE '%ps%'
GROUP BY Platform

-- Durschnittle Global Sales im Gerne Action nach Platform
SELECT Platform, ROUND(AVG(Global_Sales),2) as 'Average Global Sales' 
from dbo.videogames
WHERE Genre = 'Action'
GROUP BY Platform
ORDER BY 'Average Global Sales' DESC 

-- Durschnittliche Global Sales je nach Genre 

SELECT Genre, COUNT(Name) as 'Games', ROUND(AVG(Global_Sales),2) as 'Average Global Sales'
from dbo.videogames
WHERE Genre IS NOT NULL 
GROUP BY Genre 
ORDER BY 'Average Global Sales' DESC

/* Erkenntnis: Obwohl das Action Genre die meisten Spiele hat, ist es bei den durchschnittlichen Verkaufszahlen auf Platz 7 */ 

-- Todo Verhältnis Anzahl spiele und Global Sales ... (?)
------------------------------------------------------------------------------------
/* Durschnittliche Global Sales je nach Genre

Erkenntnis: In den 90er Jahren war das Roleplaying Gerne weitaus beliebert als jetzt. 

*/ 
SELECT Genre, COUNT(Name) as 'Games', ROUND(AVG(Global_Sales),2) as 'Average Global Sales'
from dbo.videogames
WHERE Genre IS NOT NULL AND Year_of_Release < 2000 AND Year_of_Release >= 1990
GROUP BY Genre 
ORDER BY 'Average Global Sales' DESC

-- Nintendos Verkaufszahlen über die Jahre
-- Erkenntnis: Die Verkaufsstärkste Zeit für Nintend war in den 80er Jahren obwohl sie da die wenigsten Spiele rausgebracht haben. 

SELECT Publisher, COUNT(Name) as 'Released Games', AVG(Global_Sales) As 'Global Revenue 90s'
from dbo.videogames
WHERE Publisher ='Nintendo' AND Year_of_Release < 2000 AND Year_of_Release >= 1990
GROUP BY Publisher

SELECT Publisher, COUNT(Name) as 'Released Games', AVG(Global_Sales) As 'Global Revenue 80s'
from dbo.videogames
WHERE Publisher ='Nintendo' AND Year_of_Release < 1990 AND Year_of_Release >= 1980
GROUP BY Publisher

SELECT Publisher, COUNT(Name) as 'Released Games', AVG(Global_Sales) As 'Global Revenue 2000s'
from dbo.videogames
WHERE Publisher ='Nintendo' AND Year_of_Release >= 2000
GROUP BY Publisher
