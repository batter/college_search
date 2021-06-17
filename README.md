# College Search

To setup your local environment to run this, ensure you have Ruby 2+ installed,
then install dependencies by running:

```
$ bundle
```

##### Configure API Keys:

`ENV['DATA_GOV_API_KEY']` needs to have a valid API key from [College Scorecard](https://collegescorecard.ed.gov/data/documentation/)

`ENV['GOOGLE_MAPS_API_KEY']` needs to have a valid API key from [Google Maps](https://developers.google.com/maps/documentation/javascript/get-api-key)

##### To launch the app locally run:

```
$ DATA_GOV_API_KEY=data-gov-api-key GOOGLE_MAPS_API_KEY=google-maps-api-key bundle exec rackup
```

##### To launch the app in dev mode:

```
$ DATA_GOV_API_KEY=data-gov-api-key GOOGLE_MAPS_API_KEY=google-maps-api-key bundle exec shotgun
```
