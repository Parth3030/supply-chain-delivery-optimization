SELECT 
    delivery_performance,
    COUNT(*) AS order_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS pct_total,
    ROUND(AVG(benefit_per_order)::NUMERIC, 2) AS avg_profit,
    ROUND(SUM(benefit_per_order)::NUMERIC, 2) AS total_profit
FROM supply_chain
GROUP BY delivery_performance
ORDER BY order_count DESC;