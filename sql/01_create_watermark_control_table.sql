/* ============================================================
   ctrl_table_watermarks
   Control table that tracks the incremental load state for
   each source table. The pipeline reads WatermarkValue at the
   start of a run and updates it (via updateWatermark_new) once
   the load succeeds.
   ============================================================ */

CREATE TABLE ctrl_table_watermarks
(
    ID              INT IDENTITY(1,1) PRIMARY KEY,
    SchemaName      VARCHAR(100),
    TableName       VARCHAR(100),
    WatermarkColumn VARCHAR(100),
    WatermarkValue  DATETIME,
    KeyColumn       VARCHAR(100),
    IsActive        VARCHAR(100),
    SourceSystem    VARCHAR(100),
    Loadtype        VARCHAR(100),
    LoadStatus      VARCHAR(100)
);
GO

/* Seed row for the seriespost table.
   Watermark starts at 1900-01-01 so the first pipeline run
   picks up the full history table as an initial load. */
INSERT INTO ctrl_table_watermarks
    (SchemaName, TableName, WatermarkColumn, WatermarkValue, KeyColumn,
     IsActive, SourceSystem, Loadtype, LoadStatus)
VALUES
    ('dbo', 'seriespost', 'lastupdated', '1900-01-01', 'pId',
     1, 'Lahman', 'INCR', '');
GO
