SELECT 
    shipping_mode,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN delivery_performance = 'Late' THEN 1 ELSE 0 END) AS late_orders,
    ROUND(100.0 * SUM(CASE WHEN delivery_performance = 'Late' THEN 1 ELSE 0 END) / COUNT(*), 2) AS late_rate_pct,
    ROUND(AVG(delivery_gap)::NUMERIC, 2) AS avg_delay_days,
    ROUND(AVG(benefit_per_order)::NUMERIC, 2) AS avg_profit_per_order,
    ROUND(SUM(benefit_per_order)::NUMERIC, 2) AS total_profit
FROM supply_chain
GROUP BY shipping_mode
ORDER BY late_rate_pct DESC;