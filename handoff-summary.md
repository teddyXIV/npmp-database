# Handoff Summary

## Current objective

Establish the first buildable Microsoft SQL Server schema iteration for the
Northern Pikeminnow Management Program (NPMP) database. The database is
greenfield: the original Access database contained design-only objects and no
data is being migrated.

## Completed work

- Created an SDK-style SQL Database Project schema under `database/Tables/`,
  with one SQL file per table (19 tables total).
- Kept `schema.sql` in the repository root unchanged as a historical Access
  export. It is not included by the SQL project and must not be executed as
  the SQL Server schema source.
- Added `README.md` with build instructions, schema conventions, unit choices,
  and the Access-system-object exclusion.
- Added `tests/SchemaIntegrityTests.sql`, a transaction-rolled-back script for
  a disposable database deployed from the project DACPAC.

## Schema design decisions

### Naming and keys

- The SQL Server contract is greenfield and uses PascalCase table and column
  names; compatibility objects for the Access-export names are intentionally
  not provided.
- Every table uses an `INT IDENTITY` surrogate primary key with a conventional
  `PK_<Table>` constraint name.
- Shared lookup tables use unique business codes or names. `Species` allows
  a null scientific name while enforcing uniqueness only for non-null
  scientific names through a filtered unique index.
- Child foreign keys are indexed. Relationships do not specify cascades; data
  deletions must be handled deliberately.

### Shared lookups and geography

- Lookup tables: `Species`, `Sex`, `State`, `TagType`, and `TagColor`.
- Geographic hierarchy: `Reach` -> `Reservoir` -> `Station`; stations also
  reference `State`.
- No seed data is included. Lookup data must be loaded through a controlled
  process before operational records are loaded.

### Source-specific operational models

- WDFW DA: `WdfwDaLocation` -> `WdfwDaReport` -> `WdfwDaCatch` ->
  `WdfwDaCatchDetail`. A report has one catch row per species and a catch has
  at most one detail row.
- ODFW monitoring: `OdfwMonitoringSurvey` ->
  `OdfwMonitoringIncidentalCatch` and `OdfwMonitoringTargetCatch`.
  Incidental catch is unique per survey/species; target-catch rows represent
  individual records and can contain optional tag and measurement details.
- WDFW SRF: `WdfwSrfDailyRegistration` -> `WdfwSrfTrip` ->
  `WdfwSrfBiologicalObservation` and `WdfwSrfCatch`. SRF catch is unique per
  trip/species.

### Data integrity and units

- Essential parent relationships, dates, species, and aggregate counts are
  required. Collection fields that may be unavailable (measurements, tag
  values, sex, effort) remain nullable.
- Fork length is stored as integer millimeters (`ForkLengthMillimeters`).
  Weight is stored as decimal grams (`WeightGrams DECIMAL(10,2)`).
- CHECK constraints prevent negative counts/effort, nonpositive biological
  measurements, a survey end time not later than its start time, and SRF
  released counts greater than caught counts.
- The original Access `MSys*` navigation-table references are excluded; no
  Access system objects exist in the SQL project.

## Files affected

- `database/npmp-database.sqlproj` - existing SDK-style project; SDK default
  item inclusion discovers the SQL files under `database/Tables/`.
- `database/Tables/*.sql` - all declarative table, relationship, index, and
  constraint definitions.
- `README.md` - project setup and schema documentation.
- `tests/SchemaIntegrityTests.sql` - representative FK, unique, and CHECK
  constraint tests; it always rolls back its fixture transaction.
- `schema.sql` - retained, unchanged historical Access export.

## Validation performed

- Confirmed 19 `CREATE TABLE` definitions exist under `database/Tables/`.
- Searched the SQL Project directory and confirmed it contains no `MSys`
  references.
- Reviewed declared foreign-key targets, unique keys, and CHECK constraints.
- Attempted `dotnet build .\\database\\npmp-database.sqlproj`; it could not run
  because this environment has no .NET SDK. `msbuild` and `sqlpackage` are
  also unavailable.
- `sqlcmd` is installed, but no authorized disposable SQL Server target was
  available, so `SchemaIntegrityTests.sql` was not executed.

## Outstanding issues and next steps

1. Install a compatible .NET SDK / SQL Database Project build tooling, then
   build `database/npmp-database.sqlproj` and resolve any model errors.
2. Deploy the resulting DACPAC to an authorized disposable development
   database; inspect the generated deployment SQL before applying it anywhere
   persistent.
3. Run `tests/SchemaIntegrityTests.sql` against that disposable database.
4. Confirm collection-protocol semantics before expanding the model. In
   particular, do not introduce unit conversions, tag uniqueness rules, audit
   metadata, cascades, or seed data without a documented business requirement.
5. Before any deployment or data load, have a human review the schema and
   provide explicit authorization for the target environment.

## Approval status

The schema source files, README, and test script have been created locally.
No data migration, database deployment, data modification, commit, push, or
production operation has been performed or authorized.
