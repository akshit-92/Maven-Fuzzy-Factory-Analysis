# Maven Fuzzy Factory | E-Commerce Data Analytics

## Project Overview

This project analyzes the business performance of Maven Fuzzy Factory, an e-commerce company specializing in stuffed animal products.

Using SQL and Power BI, the analysis explores website traffic, customer conversion, sales performance, purchasing behavior, and product-level trends to understand the factors influencing business growth and identify opportunities for improvement.

The project combines SQL-based exploratory data analysis and business-focused investigations with an interactive, three-page Power BI dashboard covering:

**• Executive Overview:** Revenue, orders, profitability, and overall business performance trends.

**• Acquisition & Conversion:** Traffic source effectiveness, device-level conversion performance, and customer journey analysis.

**• Product & Sales Analysis:** Product performance, purchasing patterns, product combinations, and revenue contribution.

## Business Objectives

The primary objective of this project is to evaluate Maven Fuzzy Factory's e-commerce performance, identify key drivers of business growth, and uncover potential opportunities for improvement.

The analysis focuses on five key areas:

**1. Overall Business Performance:** Evaluate revenue, order volume, conversion rates, average order value, and profitability trends.

**2. Website Acquisition:** Assess the effectiveness of different traffic sources in attracting visitors and generating sales.

**3. Conversion Funnel:** Analyze customer progression through the purchasing journey and identify potential conversion bottlenecks, particularly across desktop and mobile devices.

**4. Product & Sales Performance:** Examine product-level revenue contributions, purchasing patterns, and the impact of product launches on sales.

**5. Customer Purchasing Behavior:** Investigate single-item versus multi-item purchasing trends and identify frequently purchased product combinations.

## Dataset Description

The project uses the Maven Fuzzy Factory e-commerce dataset, which contains transactional, website activity, product, and refund information for an online stuffed animal retailer.

**Dataset Period:** March 19, 2012 – March 19, 2015

The dataset consists of six interconnected tables:

| Table | Description |
|---|---|
| `website_sessions` | Session-level information, including traffic sources, marketing campaigns, devices, and visitor activity. |
| `website_pageviews` | Individual pageviews recorded during website sessions, enabling customer journey and conversion funnel analysis. |
| `orders` | Order-level transactions, including purchase dates, order values, and items purchased. |
| `order_items` | Product-level details of purchased items, including revenue and cost information. |
| `order_item_refunds` | Refund records associated with individual order items. |
| `products` | Product information, including product names and launch dates. |

## Tools & Technologies

| Tool | Purpose |
| --- | --- |
| `MySQL` | Data exploration, querying relational tables, calculating business metrics, investigating trends, and identifying potential growth opportunities. |
| `Power_BI` | Data modeling, DAX measure creation, and development of an interactive three-page dashboard to visualize business performance and analytical findings. |

## Analytical Approach

The project followed a structured analytical approach, beginning with an exploration of overall business performance and progressing toward more focused investigations into growth drivers, conversion efficiency, and customer purchasing behavior.

**1. Business Performance Analysis**

- Analyzed revenue, gross profit, order volume, average order value (AOV), website sessions, and conversion rates.
- Examined monthly and yearly trends to understand business growth and changes in performance.
- Compared performance across periods to identify significant changes requiring further investigation.

**2. Traffic Acquisition & Conversion Analysis**

- Evaluated traffic sources based on session contribution, conversion rates, revenue share, and revenue generated per session.
- Compared desktop and mobile conversion performance to identify potential opportunities for improvement.
- Analyzed the website conversion funnel to understand where visitors dropped off during the purchasing journey.
- Examined homepage variants and their bounce rates to assess visitor engagement.

**3. Product & Purchasing Behavior Analysis**

- Evaluated product performance based on revenue contribution, presence in two-item orders, and return rates.
- Investigated changes in single-item and two-item purchasing patterns over time.
- Identified frequently purchased product combinations and examined their contribution to two-item orders.

**4. Dashboard Development**

