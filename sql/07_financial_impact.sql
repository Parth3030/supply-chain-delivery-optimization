WITH mode_comparison AS (
    SELECT
        shipping_mode,
        COUNT(*) AS total_orders,
        SUM(CASE WHEN delivery_performance = 'Late' THEN 1 ELSE 0 END) AS late_orders,
        ROUND(AVG(CASE WHEN delivery_performance = 'Late' 
            THEN benefit_per_order END)::NUMERIC, 2) AS avg_profit_late,
        ROUND(AVG(CASE WHEN delivery_performance != 'Late' 
            THEN benefit_per_order END)::NUMERIC, 2) AS avg_profit_ontime,
        ROUND(SUM(benefit_per_order)::NUMERIC, 2) AS total_profit
    FROM supply_chain
    GROUP BY shipping_mode
)
SELECT
    shipping_mode,
    total_orders,
    late_orders,
    avg_profit_late,
    avg_profit_ontime,
    ROUND((avg_profit_ontime - avg_profit_late) * late_orders, 2) AS profit_recovery_potential
FROM mode_comparison
WHERE avg_profit_ontime IS NOT NULL
ORDER BY profit_recovery_potential DESC;