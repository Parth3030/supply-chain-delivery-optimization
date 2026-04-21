SELECT 
    department_name,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN delivery_performance = 'Late' THEN 1 ELSE 0 END) AS late_orders,
    ROUND(100.0 * SUM(CASE WHEN delivery_performance = 'Late' THEN 1 ELSE 0 END) / COUNT(*), 2) AS late_rate_pct,
    ROUND(SUM(benefit_per_order)::NUMERIC, 2) AS total_profit,
    ROUND(AVG(benefit_per_order)::NUMERIC, 2) AS avg_profit
FROM supply_chain
GROUP BY department_name
ORDER BY late_orders DESC;