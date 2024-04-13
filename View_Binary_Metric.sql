-- Compute view item metric
SELECT 
  test_assignment,
  SUM(view_binary_within_30d) AS view_count_within_30d,
  COUNT(item_id) AS item_count,
  SUM(views) AS views,
  CAST(SUM(view_binary_within_30d)*100/COUNT(item_id) AS FLOAT) AS percent_view,
  SUM(views)/COUNT(item_id) AS average_view_per_item
FROM 
(
 SELECT 
   a.item_id AS item_id, 
   test_assignment,
   MAX(CASE WHEN event_time > test_start_date THEN 1 ELSE 0 END) AS view_binary_within_30d,
   COUNT(event_id) AS views
 FROM 
   dsv1069.final_assignments a
 LEFT JOIN 
 (
   SELECT 
     event_id, 
     event_time, 
     CAST(parameter_value AS INT) AS item_id
   FROM 
     dsv1069.events 
   WHERE 
     event_name = 'view_item'
   AND 
     parameter_name = 'item_id'
 ) views
 ON 
   a.item_id = views.item_id
 AND 
   event_time >= test_start_date
 AND 
   DATE_PART('day', event_time - test_start_date) <= 30
 WHERE 
   test_number = 'item_test_2'
 GROUP BY 
   a.item_id,
   test_assignment
) view_binary
GROUP BY  
  test_assignment
