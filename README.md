# NPMP database

This repository contains the SQL Server schema for the Northern Pikeminnow
Management Program database. The SDK-style SQL Database Project in
`database/npmp-database.sqlproj` is the authoritative schema source.

## Build

Build the project from the repository root:

```powershell
dotnet build .\database\npmp-database.sqlproj
```

The build creates a DACPAC under `database/bin/`. Review the deployment script
before publishing it to any database.

## Schema conventions

- Tables use PascalCase names and identity surrogate primary keys.
- Shared species, location, tagging, and sex values are maintained in lookup
  tables; operational records reference them with foreign keys.
- Fork lengths are stored in millimeters and weights in grams.
- No lookup rows are seeded by this project. Load reference data through a
  controlled process before loading operational records.

`schema.sql` in the repository root is an unexecuted historical Access export.
It is retained for reference only and is not included in the database project.
In particular, its Access `MSys*` navigation-object references are not part of
this SQL Server schema.

## Validation

`tests/SchemaIntegrityTests.sql` is a transaction-rolled-back test script for a
disposable development database created from the DACPAC. It checks selected
unique, foreign-key, and CHECK constraints. Do not run it against production.
