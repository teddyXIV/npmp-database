# NPMP Controlled Vocabulary

## Purpose and authority

This business glossary establishes the shared meaning of terms used by the
Northern Pikeminnow Management Program (NPMP) database. It is intended for
database users, data-entry processes, and import developers.

The SQL Database Project is the implementation authority for table structure,
data types, nullability, constraints, and relationships. This glossary does
not itself prescribe lookup rows, tag-code formats, species- or size-based
eligibility thresholds, or field-collection protocols. Those decisions require
separate, controlled approval.

## Governance and identifiers

| Term | Definition | Schema use | Notes |
| --- | --- | --- | --- |
| Controlled vocabulary | A governed set of terms and, where later approved, the allowable values used to represent a domain consistently. | All lookup domains | This first iteration defines terms only; it does not supply approved value lists. |
| Lookup domain | A reusable category whose values are stored once and referenced by operational records. | `Species`, `Sex`, `State`, `Reach`, `Reservoir`, `Station`, `FishedLocation`, `TagType`, `TagColor` | Each domain has its own identity key and code or name fields as applicable. |
| Surrogate identifier | A database-generated integer that uniquely identifies one stored row. | All tables' `...Id` primary keys | It is a technical key, not a business code or field identifier. |
| Code | A concise, unique representation of a controlled value. | `ReachCode`, `ReservoirCode`, `StateCode`, `SexCode`, `TagTypeCode`, `TagColorCode` | The format and approved values are intentionally not defined here. |
| Name | The human-readable label of a controlled value or location. | `...Name`, `CommonName`, `ScientificName` | A name is not interchangeable with its surrogate identifier. |
| Source-reported value | A value supplied by the originating collection or reporting process rather than calculated by the database. | `SurveyEffort` and operational observations | Source protocol and validation rules may be added later. |

## Biology and tagging

| Term | Definition | Schema use | Unit or representation |
| --- | --- | --- | --- |
| Species | A biological taxon recorded for a catch or biological observation. | `Species`; operational `SpeciesId` references | Identified by common name and optionally scientific name. |
| Common name | The program's human-readable name for a species or reach. | `Species.CommonName`, `Reach.CommonName` | Text. Meanings are contextual to the referenced domain. |
| Scientific name | The scientific taxonomic name for a species. | `Species.ScientificName` | Text; optional. |
| Sex | The recorded sex classification of an individually observed fish. | `Sex`; `WdfwSrfBiologicalObservation.SexId` | Controlled lookup value; approved values are pending. |
| Fork length | Fish length measured from the snout to the fork of the tail. | `ForkLengthMillimeters` | Whole millimeters. |
| Weight | Recorded mass of an individual fish. | `WeightGrams` | Grams, with up to two decimal places. |
| PIT tag code | The identifier read from or assigned to a passive integrated transponder (PIT) tag. | `PitTagCode` | Text; format and uniqueness policy are pending. |
| External tag code | The identifier printed on or otherwise associated with a non-PIT external tag. | `ExternalTagCode` | Text; format and uniqueness policy are pending. |
| Tag type | The classification of an external tag. | `TagType`; `ExternalTagTypeId` | Controlled lookup value; approved values are pending. |
| Tag color | The color classification of an external tag. | `TagColor`; `TagColorId` | Controlled lookup value; approved values are pending. |

## Geography

The location hierarchy is **Reach → Reservoir → Station**. A station also
records its state and may record its city.

| Term | Definition | Schema use |
| --- | --- | --- |
| State | A state associated with a station. | `State`; `Station.StateId` |
| Reach | A program-defined river or waterway reach used to organize reservoirs. | `Reach`; `Reservoir.ReachId` |
| Reservoir | A program-defined water body or reservoir within a reach. | `Reservoir`; `Station.ReservoirId`; `OdfwMonitoringSurvey.ReservoirId` |
| Station | A named program sampling or registration location within a reservoir. | `Station`; `WdfwSrfDailyRegistration.StationId` |
| City | The optional city associated with a station. | `Station.City` |
| Latitude | The station's geographic north-south coordinate. | `Station.Latitude` | Decimal degrees from -90 through 90. |
| Longitude | The station's geographic east-west coordinate. | `Station.Longitude` | Decimal degrees from -180 through 180. |
| Fished location | A controlled location value identifying where an SRF trip was fished. | `FishedLocation`; `WdfwSrfTrip.FishedLocationId` | Identified by a unique code and a description. |

## ODFW monitoring

| Term | Definition | Schema use | Unit or representation |
| --- | --- | --- | --- |
| Monitoring survey | A dated ODFW monitoring activity conducted at a reservoir. | `OdfwMonitoringSurvey` | May include start/end times and effort. |
| Survey date | The calendar date on which a monitoring survey occurred. | `OdfwMonitoringSurvey.SurveyDate` | Date. |
| Survey start time | The optional local time at which the monitoring survey began. | `OdfwMonitoringSurvey.SurveyStartTime` | Time to whole seconds. |
| Survey end time | The optional local time at which the monitoring survey ended. | `OdfwMonitoringSurvey.SurveyEndTime` | Time to whole seconds; when both times are present, it is later than the start time. |
| Survey effort | The source-reported total duration of a monitoring survey. | `OdfwMonitoringSurvey.SurveyEffort` | Whole seconds. |
| Catch count | The number of fish represented by an aggregate catch record. | `OdfwMonitoringIncidentalCatch.CatchCount` | Nonnegative whole number. |
| Target catch | An individual fish physically handled and tagged during an ODFW monitoring survey. Target-catch eligibility is independent of species and size. | `OdfwMonitoringTargetCatch` | Species, measurements, and tag attributes are recorded when available. |
| Incidental catch | An aggregate count, by species, of fish caught during an ODFW monitoring survey that were not individually handled and tagged as target catch. | `OdfwMonitoringIncidentalCatch` | One record per survey and species. |

## WDFW Sport Reward Fishery

| Term | Definition | Schema use | Unit or representation |
| --- | --- | --- | --- |
| Sport Reward Fishery (SRF) | The WDFW program represented by the `WdfwSrf` records. | `WdfwSrfDailyRegistration`, `WdfwSrfTrip`, `WdfwSrfCatch`, `WdfwSrfBiologicalObservation` | `SRF` is the accepted abbreviation. |
| Daily registration | A dated SRF registration at a station. | `WdfwSrfDailyRegistration` | Parent record for one or more trips. |
| Registration date | The calendar date of an SRF daily registration. | `WdfwSrfDailyRegistration.RegistrationDate` | Date. |
| Trip | An SRF activity record associated with one daily registration and, when recorded, a fished location. | `WdfwSrfTrip` | Parent record for catch and biological observations. |
| Catch | Aggregate SRF catch for one species during one trip. | `WdfwSrfCatch` | One record per trip and species. |
| Biological observation | An individual fish observation made during an SRF trip. | `WdfwSrfBiologicalObservation` | May include species, fork length, tags, tag attributes, and sex. |
| Caught count | The total number of fish caught in an SRF trip for one species. | `WdfwSrfCatch.CaughtCount` | Nonnegative whole number. |
| Released count | The number of fish released from the corresponding SRF trip and species catch. | `WdfwSrfCatch.ReleasedCount` | Nonnegative whole number and not greater than caught count. |
| SRF qualifying count | The number of fish caught in an SRF trip and species catch that qualify for sport-reward payment because they meet the applicable species and size criteria. | `WdfwSrfCatch.SrfQualifyingCount` | Optional nonnegative whole number; when recorded, it cannot exceed caught count. |
