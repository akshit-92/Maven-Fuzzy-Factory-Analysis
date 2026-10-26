
-- ===============================================================
-- Maven Fuzzy Factory | E-Commerce Data Analysis
-- ===============================================================

-- Tool: MySQL

-- Overview :
-- This file contains SQL queries used to investigate website
-- traffic, conversion performance, customer purchasing behavior,
-- and product combinations across different business periods.

-- Each query includes its objective, analysis, and references
-- to the relevant findings in the README or Power BI dashboard.
-- ===============================================================

-- _________________________________________________________________________________________________________________________________  

-- 1. Traffic Source Performance
-- Objective : Evaluate how effectively different traffic sources convert visitors into customers and generate revenue.
-- Analysis : Compared orders, conversion rates, and revenue per session across traffic sources.
-- Reference : Power BI → Acquisition & Conversion → Traffic Source Performance; 
--             README → Key Findings → Socialbook's Conversion Performance Improved Following a Shift in Device Composition.

SELECT YEAR(w.created_at) AS year, w.utm_source, 
COUNT(o.order_id) AS orders, 
CONCAT(ROUND(AVG(CASE WHEN o.order_id IS NULL THEN 0 ELSE 1 END)*100,2),"%") AS conversion_rate,
ROUND(AVG(CASE WHEN o.price_usd IS NOT NULL THEN o.price_usd ELSE 0 END),2) AS revenue_per_session
FROM website_sessions w
LEFT JOIN orders o
ON w.website_session_id=o.website_session_id
WHERE YEAR(w.created_at) IN (2013,2014)
GROUP BY YEAR(w.created_at), w.utm_source
ORDER BY year, utm_source;

-- _________________________________________________________________________________________________________________________________

-- 2. Socialbook Conversion Performance & Device Mix
-- Objective : Investigate Socialbook's low conversion rate and its improvement during the latter half of 2014.
-- Analysis : Examined monthly sessions, orders, conversion rates, and revenue per session by device type to understand 
--            changes in traffic composition and conversion performance.
-- Reference : README → Key Findings → Socialbook's Conversion Performance Improved Following a Shift in Device Composition.

SELECT YEAR(w.created_at) AS year, MONTH(w.created_at) AS month, w.utm_source, w.device_type,
COUNT(w.website_session_id) AS sessions,
COUNT(o.order_id) AS orders, 
CONCAT(ROUND(AVG(CASE WHEN o.order_id IS NULL THEN 0 ELSE 1 END)*100,2), "%") AS conversion_rate,
ROUND(AVG(CASE WHEN o.price_usd IS NOT NULL THEN o.price_usd ELSE 0 END),2) AS revenue_per_session
FROM website_sessions w
LEFT JOIN orders o
ON w.website_session_id=o.website_session_id
WHERE YEAR(w.created_at)=2014 AND w.utm_source='socialbook'
GROUP BY YEAR(w.created_at), MONTH(w.created_at), w.utm_source, w.device_type
ORDER BY year, month;

-- _________________________________________________________________________________________________________________________________

-- 3. Website Conversion Funnel Analysis by Device
-- Objective : Compare desktop and mobile purchasing journeys to identify stages with significant drop-offs and potential 
--             conversion bottlenecks.
-- Analysis : Calculated the percentage of sessions reaching each funnel stage relative to the previous stage and the initial
--            stage, separately for desktop and mobile devices.
-- Reference : Power BI → Acquisition & Conversion → Desktop and Mobile Conversion Rate Breakdown; 
--             README → Key Findings → Mobile Conversion Underperformance Represented a Growth Opportunity.

-- Dataset Observations : Pages visited in any session follow a fixed sequence (any homepage variant → products → 
--                        product detail → cart → shipping → payment → order confirmation). The session can end at any stage, 
--                        but begins only on any homepage variant and progresses in the given sequence. Additionally, any given 
--                        page is visited only once during a session.

