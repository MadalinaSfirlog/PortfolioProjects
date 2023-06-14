/****** Script  ******/


SELECT *
FROM [dbo].[ordini csv]


-- Convert the datetime into date 
SELECT [Data Ora]
FROM [dbo].[ordini csv]


Select [Data Ora], CONVERT(Date,[Data Ora]) as Data
From [dbo].[ordini csv]


Update [dbo].[ordini csv]
SET [Data Ora] = CONVERT(Date,[Data Ora]) 



-- use the sp_rename system stored procedure
EXEC sp_rename 'dbo.[ordini csv].[Data Ora]', 'Data', 'COLUMN';



-- Delete empty Order ID 
Select*
From [dbo].[ordini csv]
Where [Order ID] = ''


DELETE FROM [dbo].[ordini csv]
Where [Order ID] = ''


SELECT *
FROM [dbo].[ordini csv]



-- Split Città and Stato into 2 separate columns 
SELECT [Città Stato]
FROM [dbo].[ordini csv]


SELECT
SUBSTRING([Città Stato], 1, CHARINDEX(',', [Città Stato]) -1 ) as Città
, SUBSTRING([Città Stato], CHARINDEX(',', [Città Stato]) + 1 , LEN([Città Stato])) as Stato
From [ordini csv]


ALTER TABLE [ordini csv]
Add Città Nvarchar(255);


Update [ordini csv]
SET Città = SUBSTRING([Città Stato], 1, CHARINDEX(',', [Città Stato]) -1 ) 


SELECT *
FROM [dbo].[ordini csv]


ALTER TABLE [ordini csv]
Add Stato Nvarchar(255);


Update [ordini csv]
SET [Stato] = SUBSTRING([Città Stato], CHARINDEX(',', [Città Stato]) + 1 , LEN([Città Stato])) 


SELECT *
FROM [dbo].[ordini csv]


-- Eliminate the columns COD 
ALTER TABLE [dbo].[ordini csv]
DROP COLUMN COD;

SELECT *
FROM [dbo].[ordini csv]



-- Remove duplicates 
WITH RowNumCTE AS (
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY [Order ID], 
				 [Categoria],
				 [Sotto categoria],
				 Prezzo
				 ORDER BY
					[Order ID]
					) as numero_righe

From [dbo].[ordini csv] 
)
DELETE
From RowNumCTE
Where numero_righe > 1



-- Check if still there are duplicates 
WITH RowNumCTE AS (
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY [Order ID], 
				 [Categoria],
				 [Sotto categoria],
				 Prezzo
				 ORDER BY
					[Order ID]
					) as numero_righe

From [dbo].[ordini csv] 
)
SELECT *
From RowNumCTE
Where numero_righe > 1



SELECT *
FROM [dbo].[ordini csv]


-- Rename Tiplogia and Regggione 
EXEC sp_rename 'dbo.[ordini csv].[Tiplogia]', 'Tipologia', 'COLUMN';
EXEC sp_rename 'dbo.[ordini csv].[Regggione]', 'Regione', 'COLUMN';




-- Lower case for Regione 
UPDATE [dbo].[ordini csv]
SET Regione = LOWER(Regione)


-- Extract values from a string 
SELECT SUBSTRING([Order ID], 9, 6) as ID 
FROM [dbo].[ordini csv]




-- Categorise the column Price 
SELECT Prezzo,
    CASE
        WHEN Prezzo < 1000 THEN 'Low'
        WHEN Prezzo >= 1000 AND Prezzo < 2000 THEN 'Medium'
        ELSE 'High'
    END AS Prezzo_Categoria
FROM [dbo].[ordini csv];



-- Check the length of the CAP 
SELECT
  IIF(LEN(CAP) = 5, 'corretto', NULL) AS Controllo_Cap
FROM [dbo].[ordini csv];



-- Email Check
SELECT *
FROM [dbo].[ordini csv]


select
  case
     when charindex('@', Email) != 0 then 'Email corretta'
     else null
  end AS Email_Check
from [dbo].[ordini csv]



select
  case
     when Email LIKE '%.it' then 'Email corretta'
     else null
  end AS Controllo_Email
from [dbo].[ordini csv]
