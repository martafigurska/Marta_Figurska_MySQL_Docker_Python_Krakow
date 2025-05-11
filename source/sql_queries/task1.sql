select p.product_id as productId, 
p.weight as totalWeight,
op.quantity
from products p 
join orders_products op on p.product_id = op.product_id
join route_segments rs on rs.order_id = op.order_id
join orders o on rs.order_id = o.order_id
where (o.customer_id = 32 AND rs.segment_end_time LIKE '2024-02-13%')
order by totalWeight asc

