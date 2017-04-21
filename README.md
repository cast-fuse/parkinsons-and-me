# What3Things

A service to match a person affected by Parkinsons with a relevant PUK service.


Built using [`Elixir`, `Phoenix`](http://www.phoenixframework.org/), [`Elm`](http://elm-lang.org/), and [`Tachyons`](http://tachyons.io/)

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

### Circle CI Setup

The configuration for running the test suite on Circle is included in `/circle.yml` and `/.tool-versions`. The [`asdf` package manager](https://github.com/asdf-vm/asdf) is used to install `Erlang` and `Elixir` and to cache these installations if they have not changed since the last build. `/.tool-versions` contains the version numbers to install. Full details can be found on the following article -

[Simple CircleCI Config for Phoenix Projects](https://medium.com/@QuantLayer/simple-circleci-config-for-phoenix-projects-fc3ae271aff1)
