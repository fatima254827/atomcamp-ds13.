use manufacturing_lab;
-- just to look at the tables --
select * from stg_downtime_factors;
select * from stg_line_downtime_wide;
select * from stg_line_productivity;
select * from stg_products;

-- defining all the primary keys --

ALTER TABLE stg_products
ADD CONSTRAINT pk_products PRIMARY KEY (product);

ALTER TABLE stg_downtime_factors
ADD CONSTRAINT pk_factors PRIMARY KEY (factor);

ALTER TABLE stg_line_downtime_wide
ADD CONSTRAINT pk_downtime PRIMARY KEY (batch);

ALTER TABLE stg_line_productivity
ADD CONSTRAINT pk_productivity PRIMARY KEY (batch);


 -- defining possible foreign keys --
 
ALTER TABLE stg_line_productivity
ADD CONSTRAINT bat
FOREIGN KEY (batch)
REFERENCES stg_line_downtime_wide (batch);

ALTER TABLE stg_line_productivity
ADD CONSTRAINT prd
FOREIGN KEY (product)
REFERENCES stg_products (product);

-- point#1 using CASE, INNERJOIN,TIMESTAMPDIFF --

SELECT slp.product, sp.flavor, slp.operator, 
case
when  slp.end_time >= slp.start_time then
timestampdiff(minute,slp.start_time, slp.end_time) 
else 
timestampdiff(minute,slp.start_time, '24:00:00') + 
timestampdiff(minute,'00:00:00', slp.end_time) 
end as operating_minutes 

FROM stg_line_productivity slp
inner join stg_products sp on slp.product = sp.product;


-- Point # 2 USING COALESCE AND SUM WITH OUT USING JOIN JUST DOIN SIMPLE SUM  --

