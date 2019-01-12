SELECT *
FROM survey
LIMIT 10;	

SELECT question, COUNT(user_id)
FROM survey
GROUP BY question;

SELECT *
FROM quiz
LIMIT 5;

SELECT *
FROM home_try_on
LIMIT 5;

SELECT *
FROM purchase
LIMIT 5;

SELECT *
FROM quiz 
LEFT JOIN home_try_on 
  ON home_try_on.user_id = quiz.user_id
LEFT JOIN purchase 
  ON purchase.user_id = home_try_on.user_id
LIMIT 10;

SELECT DISTINCT quiz.user_id,
	home_try_on.number_of_pairs,
	home_try_on.user_id IS NOT NULL AS 'is_home_try_on',
 	purchase.user_id IS NOT NULL AS 'is_purchase'
FROM quiz 
LEFT JOIN home_try_on 
  	ON home_try_on.user_id = quiz.user_id
LEFT JOIN purchase 
 	ON purchase.user_id = home_try_on.user_id
LIMIT 10;

WITH funnels AS (
	SELECT DISTINCT quiz.user_id,
		home_try_on.number_of_pairs,
		home_try_on.user_id IS NOT NULL AS 'is_home_try_on',
		purchase.user_id IS NOT NULL AS 'is_purchase'
	FROM quiz 
	LEFT JOIN home_try_on 
  		ON home_try_on.user_id = quiz.user_id
	LEFT JOIN purchase 
 		 ON purchase.user_id = home_try_on.user_id)
	SELECT COUNT(*) AS 'num_quiz_responses',
   		SUM(is_home_try_on) AS 'num_try_on',
   		SUM(is_purchase) AS 'num_purchase',
		1.0 * SUM(is_home_try_on) / COUNT(user_id) as 'quiz to home',
		1.0 * SUM(is_purchase) / SUM(is_home_try_on) as 'home to purchase'
	FROM funnels;

WITH funnels AS (
	SELECT DISTINCT quiz.user_id,
		home_try_on.number_of_pairs,
		home_try_on.user_id IS NOT NULL AS 'is_home_try_on',
		purchase.user_id IS NOT NULL AS 'is_purchase'
	FROM quiz 
	LEFT JOIN home_try_on 
  		ON home_try_on.user_id = quiz.user_id
	LEFT JOIN purchase 
  		ON purchase.user_id = home_try_on.user_id)
	SELECT COUNT(*) AS 'num_quiz_responses',
   		SUM(is_home_try_on) AS 'num_try_on',
   		SUM(is_purchase) AS 'num_purchase',
		1.0 * SUM(is_home_try_on) / COUNT(user_id) as 'quiz to home',
		1.0 * SUM(is_purchase) / SUM(is_home_try_on) as 'home to purchase'
	FROM funnels
	GROUP BY number_of_pairs
	ORDER BY number_of_pairs;

SELECT ROUND(AVG(price), 2) as 'Average Price'
FROM purchase;

SELECT price, COUNT(*) AS 'result'
FROM purchase
GROUP BY price;


SELECT color, COUNT(*) AS 'result'
FROM purchase
GROUP BY 1
ORDER BY 2 DESC;


SELECT style, COUNT(*) AS 'result'
FROM purchase
GROUP BY 1
ORDER BY 2 DESC;

SELECT fit, COUNT(*) AS 'result'
FROM quiz
GROUP BY 1
ORDER BY 2 DESC;

SELECT fit, COUNT(*) AS 'result'
FROM quiz
WHERE style like 'w%'
GROUP BY 1
ORDER BY 2 DESC;

SELECT shape, COUNT(*) AS 'result'
FROM quiz
WHERE style like 'm%'
GROUP BY 1
ORDER BY 2 DESC;

SELECT color, COUNT(*) AS 'result'
FROM quiz
WHERE style like 'w%'
GROUP BY 1
ORDER BY 2 DESC;


SELECT purchase.model_name,
	purchase.style,
	purchase.color,
	home_try_on.number_of_pairs
FROM purchase
JOIN home_try_on
 	 ON purchase.user_id = home_try_on.user_id
WHERE number_of_pairs = '5 pairs' and style like 'w%';

SELECT purchase.model_name,
	purchase.style,
	purchase.color,
	home_try_on.number_of_pairs
FROM purchase
JOIN home_try_on
 	 ON purchase.user_id = home_try_on.user_id
WHERE number_of_pairs = '5 pairs' and style like 'w%';

SELECT purchase.model_name,
	purchase.style,
	purchase.color,
	home_try_on.number_of_pairs
FROM purchase
JOIN home_try_on
 	 ON purchase.user_id = home_try_on.user_id
WHERE number_of_pairs = '3 pairs' and style like 'w%';

SELECT purchase.model_name,
	purchase.style,
	purchase.color,
	home_try_on.number_of_pairs
FROM purchase
JOIN home_try_on
 	 ON purchase.user_id = home_try_on.user_id
WHERE number_of_pairs = '3 pairs' and style like 'w%';

SELECT model_name, 
        product_id, COUNT(*) AS 'result'
FROM purchase
GROUP BY product_id;
