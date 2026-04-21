SELECT
    shipping_mode,
    delivery_performance,
    COUNT(*) AS orders,
    ROUND(AVG(benefit_per_order)::NUMERIC, 2) AS avg_profit,
    ROUND(SUM(benefit_per_order)::NUMERIC, 2) AS total_profit,
    ROUND(
        (AVG(benefit_per_order) - 
         MAX(CASE WHEN delivery_performance = 'On Time' 
             THEN avg_ontime END))::NUMERIC
    , 2) AS profit_gap_vs_ontime
FROM supply_chain
CROSS JOIN (
    SELECT AVG(benefit_per_order) AS avg_ontime 
    FROM supply_chain 
    WHERE delivery_performance = 'On Time'
) ontime_avg
GROUP BY shipping_mode, delivery_performance
ORDER BY shipping_mode, delivery_performance;