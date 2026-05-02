--------------------------------------------------------------------------------------
--Data inspection
--------------------------------------------------------------------------------------

select * from `workspace`.`default`.`car_sales_data` limit 100;
---------------------------------------------------------------------------------------
--remove duplicates
---------------------------------------------------------------------------------------
select distinct model,
                make,
                transmission,
                body 
                from `workspace`.`default`.`car_sales_data`;
------------------------------------------------------------------------------------------
--min and max odometer
------------------------------------------------------------------------------------------
select min(odometer) from `workspace`.`default`.`car_sales_data`;

select max(odometer) from `workspace`.`default`.`car_sales_data`;
------------------------------------------------------------------------------------------
--min and max selling price
------------------------------------------------------------------------------------------
select min(sellingprice) from `workspace`.`default`.`car_sales_data`;

select max(sellingprice) from `workspace`.`default`.`car_sales_data`;
------------------------------------------------------------------------------------------  


select distinct year from `workspace`.`default`.`car_sales_data` Ascending;

------------------------------------------------------------------------------------------
--avg selling price
------------------------------------------------------------------------------------------

select avg(sellingprice) from `workspace`.`default`.`car_sales_data`;

------------------------------------------------------------------------------------------
--make and model that is white
------------------------------------------------------------------------------------------
select make,model from `workspace`.`default`.`car_sales_data`
            where color='white';
------------------------------------------------------------------------------------------

     









------------------------------------------------------------------------------------------------

SELECT 
--Removing null
    coalesce(transmission,'Unknown') as transmission,
    coalesce(CAST(condition AS STRING),'Unknown') as condition,
    coalesce(CAST(odometer AS STRING),'Unknown') as odometer,
    coalesce(CAST(year AS STRING),'Unknown') as year,
    coalesce(body,'Unknown') as body,
    coalesce(model,'Unknown') as model,   
    coalesce(make,'Unknown') as make,  
    coalesce(state,'Unknown') as state,
    coalesce(interior,'Unknown') as interior,
    coalesce(seller,'Unknown') as seller,
    coalesce(color,'Unknown') as color,
--calculate Total_average,selling_price and cost_price
    Avg(CAST(REPLACE(mmr, ',', '') AS DOUBLE) * CAST(REPLACE(sellingprice, ',', '') AS DOUBLE)) as Total_Average,
    saledate,
    CAST(REPLACE(sellingprice, ',', '') AS DOUBLE) AS selling_price,
    CAST(REPLACE(mmr, ',', '') AS DOUBLE) AS cost_price,
    try_divide((CAST(REPLACE(sellingprice, ',', '') AS DOUBLE) - CAST(REPLACE(mmr, ',', '') AS DOUBLE)), CAST(REPLACE(sellingprice, ',', '') AS DOUBLE)) * 100 AS profit_margin,
--Profit or loss Margin
    CASE 
      WHEN CAST(REPLACE(mmr, ',', '') AS DOUBLE) > CAST(REPLACE(sellingprice, ',', '') AS DOUBLE) THEN 'Loss'
      WHEN CAST(REPLACE(mmr, ',', '') AS DOUBLE) = CAST(REPLACE(sellingprice, ',', '') AS DOUBLE) THEN 'Break Even'
      WHEN CAST(REPLACE(mmr, ',', '') AS DOUBLE) < CAST(REPLACE(sellingprice, ',', '') AS DOUBLE) THEN 'Profit'
      ELSE 'Profit'
    END as Profit_or_Loss,
--years category
    CASE 
        WHEN year between 1982 and 1999 then 'Vuntage'
        WHEN year between 2000 and 2009 then 'modern'
        WHEN year between 2010 and 2019 then 'new'
        WHEN year Between 2020 and 2030 then 'future'
        ELSE 'future'
        END as year_category
  
  FROM  `workspace`.`default`.`car_sales_data`
  group by transmission,
           body, 
           model, 
           make, 
           year,
           saledate,
           state,
           condition,
           odometer,
           interior,
           seller,
           color,
           CAST(REPLACE(sellingprice, ',', '') AS DOUBLE),
           CAST(REPLACE(mmr, ',', '') AS DOUBLE),
           try_divide((CAST(REPLACE(sellingprice, ',', '') AS DOUBLE) - CAST(REPLACE(mmr, ',', '') AS DOUBLE)), CAST(REPLACE(sellingprice, ',', '') AS DOUBLE)) * 100,
           CASE 
             WHEN CAST(REPLACE(mmr, ',', '') AS DOUBLE) > CAST(REPLACE(sellingprice, ',', '') AS DOUBLE) THEN 'Loss'
             WHEN CAST(REPLACE(mmr, ',', '') AS DOUBLE) = CAST(REPLACE(sellingprice, ',', '') AS DOUBLE) THEN 'Break Even'
             WHEN CAST(REPLACE(mmr, ',', '') AS DOUBLE) < CAST(REPLACE(sellingprice, ',', '') AS DOUBLE) THEN 'Profit'
             ELSE 'Profit'
           END;
      
