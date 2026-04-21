SELECT 
    customer_segment,
    shipping_mode,
    COUNT(*) AS total_orders,
    ROUND(100.0 * SUM(CASE WHEN delivery_performance = 'Late' 
        THEN 1 ELSE 0 END) / COUNT(*), 2) AS late_rate_pct,
    ROUND(AVG(benefit_per_order)::NUMERIC, 2) AS avg_profit,
    ROUND(SUM(benefit_per_order)::NUMERIC, 2) AS total_profit
FROM supply_chain
GROUP BY customer_segment, shipping_mode
ORDER BY customer_segment, late_rate_pct DESC;