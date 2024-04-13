-- Format the data
SELECT 
  item_id,
  test_a AS test_assignment,
  CASE
    WHEN test_a IS NOT NULL THEN 'item_test_1'
  END AS test_number,
  CASE 
    WHEN test_a IS NOT NULL THEN TO_TIMESTAMP('2013-01-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
  END AS test_start_date
FROM 
  dsv1069.final_assignments_qa
UNION 
SELECT 
  item_id,
  test_b AS test_assignment,
  CASE
    WHEN test_b IS NOT NULL THEN 'item_test_2'
  END AS test_number,
  CASE 
    WHEN test_b IS NOT NULL THEN TO_TIMESTAMP('2015-03-14 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
  END AS test_start_date
FROM 
  dsv1069.final_assignments_qa
UNION
SELECT 
  item_id,
  test_c AS test_assignment,
  CASE
    WHEN test_c IS NOT NULL THEN 'item_test_3'
  END AS test_number,
  CASE 
    WHEN test_c IS NOT NULL THEN TO_TIMESTAMP('2016-01-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
  END AS test_start_date
FROM 
  dsv1069.final_assignments_qa
ORDER BY 
  test_number
