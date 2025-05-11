SELECT 
  o.sector_id,
  CASE 
    WHEN HOUR(rs.segment_start_time) BETWEEN 6 AND 8 THEN '06-08'
    WHEN HOUR(rs.segment_start_time) BETWEEN 8 AND 10 THEN '08-10'
    WHEN HOUR(rs.segment_start_time) BETWEEN 10 AND 12 THEN '10-12'
    WHEN HOUR(rs.segment_start_time) BETWEEN 12 AND 14 THEN '12-14'
    WHEN HOUR(rs.segment_start_time) BETWEEN 14 AND 16 THEN '14-16'
    WHEN HOUR(rs.segment_start_time) BETWEEN 16 AND 18 THEN '16-18'
    WHEN HOUR(rs.segment_start_time) BETWEEN 18 AND 10 THEN '18-20'
    WHEN HOUR(rs.segment_start_time) BETWEEN 20 AND 22 THEN '20-22'
    WHEN HOUR(rs.segment_start_time) BETWEEN 22 AND 00 THEN '22-00'

    ELSE 'poza zakresem'
  END AS hour_range,
  AVG(TIME_TO_SEC(TIMEDIFF(TIME(rs.segment_end_time), TIME(rs.segment_start_time)))) AS avg_duration,
  AVG(o.planned_delivery_duration) AS avg_planned_duration
FROM route_segments rs
LEFT JOIN orders o ON rs.order_id = o.order_id
WHERE HOUR(rs.segment_start_time) BETWEEN 8 AND 21
GROUP BY hour_range, o.sector_id
ORDER BY hour_range ASC;
