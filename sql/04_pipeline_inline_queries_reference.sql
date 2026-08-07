/* ============================================================
   Inline queries used directly inside the pipeline's Lookup
   and Copy activities (not stored procedures — kept here as a
   reference so the SQL logic is visible outside of ADF Studio).
   ============================================================ */

-- Used by Lookup activity "Get watermark value"
SELECT WatermarkValue
FROM ctrl_table_watermarks
WHERE TableName = 'seriespost';

-- Used by Copy activity "Lahman to Stagging" (source query,
-- watermark value substituted in by ADF at runtime)
SELECT *
FROM dbo.seriespost
WHERE lastUpdated > '@{activity(''Get watermark value'').output.firstRow.WatermarkValue}';

-- Used by Lookup activity "Get history watermark"
SELECT MAX(lastUpdated) AS last_updated
FROM dbo.SeriesPost_H;
