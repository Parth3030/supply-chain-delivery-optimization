SELECT 
    shipping_mode,
    days_shipping_scheduled,
    COUNT(*) AS orders,
    ROUND(AVG(days_shipping_real)::NUMERIC, 2) AS avg_real_days,
    ROUND(AVG(delivery_gap)::NUMERIC, 2) AS avg_gap,
    ROUND(100.0 * SUM(CASE WHEN delivery_performance = 'Late' 
        THEN 1 ELSE 0 END) / COUNT(*), 2) AS late_rate_pct
FROM supply_chain
GROUP BY shipping_mode, days_shipping_scheduled
ORDER BY shipping_mode, days_shipping_scheduled;