/*
Run only against a disposable development database deployed from the DACPAC.
All fixture data is rolled back at the end of the script.
*/
SET NOCOUNT ON;
SET XACT_ABORT OFF;

BEGIN TRANSACTION;

BEGIN TRY
    DECLARE @SpeciesId INT;
    DECLARE @ReachId INT;
    DECLARE @ReservoirId INT;
    DECLARE @SurveyId INT;
    DECLARE @StateId INT;
    DECLARE @StationId INT;
    DECLARE @FishedLocationId INT;
    DECLARE @DailyRegistrationId INT;
    DECLARE @TripId INT;

    INSERT INTO [dbo].[Species] ([CommonName], [ScientificName])
    VALUES (N'Constraint Test Species', N'Testus constraintus');
    SET @SpeciesId = CONVERT(INT, SCOPE_IDENTITY());

    INSERT INTO [dbo].[Reach] ([ReachCode], [CommonName])
    VALUES (N'TEST', N'Constraint Test Reach');
    SET @ReachId = CONVERT(INT, SCOPE_IDENTITY());

    INSERT INTO [dbo].[Reservoir] ([ReservoirCode], [ReservoirName], [ReachId])
    VALUES (N'TEST-RES', N'Constraint Test Reservoir', @ReachId);
    SET @ReservoirId = CONVERT(INT, SCOPE_IDENTITY());

    INSERT INTO [dbo].[OdfwMonitoringSurvey]
        ([ReservoirId], [SurveyDate], [SurveyStartTime], [SurveyEndTime], [SurveyEffort])
    VALUES (@ReservoirId, '2026-01-01', '08:00', '09:00', 1);
    SET @SurveyId = CONVERT(INT, SCOPE_IDENTITY());

    INSERT INTO [dbo].[State] ([StateCode], [StateName])
    VALUES ('TS', N'Constraint Test State');
    SET @StateId = CONVERT(INT, SCOPE_IDENTITY());

    INSERT INTO [dbo].[Station] ([StationName], [ReservoirId], [StateId], [Latitude], [Longitude])
    VALUES (N'Constraint Test Station', @ReservoirId, @StateId, 45.000000, -122.000000);
    SET @StationId = CONVERT(INT, SCOPE_IDENTITY());

    INSERT INTO [dbo].[FishedLocation] ([Code], [Description])
    VALUES (N'TEST-LOC', N'Constraint Test Fished Location');
    SET @FishedLocationId = CONVERT(INT, SCOPE_IDENTITY());

    /* Foreign-key enforcement. */
    BEGIN TRY
        INSERT INTO [dbo].[OdfwMonitoringIncidentalCatch]
            ([OdfwMonitoringSurveyId], [SpeciesId], [CatchCount])
        VALUES (@SurveyId, -1, 1);
        THROW 51000, 'Expected foreign-key violation was not raised.', 1;
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() <> 547 THROW;
    END CATCH;

    /* CHECK-constraint enforcement. */
    BEGIN TRY
        INSERT INTO [dbo].[OdfwMonitoringTargetCatch]
            ([OdfwMonitoringSurveyId], [SpeciesId], [ForkLengthMillimeters])
        VALUES (@SurveyId, @SpeciesId, 0);
        THROW 51001, 'Expected fork-length CHECK violation was not raised.', 1;
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() <> 547 THROW;
    END CATCH;

    BEGIN TRY
        INSERT INTO [dbo].[OdfwMonitoringSurvey]
            ([ReservoirId], [SurveyDate], [SurveyStartTime], [SurveyEndTime])
        VALUES (@ReservoirId, '2026-01-02', '09:00', '08:00');
        THROW 51002, 'Expected time-range CHECK violation was not raised.', 1;
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() <> 547 THROW;
    END CATCH;

    /* Unique lookup-key enforcement. */
    BEGIN TRY
        INSERT INTO [dbo].[Species] ([CommonName], [ScientificName])
        VALUES (N'Constraint Test Species', N'Duplicate scientific name');
        THROW 51003, 'Expected unique-key violation was not raised.', 1;
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() NOT IN (2601, 2627) THROW;
    END CATCH;

    /* WDFW SRF count relationship enforcement. */
    INSERT INTO [dbo].[WdfwSrfDailyRegistration] ([RegistrationDate], [StationId])
    VALUES ('2026-01-01', @StationId);
    SET @DailyRegistrationId = CONVERT(INT, SCOPE_IDENTITY());

    BEGIN TRY
        INSERT INTO [dbo].[WdfwSrfTrip] ([WdfwSrfDailyRegistrationId], [FishedLocationId])
        VALUES (@DailyRegistrationId, -1);
        THROW 51004, 'Expected fished-location foreign-key violation was not raised.', 1;
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() <> 547 THROW;
    END CATCH;

    INSERT INTO [dbo].[WdfwSrfTrip] ([WdfwSrfDailyRegistrationId], [FishedLocationId])
    VALUES (@DailyRegistrationId, @FishedLocationId);
    SET @TripId = CONVERT(INT, SCOPE_IDENTITY());

    BEGIN TRY
        INSERT INTO [dbo].[WdfwSrfCatch]
            ([SpeciesId], [CaughtCount], [ReleasedCount], [WdfwSrfTripId])
        VALUES (@SpeciesId, 1, 2, @TripId);
        THROW 51005, 'Expected released-count CHECK violation was not raised.', 1;
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() <> 547 THROW;
    END CATCH;

    BEGIN TRY
        INSERT INTO [dbo].[WdfwSrfCatch]
            ([SpeciesId], [CaughtCount], [ReleasedCount], [SrfQualifyingCount], [WdfwSrfTripId])
        VALUES (@SpeciesId, 1, 0, 2, @TripId);
        THROW 51006, 'Expected qualifying-count CHECK violation was not raised.', 1;
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() <> 547 THROW;
    END CATCH;

    ROLLBACK TRANSACTION;
    PRINT 'Schema integrity tests passed.';
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
    THROW;
END CATCH;