- Built an interactive Power BI dashboard to consolidate the analysis into three business-focused pages.
- Created DAX measures for key performance indicators and analytical metrics.
- Incorporated year-based filtering, performance comparisons, and visualizations to support exploration of business trends.

## Key Findings

**1. Mobile Conversion Underperformance Represented a Growth Opportunity**

Analysis of 2014 website performance revealed a substantial conversion gap **(5.87%)** between desktop and mobile visitors.

A hypothetical scenario assuming mobile visitors converted at the same rate as desktop visitors indicated:

- 4,572 additional orders could have been generated.
- Approximately $291K in additional revenue, calculated using the overall 2014 average order value.
- This represented approximately 27% of actual 2014 revenue.
  
The findings suggest that improving mobile conversion efficiency could represent a growth opportunity. However, additional website behavior and usability data would be required to identify the underlying causes of the conversion gap.

**2. Growth in Two-Item Orders Contributed to Higher Average Order Value**

The proportion of orders containing two items increased from 2.22% in 2013 to 33.93% in 2014, representing a substantial shift in customer purchasing behavior.

A closer examination of monthly trends revealed:

- January 2014: 13.14% of orders contained two items.
- February 2014: This increased sharply to 32.03%.
- Subsequent months: The proportion generally remained between 33% and 37%.
  
This shift coincided with the launch of **Hudson River Mini Bear** in February 2014.

Further analysis of two-item orders revealed that:

- **Original Mr.Fuzzy & Hudson River Mini Bear** accounted for 42.41% of two-item orders.
- **Original Mr.Fuzzy & Birthday Sugar Panda** accounted for 26.64%.
- Together, these combinations represented approximately 69% of two-item orders.
  
The sustained increase in two-item purchasing contributed to higher average order values. Although the timing suggests a possible relationship with **Hudson River Mini Bear's** introduction, the available data does not establish a causal connection.

**3. Socialbook's Conversion Performance Improved Following a Shift in Device Composition**

Socialbook was the lowest-converting major traffic source in 2014, prompting further investigation into its performance.

The analysis revealed two distinct periods:

- January–March 2014: Socialbook recorded a conversion rate of 1.08%, with approximately 90% of sessions originating from mobile devices.
- April–July 2014: No sessions were recorded from Socialbook.
- August–December 2014: The conversion rate increased to 5.15%, with 100% of recorded sessions originating from desktop devices.

Given the substantial conversion gap between desktop and mobile visitors, this shift in device composition provides a plausible explanation for socialbook's improved overall conversion performance in the later half of the year.

## Power BI Dashboard

Developed an interactive, three-page Power BI dashboard to visualize Maven Fuzzy Factory's business performance from March 2012 to March 2015.

The dashboard includes year-based filtering, year-over-year KPI comparisons, and interactive visualizations across three analytical areas.

**1. Executive Overview**

![Executive Overview](images/executive_overview.png)

- Provides a high-level view of overall business performance through six key metrics: Revenue, Gross Profit, Average Order Value, Sessions, Orders, and Conversion Rate.

- Monthly trend visualizations help track changes in financial performance, website traffic, and conversion efficiency.

**2. Acquisition & Conversion**

![Acquisition & Conversion](images/acquisition_conversion.png)

- Evaluates the effectiveness of different traffic sources in generating revenue and converting visitors into customers. It also examines customer progression through the purchasing journey across desktop and mobile devices, helping identify potential conversion bottlenecks.

- Additionally, the page compares homepage variants based on traffic volume and bounce rates to provide insights into visitor engagement.

**3. Product & Sales Analysis**

![Product & Sales Analysis](images/product_sales_analysis.png)

- Examines individual product performance through revenue contribution, return rates, and presence in two-item orders, helping identify differences in how products contribute to overall sales and purchasing behavior.

- The page also explores changes in single-item versus two-item purchasing patterns, frequently purchased product combinations, and monthly product revenue trends to understand how sales composition evolves over time.
