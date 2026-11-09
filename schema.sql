-- SQL Server schema exported from Access
-- Review before executing.

CREATE TABLE [dbo].[DACatchDetails_WDFW] (
    [ID] INT IDENTITY(1,1) NULL,
    [DACount_ID] INT NULL,
    [Undersized] INT NULL
);
GO

CREATE TABLE [dbo].[DACount_WDFW] (
    [DACount_ID] INT IDENTITY(1,1) NULL,
    [DAReport_ID] INT NULL,
    [Species_ID] INT NULL,
    [Count] INT NULL
);
GO

CREATE TABLE [dbo].[DALocation] (
    [DALocation_ID] INT IDENTITY(1,1) NULL,
    [AnglingLocation] NVARCHAR(255) NULL
);
GO

CREATE TABLE [dbo].[DAReport_WDFW] (
    [DAReport_ID] INT IDENTITY(1,1) NULL,
    [WeekEnding] DATETIME2 NULL,
    [DALocation_ID] INT NULL,
    [EffortHours] INT NULL
);
GO

CREATE TABLE [dbo].[odfw_monitoring_incidental_catch] (
    [id] INT IDENTITY(1,1) NULL,
    [monitoring_survey_id] INT NULL,
    [species_id] INT NULL,
    [count] INT NULL
);
GO

CREATE TABLE [dbo].[odfw_monitoring_survey] (
    [id] INT IDENTITY(1,1) NULL,
    [reservoir_id] INT NULL,
    [survey_date] DATETIME2 NULL,
    [survey_start_time] DATETIME2 NULL,
    [survey_end_time] DATETIME2 NULL,
    [survey_effort] INT NULL
);
GO

CREATE TABLE [dbo].[odfw_monitoring_target_catch] (
    [id] INT IDENTITY(1,1) NULL,
    [monitoring_survey_id] INT NULL,
    [species_id] INT NULL,
    [fork_length] INT NULL,
    [weight] INT NULL,
    [external_tag_code] NVARCHAR(255) NULL,
    [pit_tag_code] NVARCHAR(255) NULL,
    [external_tag_type_id] INT NULL,
    [tag_color_id] NVARCHAR(255) NULL
);
GO

CREATE TABLE [dbo].[reach] (
    [id] INT IDENTITY(1,1) NULL,
    [reach] NVARCHAR(255) NULL,
    [common_name] NVARCHAR(255) NULL
);
GO

CREATE TABLE [dbo].[reservoir] (
    [id] INT IDENTITY(1,1) NULL,
    [reservoir_code] NVARCHAR(255) NULL,
    [common_name] NVARCHAR(255) NULL,
    [reach_id] INT NULL
);
GO

CREATE TABLE [dbo].[sex] (
    [id] INT IDENTITY(1,1) NULL,
    [sex] NVARCHAR(255) NULL
);
GO

CREATE TABLE [dbo].[species] (
    [id] INT IDENTITY(1,1) NULL,
    [common_name] NVARCHAR(255) NULL,
    [scientific_name] NVARCHAR(255) NULL
);
GO

CREATE TABLE [dbo].[state] (
    [id] INT IDENTITY(1,1) NULL,
    [state] NVARCHAR(255) NULL
);
GO

CREATE TABLE [dbo].[station] (
    [id] INT IDENTITY(1,1) NULL,
    [station_name] NVARCHAR(255) NULL,
    [reservoir_id] INT NULL,
    [city] NVARCHAR(255) NULL,
    [state_id] INT NULL
);
GO

CREATE TABLE [dbo].[tag_color] (
    [id] NVARCHAR(255) NOT NULL,
    [tag_color] NVARCHAR(255) NULL
);
GO

CREATE TABLE [dbo].[tag_type] (
    [id] INT IDENTITY(1,1) NULL,
    [tag_type] NVARCHAR(255) NULL
);
GO

CREATE TABLE [dbo].[wdfw_srf_biological] (
    [id] INT IDENTITY(1,1) NULL,
    [species_id] INT NULL,
    [fork_length] INT NULL,
    [pit_tag_code] NVARCHAR(255) NULL,
    [external_tag_type] INT NULL,
    [tag_color] NVARCHAR(255) NULL,
    [sex_id] INT NULL,
    [trip_id] INT NULL
);
GO

CREATE TABLE [dbo].[wdfw_srf_catch] (
    [id] INT IDENTITY(1,1) NULL,
    [species_id] INT NULL,
    [caught_count] INT NULL,
    [released_count] INT NULL,
    [trip_id] INT NULL
);
GO

