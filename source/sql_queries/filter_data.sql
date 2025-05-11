WITH durations AS (
  SELECT 
    o.sector_id,
    CASE 
      WHEN TO_DAYS(rs.segment_start_time) = TO_DAYS(rs.segment_end_time)
        THEN TIME_TO_SEC(TIMEDIFF(TIME(rs.segment_end_time), TIME(rs.segment_start_time)))
      ELSE TIME_TO_SEC(TIMEDIFF('23:59:59', TIME(rs.segment_start_time))) +
           TIME_TO_SEC(TIMEDIFF(TIME(rs.segment_end_time), '00:00:00'))
    END AS real_delivery_duration,
    CASE 
      WHEN TO_DAYS(rs.segment_start_time) = TO_DAYS(rs.segment_end_time)
        THEN 0
      ELSE 1
    END AS midnight,
    o.planned_delivery_duration
  FROM route_segments rs
  LEFT JOIN orders o ON rs.order_id = o.order_id
  HAVING real_delivery_duration > 0
),
numbered AS (
  SELECT *, ROW_NUMBER() OVER (ORDER BY real_delivery_duration) AS rn
  FROM durations
),
counted AS (
  SELECT COUNT(*) AS total_rows FROM numbered
),
filtered AS (
  SELECT n.*
  FROM numbered n, counted c
  WHERE n.rn > FLOOR(c.total_rows * 0.02)
    AND n.rn <= CEIL(c.total_rows * 0.98)
)
SELECT *
FROM filtered;