# Parkinson's And Me

A service to match a person affected by Parkinson's with a relevant Parkinson's UK service.


Built using [`Elixir`, `Phoenix`](http://www.phoenixframework.org/), [`Elm`](http://elm-lang.org/), and [`Tachyons`](http://tachyons.io/)

### Why?

Parkinson's UK have a fantastic range of services for people with Parkinson's.
However, people newly diagnosed with Parkinson's often find the range of choice overwhelming, making it difficult to get to the services that are most relevant to them.

### How?

`Parkinson's and Me` is a web app that aims to solve this problem by guiding the user through a `series of quotes` from people with Parkinson's, and asking the user if "this sounds like me".

After answering the quotes the user is shown the `top 3 Parkinson's UK services` that are most relevant to them. The user can revisit a previous service sent via a `url` and can have the services sent to them by `email`.

#### Long term goals

The `Parkinson's and me` service aims to be as friendly and personal as possible. As the project grows the aim will be to further customise the experience to the particular user as much as possible (using the data that the user inputs: `age range` and `postcode`)

### Installation and Setup

To get up and running - make sure you have installed:

+ [`node.js`](https://nodejs.org/en/download/)
+ [`elixir`](http://elixir-lang.org/install.html)
+ [`phoenix`](http://www.phoenixframework.org/docs/installation)
+ [`elm`](https://guide.elm-lang.org/install.html)
+ [`postgres`](https://www.postgresql.org/download/)

after installing, to install the dependencies run:

```sh
> mix deps.get && npm install && elm package install
```

make sure postgres is running and then run

```sh
> mix ecto.create && mix ecto.migrate
```

this creates a local database

after the dependencies are installed and database setup, run:

```sh
> mix phoenix.server
```

and visit `localhost:4000` to see the app running

### Deployment

The app is currently hosted on `heroku`, with the following versions:

+ `staging` (`https://parkinsons-and-me-staging.herokuapp.com`)
+ `production` (`https://parkinsons-and-me.herokuapp.com`)

Heroku is set up to automatically deploy from `staging` and `master` branches (to staging and production versions respectively).

### Environment Variables

to add the env vars to the app, make a `.env` in the root of your app and add this (with your own vars in place)

```env
export MAILGUN_KEY="your mailgun secret key"
export MAILGUN_DOMAIN="your mailgun domain"
```

and link the .env file to the phoenix app by running in your terminal:

```sh
source .env
```

the following env vars are also set on heroku but are not as relevant to development

```env
export DATABASE_URL="heroku postgres db url"
export POOLSIZE=18
export SECRET_KEY_BASE="elixir generated secret key"
export PRODUCTION_GA="production ga code"
```

the following are only set on the staging environment, add these locally to see the elm debugger and staging google analytics

```env
export STAGING=true
export STAGING_GA="staging ga code"
```

### Tests

Tests for the frontend and backend are kept in the `test` directory. To run the tests:

+ for `elm`: `npm test`
+ for `phoenix`: `mix test`

Before pull requests can be merged into `staging` or `master` the tests run and must pass on `Circle CI`

### Circle CI Setup

The configuration for running the test suite on Circle is included in `/circle.yml` and `/.tool-versions`. The [`asdf` package manager](https://github.com/asdf-vm/asdf) is used to install `Erlang` and `Elixir` and to cache these installations if they have not changed since the last build. `/.tool-versions` contains the version numbers to install. Full details can be found on the following article -

[Simple CircleCI Config for Phoenix Projects](https://medium.com/@QuantLayer/simple-circleci-config-for-phoenix-projects-fc3ae271aff1)
