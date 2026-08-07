/* ============================================================
   Source table setup — dbo.seriespost
   The base Lahman seriespost table doesn't ship with a
   watermark column or a stable key, so both were added here
   before wiring up the pipeline.
   ============================================================ */

ALTER TABLE seriespost
ADD lastUpdated DATETIME NOT NULL DEFAULT GETDATE();

ALTER TABLE seriespost
ADD pID INT NOT NULL IDENTITY(1,1);
GO

/* ============================================================
   Demo: trigger an incremental load
   Updating a row bumps lastUpdated to the current time, which
   puts it above the stored watermark. Re-running PL_Incremental
   after this should pull ONLY this row through staging and
   into SeriesPost_H, and advance the watermark to its new
   lastUpdated value.

   To verify: check SeriesPost_S / SeriesPost_H row counts
   before and after the run (see 04_pipeline_inline_queries_reference.sql
   for the watermark lookup query), and confirm ctrl_table_watermarks
   .WatermarkValue moved forward to match this row's lastUpdated.
   ============================================================ */

UPDATE dbo.seriespost
SET wins = 8, lastUpdated = GETDATE()
WHERE pId = 1;
