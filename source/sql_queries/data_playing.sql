select 
-- o.order_id,
-- rs.driver_id,
o.sector_id,
-- rs.segment_start_time,
-- rs.segment_end_time,
-- rs.segment_type,
TIME_TO_SEC(TIMEDIFF(TIME(rs.segment_end_time), TIME(rs.segment_start_time))) as real_delivery_duration,
o.planned_delivery_duration
from route_segments rs
left join orders o on rs.order_id = o.order_id
-- where rs.segment_type = 'STOP' AND rs.driver_id = 1 
order by segment_start_time asc;


-- GROUP BY segment_id
-- order by order_id asc;

-- where segment_type = 'DRIVE';
-- where segment_end_time<segment_start_time and segment_type = 'DRIVE';

-- select segment type from route_segments
-- where segment_end_time Like '%0%';

-- select o.order_id, o.planned_delivery_duration from orders o
-- order by order_id asc;



-- select avg(TIME_TO_SEC(TIMEDIFF(TIME(segment_end_time), TIME(segment_start_time)))) as AVG
-- from route_segments

-- select planned_delivery_duration
-- from orders