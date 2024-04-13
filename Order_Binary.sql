-- Compute order binary
SELECT 
  test_assignment,
  SUM(order_binary_30d) AS order_count_within_30d,
  COUNT(item_id) AS item_count
FROM
(
 SELECT 
   a.item_id AS item_id, 
   test_assignment,
   MAX(CASE WHEN created_at > test_start_date THEN 1 ELSE 0 END) AS order_binary_30d
 FROM 
   dsv1069.final_assignments a
 LEFT JOIN 
   dsv1069.orders b
 ON 
   b.item_id = a.item_id
 AND  
   created_at >= test_start_date
 AND 
   DATE_PART('day', created_at - test_start_date) <= 30
 WHERE 
   test_number = 'item_test_2'
 GROUP BY 
   a.item_id,
   test_assignment
) test_events
GROUP BY  
  test_assignment
