/* ============================================================
   updateWatermark_new
   Called by the pipeline's final activity ("Update Watermmark")
   after the history table's new max(lastUpdated) has been
   looked up. Advances the control table so the next run only
   pulls rows changed after this point.
   ============================================================ */

CREATE PROC updateWatermark_new
(
    @tablename VARCHAR(100),
    @status    VARCHAR(100),
    @datetime  DATETIME
)
AS
BEGIN
    UPDATE ctrl_table_watermarks
    SET LoadStatus     = @status,
        WatermarkValue = @datetime
    WHERE TableName = @tablename;
END;
GO