select batch , 
 COALESCE(SUM(
        COALESCE(factor_1_minutes, 0) +
        COALESCE(factor_2_minutes, 0) +
        COALESCE(factor_3_minutes, 0) +
        COALESCE(factor_4_minutes, 0) +
        COALESCE(factor_5_minutes, 0) +
        COALESCE(factor_6_minutes, 0) +
        COALESCE(factor_7_minutes, 0) +
        COALESCE(factor_8_minutes, 0) +
        COALESCE(factor_9_minutes, 0) +
        COALESCE(factor_10_minutes, 0) +
        COALESCE(factor_11_minutes, 0) +
        COALESCE(factor_12_minutes, 0)
    ), 0) as total_downtime_mins
 from stg_line_downtime_wide
 group by batch
 order by batch;
 
 
 -- POINT# 2 USING LEFT JOIN BUT FIRST WE NEED TOO UNPIVOT ------------------
 
 WITH factor_minutes AS (
    SELECT batch, 1 AS factor, COALESCE(factor_1_minutes,0) AS minutes FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 2, COALESCE(factor_2_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 3, COALESCE(factor_3_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 4, COALESCE(factor_4_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 5, COALESCE(factor_5_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 6, COALESCE(factor_6_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 7, COALESCE(factor_7_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 8, COALESCE(factor_8_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 9, COALESCE(factor_9_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 10, COALESCE(factor_10_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 11, COALESCE(factor_11_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 12, COALESCE(factor_12_minutes,0) FROM stg_line_downtime_wide
)
SELECT 
    lp.batch,
    COALESCE(SUM(fm.minutes),0) AS total_downtime_minutes
FROM stg_line_productivity lp
LEFT JOIN factor_minutes fm 
       ON lp.batch = fm.batch
GROUP BY lp.batch
ORDER BY lp.batch;

 
 -- point # 3 USING COALESCE, SUBQUERRY, NTILE--
 
 WITH batch_totals AS (
  SELECT
    batch,
    COALESCE(
      COALESCE(factor_1_minutes,0)+COALESCE(factor_2_minutes,0)+
      COALESCE(factor_3_minutes,0)+COALESCE(factor_4_minutes,0)+
      COALESCE(factor_5_minutes,0)+COALESCE(factor_6_minutes,0)+
      COALESCE(factor_7_minutes,0)+COALESCE(factor_8_minutes,0)+
      COALESCE(factor_9_minutes,0)+COALESCE(factor_10_minutes,0)+
      COALESCE(factor_11_minutes,0)+COALESCE(factor_12_minutes,0),0) AS total_downtime
  FROM stg_line_downtime_wide)
  
  -- SUBQUERRY--
SELECT batch, total_downtime
FROM (
  SELECT batch, total_downtime,
         NTILE(4) OVER (ORDER BY total_downtime DESC) AS quartile
  FROM batch_totals) t
WHERE quartile = 1;

-- point #4 USING CTE, INNNER JOIN --

WITH factor_totals AS (
    SELECT 1 AS factor, SUM(COALESCE(factor_1_minutes,0)) AS total_minutes FROM stg_line_downtime_wide
    UNION ALL
    SELECT 2, SUM(COALESCE(factor_2_minutes,0)) FROM stg_line_downtime_wide
    UNION ALL
    SELECT 3, SUM(COALESCE(factor_3_minutes,0)) FROM stg_line_downtime_wide
    UNION ALL
    SELECT 4, SUM(COALESCE(factor_4_minutes,0)) FROM stg_line_downtime_wide
    UNION ALL
    SELECT 5, SUM(COALESCE(factor_5_minutes,0)) FROM stg_line_downtime_wide
    UNION ALL
    SELECT 6, SUM(COALESCE(factor_6_minutes,0)) FROM stg_line_downtime_wide
    UNION ALL
    SELECT 7, SUM(COALESCE(factor_7_minutes,0)) FROM stg_line_downtime_wide
    UNION ALL
    SELECT 8, SUM(COALESCE(factor_8_minutes,0)) FROM stg_line_downtime_wide
    UNION ALL
    SELECT 9, SUM(COALESCE(factor_9_minutes,0)) FROM stg_line_downtime_wide
    UNION ALL
    SELECT 10, SUM(COALESCE(factor_10_minutes,0)) FROM stg_line_downtime_wide
    UNION ALL
    SELECT 11, SUM(COALESCE(factor_11_minutes,0)) FROM stg_line_downtime_wide
    UNION ALL
    SELECT 12, SUM(COALESCE(factor_12_minutes,0)) FROM stg_line_downtime_wide
)
SELECT f.factor, d.description, f.total_minutes
FROM factor_totals f
JOIN stg_downtime_factors d 
     ON f.factor = d.factor
ORDER BY f.total_minutes DESC
LIMIT 3;

-- point# 5 CTE, WINDOW RANKING RANK() --

WITH batch_totals AS (
    SELECT 
        batch,
        COALESCE(
            COALESCE(factor_1_minutes,0) +
            COALESCE(factor_2_minutes,0) +
            COALESCE(factor_3_minutes,0) +
            COALESCE(factor_4_minutes,0) +
            COALESCE(factor_5_minutes,0) +
            COALESCE(factor_6_minutes,0) +
            COALESCE(factor_7_minutes,0) +
            COALESCE(factor_8_minutes,0) +
            COALESCE(factor_9_minutes,0) +
            COALESCE(factor_10_minutes,0) +
            COALESCE(factor_11_minutes,0) +
            COALESCE(factor_12_minutes,0), 0
        ) AS total_downtime
    FROM stg_line_downtime_wide
)
SELECT 
    batch,
    total_downtime,
    RANK() OVER (ORDER BY total_downtime DESC) AS downtime_rank
FROM batch_totals
ORDER BY downtime_rank;

-- point#6 USING COALESCE, UNION ALL, OVER (PARTITION BY … ORDER BY …)--

WITH factor_totals AS (
    SELECT batch, 1 AS factor, COALESCE(factor_1_minutes,0) AS minutes FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 2, COALESCE(factor_2_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 3, COALESCE(factor_3_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 4, COALESCE(factor_4_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 5, COALESCE(factor_5_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 6, COALESCE(factor_6_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 7, COALESCE(factor_7_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 8, COALESCE(factor_8_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 9, COALESCE(factor_9_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 10, COALESCE(factor_10_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 11, COALESCE(factor_11_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 12, COALESCE(factor_12_minutes,0) FROM stg_line_downtime_wide
)
SELECT 
    factor,
    batch,
    minutes,
    SUM(minutes) OVER (PARTITION BY factor ORDER BY batch ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM factor_totals
ORDER BY factor, batch;

-- point# 7 USING COALESCE, UNION ALL, CASE, SUM --

WITH factor_minutes AS (
    SELECT batch, 1 AS factor, COALESCE(factor_1_minutes,0) AS minutes FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 2, COALESCE(factor_2_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 3, COALESCE(factor_3_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 4, COALESCE(factor_4_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 5, COALESCE(factor_5_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 6, COALESCE(factor_6_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 7, COALESCE(factor_7_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 8, COALESCE(factor_8_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 9, COALESCE(factor_9_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 10, COALESCE(factor_10_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 11, COALESCE(factor_11_minutes,0) FROM stg_line_downtime_wide
    UNION ALL
    SELECT batch, 12, COALESCE(factor_12_minutes,0) FROM stg_line_downtime_wide
)
SELECT 
    f.batch,
    SUM(CASE WHEN d.operator_error = 1 THEN f.minutes ELSE 0 END) AS operator_downtime,
    SUM(CASE WHEN d.operator_error = 0 THEN f.minutes ELSE 0 END) AS non_operator_downtime
FROM factor_minutes f
JOIN stg_downtime_factors d ON f.factor = d.factor
GROUP BY f.batch
ORDER BY f.batch;

-- point# 8 UAING CTE, TIMESTAMPDIFF, CASE, AVG, STDDEV_SAMP, ROUND, NULLIF, Z-score formula = (duration - avg) / stddev --

WITH batch_durations AS (
    SELECT 
        slp.operator,
        slp.batch,
        -- Handle same-day vs crossing-midnight batches
        CASE
            WHEN slp.end_time >= slp.start_time THEN 
                TIMESTAMPDIFF(MINUTE, slp.start_time, slp.end_time)
            ELSE 
                TIMESTAMPDIFF(MINUTE, slp.start_time, '23:59:59') + 1 +
                TIMESTAMPDIFF(MINUTE, '00:00:00', slp.end_time)
        END AS duration_minutes
    FROM stg_line_productivity slp
),
stats AS (
    SELECT 
        operator,
        AVG(duration_minutes) AS avg_duration,
        STDDEV_SAMP(duration_minutes) AS stddev_duration
    FROM batch_durations
    GROUP BY operator
)
SELECT 
    b.operator,
    b.batch,
    b.duration_minutes,
    ROUND((b.duration_minutes - s.avg_duration) / NULLIF(s.stddev_duration,0), 2) AS z_score
FROM batch_durations b
JOIN stats s ON b.operator = s.operator
ORDER BY b.operator, b.batch;

-- ------------ NOTE I TOOK HELP FROM CHATGPT TO UNDERTSAND FEW CONCEPTS LIKE Z FORMULA, COALESCE , NTILE ETC  -------

