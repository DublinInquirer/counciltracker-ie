# README

This is a fork of https://github.com/civictech-ie/counciltracker-ie which ran [counciltracker.ie](https://www.counciltracker.ie).

Council Tracker is a Rails app that tracks and publishes the motions, amendments, and votes of Dublin City councillors. It also includes data entry functionalities for volunteers to keep it up to date.

## Get set up

### Requirements
- Ruby 3.2.2
- PostgreSQL (this README assumes the database server runs in a Docker container)

### Setting up the database from a seed dump file
1. Contact the team to get a live database connection string or a dump file.
2. (Skip if you have a dump file) With the database connection string, `pg_dump -Fp --no-acl --no-owner DATABASE_CONNECTION_STRING > counciltracker.dump`.
3. Spin up a database container `docker run --name counciltracker_development -e POSTGRES_USER="$USER" -e POSTGRES_DB=counciltracker_development -e POSTGRES_HOST_AUTH_METHOD=trust -p 5432:5432 -d postgres`.
4. Import the dump file `docker exec -i counciltracker_development psql -U $USER -d counciltracker_development < counciltracker.dump`.

### Setting up the Rails app
1. `bundle install`
2. `bundle exec rails server`
3. If you get an error about `webpacker`, you may also need to run `bundle exec rails webpacker:install`.

### Setting up image file storage

TODO

## License

[Apache 2.0](LICENSE)