SELECT 
    shipping_mode,
    delivery_gap,
    COUNT(*) AS orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(PARTITION BY shipping_mode), 2) AS pct_within_mode
FROM supply_chain
WHERE delivery_performance = 'Late'
GROUP BY shipping_mode, delivery_gap
ORDER BY shipping_mode, delivery_gap;