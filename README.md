# WeFunder

This is the API for the [PitchDeck App](https://github.com/jonada182/pitch_deck)

### Requirements 

* Ruby version: `^3.1`
* Rails version: `^7.0`
* Bundler version: `^2.0`

### System dependencies

* `ImageMagick`

* `poppler_utils`

### Getting Started

* Install the app gems: `bundle install`
* Run the database migrations: `rails db:migrate:reset`
* Run the database seeder: `rails db:seed`
* Start the server: `rails s`

### API endpoints

#### Companies

* Get All Companies (GET): `companies`
* Get Company by Slug (GET): `companies/:slug`
* Create a Company (POST): `companies`
* Update Company by Slug (PUT): `companies/:slug`
* Delete a Company (DELETE): `companies/:slug`

#### Pitches

* Get All Pitches by Company Slug (GET): `pitches?company_slug=[:slug]`
* Get Pitch by ID (GET): `pitches/:id`
* Create a Pitch (POST): `pitches`
* Update Pitch by ID (PUT): `pitches/:id`
* Delete a Pitch (DELETE): `pitches/:id`

#### Slides

* Get All Slides by Pitch ID (GET): `slides?pitch_id=[:id]`
* Get Slide by ID (GET): `slides/:id`
* Create a Slide (POST): `slides`
* Update Slide by ID (PUT): `slides/:id`
* Delete a Slide (DELETE): `slides/:id`
