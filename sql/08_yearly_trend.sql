SELECT 
    order_year,
    shipping_mode,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN delivery_performance = 'Late' THEN 1 ELSE 0 END) AS late_orders,
    ROUND(100.0 * SUM(CASE WHEN delivery_performance = 'Late' 
        THEN 1 ELSE 0 END) / COUNT(*), 2) AS late_rate_pct,
    ROUND(SUM(benefit_per_order)::NUMERIC, 2) AS total_profit
FROM supply_chain
WHERE order_year IS NOT NULL
GROUP BY order_year, shipping_mode
ORDER BY order_year, shipping_mode;