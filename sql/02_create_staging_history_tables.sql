/* ============================================================
   SeriesPost_S  (Staging)
   Truncated and reloaded on every pipeline run with just the
   delta rows from dbo.seriespost (Copy activity: "Lahman to
   Stagging"). insertedOn is stamped by the pipeline via an
   additional column expression (@utcNow()).
   ============================================================ */

CREATE TABLE SeriesPost_S
(
    yearID         INT,
    round          VARCHAR(25),
    teamIDwinner   VARCHAR(25),
    IgIDwinner     VARCHAR(25),
    teamIDloser    VARCHAR(25),
    wins           INT,
    losses         INT,
    ties           INT,
    lastUpdated    DATETIME,
    pId            INT,
    insertedOn     DATETIME
);
GO

/* ============================================================
   SeriesPost_H  (History)
   Permanent target table. The pipeline's "Staging to History"
   Copy activity upserts staging rows into this table, keyed on
   pId, so re-runs are idempotent.
   ============================================================ */

CREATE TABLE SeriesPost_H
(
    yearID         INT,
    round          VARCHAR(25),
    teamIDwinner   VARCHAR(25),
    IgIDwinner     VARCHAR(25),
    teamIDloser    VARCHAR(25),
    wins           INT,
    losses         INT,
    ties           INT,
    lastUpdated    DATETIME,
    pId            INT,
    insertedOn     DATETIME
);
GO

/* Optional but recommended: the pipeline's upsert uses pId as
   the match key. A primary key / unique constraint lets ADF's
   upsert run efficiently and prevents accidental duplicates if
   the constraint is ever violated outside the pipeline.
   ALTER TABLE SeriesPost_H ADD CONSTRAINT PK_SeriesPost_H PRIMARY KEY (pId); */
