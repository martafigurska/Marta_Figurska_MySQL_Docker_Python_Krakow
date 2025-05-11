select 
rs.driver_id,
o.sector_id,
TIME_TO_SEC(TIMEDIFF(TIME(rs.segment_end_time), TIME(rs.segment_start_time))) as real_delivery_duration,
o.planned_delivery_duration
from route_segments rs
left join orders o on rs.order_id = o.order_id
order by segment_start_time asc;