CREATE TABLE [dbo].[wdfw_srf_daily_registration] (
    [id] INT IDENTITY(1,1) NULL,
    [registration_date] DATETIME2 NULL,
    [station_id] INT NULL
);
GO

CREATE TABLE [dbo].[wdfw_srf_trip] (
    [id] INT IDENTITY(1,1) NULL,
    [daily_registration_id] INT NULL
);
GO

ALTER TABLE [dbo].[DACatchDetails_WDFW]
ADD CONSTRAINT [PK_DACatchDetails_WDFW]
PRIMARY KEY ([ID]);
GO

ALTER TABLE [dbo].[DACount_WDFW]
ADD CONSTRAINT [PK_DACount_WDFW]
PRIMARY KEY ([DACount_ID]);
GO

ALTER TABLE [dbo].[DALocation]
ADD CONSTRAINT [PK_DALocation]
PRIMARY KEY ([DALocation_ID]);
GO

ALTER TABLE [dbo].[DAReport_WDFW]
ADD CONSTRAINT [PK_DAReport_WDFW]
PRIMARY KEY ([DAReport_ID]);
GO

ALTER TABLE [dbo].[odfw_monitoring_incidental_catch]
ADD CONSTRAINT [PK_odfw_monitoring_incidental_catch]
PRIMARY KEY ([id]);
GO

ALTER TABLE [dbo].[odfw_monitoring_survey]
ADD CONSTRAINT [PK_odfw_monitoring_survey]
PRIMARY KEY ([id]);
GO

ALTER TABLE [dbo].[odfw_monitoring_target_catch]
ADD CONSTRAINT [PK_odfw_monitoring_target_catch]
PRIMARY KEY ([id]);
GO

ALTER TABLE [dbo].[reach]
ADD CONSTRAINT [PK_reach]
PRIMARY KEY ([id]);
GO

ALTER TABLE [dbo].[reservoir]
ADD CONSTRAINT [PK_reservoir]
PRIMARY KEY ([id]);
GO

ALTER TABLE [dbo].[sex]
ADD CONSTRAINT [PK_sex]
PRIMARY KEY ([id]);
GO

ALTER TABLE [dbo].[species]
ADD CONSTRAINT [PK_species]
PRIMARY KEY ([id]);
GO

ALTER TABLE [dbo].[state]
ADD CONSTRAINT [PK_state]
PRIMARY KEY ([id]);
GO

ALTER TABLE [dbo].[station]
ADD CONSTRAINT [PK_station]
PRIMARY KEY ([id]);
GO

ALTER TABLE [dbo].[tag_color]
ADD CONSTRAINT [PK_tag_color]
PRIMARY KEY ([id]);
GO

ALTER TABLE [dbo].[tag_type]
ADD CONSTRAINT [PK_tag_type]
PRIMARY KEY ([id]);
GO

ALTER TABLE [dbo].[wdfw_srf_biological]
ADD CONSTRAINT [PK_wdfw_srf_biological]
PRIMARY KEY ([id]);
GO

ALTER TABLE [dbo].[wdfw_srf_catch]
ADD CONSTRAINT [PK_wdfw_srf_catch]
PRIMARY KEY ([id]);
GO

ALTER TABLE [dbo].[wdfw_srf_daily_registration]
ADD CONSTRAINT [PK_wdfw_srf_daily_registration]
PRIMARY KEY ([id]);
GO

ALTER TABLE [dbo].[wdfw_srf_trip]
ADD CONSTRAINT [PK_wdfw_srf_trip]
PRIMARY KEY ([id]);
GO

ALTER TABLE [dbo].[MSysNavPaneGroups]
ADD CONSTRAINT [MSysNavPaneGroupCategoriesMSysNavPaneGroups]
FOREIGN KEY ([GroupCategoryID])
REFERENCES [dbo].[MSysNavPaneGroupCategories] ([Id])
ON DELETE CASCADE ON UPDATE CASCADE;
GO

ALTER TABLE [dbo].[MSysNavPaneGroupToObjects]
ADD CONSTRAINT [MSysNavPaneGroupsMSysNavPaneGroupToObjects]
FOREIGN KEY ([GroupID])
REFERENCES [dbo].[MSysNavPaneGroups] ([Id])
ON DELETE CASCADE ON UPDATE CASCADE;
GO