WITH tab AS (
   SELECT s.device_type, 
   CASE WHEN pageview_url LIKE '/land%' THEN '/home'
        WHEN pageview_url LIKE '/bill%' THEN '/billing' 
        WHEN pageview_url LIKE '/the-%' THEN '/product_detail'
        ELSE pageview_url END AS page,
   COUNT(*) AS sessions
   FROM website_sessions s
   JOIN website_pageviews p
   ON s.website_session_id=p.website_session_id AND YEAR(p.created_at)=2014
   GROUP BY s.device_type, 
   CASE WHEN pageview_url LIKE '/land%' THEN '/home'
        WHEN pageview_url LIKE '/bill%' THEN '/billing' 
        WHEN pageview_url LIKE '/the-%' THEN '/product_detail'
	    ELSE pageview_url END
)
SELECT *,
CONCAT(COALESCE(ROUND(sessions/LAG(sessions) OVER (PARTITION BY device_type ORDER BY sequence)*100,2),100),'%') AS each_stage_cr,
CONCAT(ROUND(sessions/FIRST_VALUE(sessions) OVER (PARTITION BY device_type ORDER BY sequence)*100,2),'%') AS overall_cr
FROM (
   SELECT *, 
   CASE WHEN page='/home' THEN 1
        WHEN page='/products' THEN 2
        WHEN page='/product_detail' THEN 3
        WHEN page='/cart' THEN 4
        WHEN page='/shipping' THEN 5
        WHEN page='/billing' THEN 6
        ELSE 7 END AS sequence
   FROM tab
)t
ORDER BY device_type, sequence;

-- _________________________________________________________________________________________________________________________________

-- 4. Homepage Variant Performance & Bounce Rate
-- Objective : Evaluate visitor engagement across homepage variants and compare bounce rates between desktop and mobile devices.
-- Analysis : Calculated total sessions and bounce rates for homepage variants, grouped by year and device type, to identify 
--            differences in visitor engagement.
-- Reference : Power BI → Acquisition & Conversion → Total Sessions and Bounce Rate by Homepage Variants.

WITH tab AS (
   SELECT *,
   CASE WHEN LEAD(pageview_url) OVER (PARTITION BY website_session_id ORDER BY website_pageview_id) 
   IS NULL THEN 1 ELSE 0 END AS bounce
   FROM (
      SELECT YEAR(s.created_at) AS year, p.website_session_id, p.website_pageview_id, s.device_type, p.pageview_url
      FROM website_sessions s
      JOIN website_pageviews p
      ON s.website_session_id=p.website_session_id
      WHERE (p.pageview_url IN ('/home', '/products') OR p.pageview_url LIKE '%/land%') 
      AND (YEAR(s.created_at) IN (2013, 2014))
   )t
)
SELECT year, device_type, pageview_url AS homepage_variant, 
COUNT(*) AS sessions,
CONCAT(ROUND(AVG(bounce)*100,2),'%') AS bounce_rate
FROM tab
WHERE pageview_url!='/products'
GROUP BY year, device_type, pageview_url
ORDER BY year, device_type, pageview_url;

-- _________________________________________________________________________________________________________________________________

-- 5. Monthly Order Mix : Single vs Two Items
-- Objective : Examine changes in customer purchasing behavior by comparing the proportion of single-item and two-item orders 
--             over time.
-- Analysis : Calculated the monthly percentage of orders containing one or two items to identify shifts in purchasing patterns.
-- Reference : Power BI → Product & Sales Analysis → Monthly Order Mix : Single vs Two Items; 
--             README → Key Findings → Growth in Two-Item Orders.

SELECT YEAR(created_at) AS year, MONTH(created_at) AS month, 
CONCAT(ROUND(AVG(CASE WHEN items_purchased=1 THEN 1 ELSE 0 END)*100,2), '%') AS one_item_orders,
CONCAT(ROUND(AVG(CASE WHEN items_purchased=2 THEN 1 ELSE 0 END)*100,2), '%') AS two_item_orders
FROM orders
WHERE YEAR(created_at) IN (2013, 2014)
GROUP BY YEAR(created_at), MONTH(created_at)
ORDER BY year, month;

-- _________________________________________________________________________________________________________________________________

-- 6. Best-Selling Product Combinations
-- Objective : Identify the most frequently purchased product combinations and their contribution to two-item orders.
-- Analysis : Identified product pairs from orders containing exactly two items, calculated the number of orders and percentage
--            share of total two-item orders for each combination.
-- Reference : Power BI → Product & Sales Analysis → Best-Selling Product Combinations; 
--             README → Key Findings → Growth in Two-Item Orders.

SELECT *, CONCAT(ROUND(total_orders/SUM(total_orders) OVER ()*100,2), '%') AS share_of_two_item_orders
FROM (
   SELECT product_combinations, COUNT(*) AS total_orders
   FROM (
      SELECT *, CONCAT(product_id, ', ' ,LEAD(product_id) OVER (PARTITION BY order_id ORDER BY product_id)) AS product_combinations
      FROM (
         SELECT *
         FROM order_items
         WHERE order_id IN (
            SELECT order_id
            FROM orders
            WHERE items_purchased=2
            AND YEAR(created_at)=2014
		 )
      )t
   )t
   WHERE product_combinations IS NOT NULL
   GROUP BY product_combinations
)t
ORDER BY product_combinations;

-- _________________________________________________________________________________________________________________________________
