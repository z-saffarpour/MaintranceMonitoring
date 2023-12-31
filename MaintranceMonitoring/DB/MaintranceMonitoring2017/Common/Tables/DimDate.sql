﻿CREATE TABLE [Common].[DimDate] (
    [ID]                     INT           NOT NULL,
    [GregorianDate]          DATE          NOT NULL,
    [GregorianYearInt]       SMALLINT      NOT NULL,
    [GregorianMonthNo]       TINYINT       NOT NULL,
    [GregorianDayInMonth]    TINYINT       NOT NULL,
    [GregorianMonthDayInt]   SMALLINT      NOT NULL,
    [GregorianDayOfWeekInt]  TINYINT       NOT NULL,
    [GregorianMonthName]     NVARCHAR (20) NOT NULL,
    [GregorianStr]           CHAR (10)     NOT NULL,
    [GregorianYearMonthInt]  INT           NOT NULL,
    [GregorianYearMonthStr]  CHAR (7)      NOT NULL,
    [GregorianDayOfWeekName] NVARCHAR (20) NOT NULL,
    [GrgorianWeekOfYearName] NVARCHAR (20) NOT NULL,
    [GregorianWeekOfYearNo]  INT           NOT NULL,
    [PersianInt]             INT           NOT NULL,
    [PersianYearInt]         SMALLINT      NOT NULL,
    [PersianMonthNo]         TINYINT       NOT NULL,
    [PersianDayInMonth]      TINYINT       NOT NULL,
    [PersianMonthDayInt]     SMALLINT      NOT NULL,
    [PersianDayOfWeekInt]    TINYINT       NOT NULL,
    [PersianDate]            CHAR (10)     NOT NULL,
    [PersianDateInt]         CHAR (6)      NOT NULL,
    [PersianYearMonthInt]    INT           NOT NULL,
    [PersianYearMonthStr]    CHAR (7)      NOT NULL,
    [PersianWeekOfMonthNo]   INT           NOT NULL,
    [PersianWeekOfYearNo]    INT           NOT NULL,
    [PersianSeasonInt]       INT           NOT NULL,
    [PersianMonthName]       NVARCHAR (20) NOT NULL,
    [PersianDayOfWeekName]   NVARCHAR (20) NOT NULL,
    [PersianWeekOfMonthName] NVARCHAR (20) NOT NULL,
    [PersianWeekOfYearName]  NVARCHAR (20) NOT NULL,
    [PersianFullName]        NVARCHAR (60) NOT NULL,
    [PersianWeekNumberMonth] NVARCHAR (50) NOT NULL,
    [PersianSeason]          NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_common_DimDate] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

