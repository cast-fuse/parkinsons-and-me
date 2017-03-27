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
> mix ecto.create && mix ecto.mirgate
```

this creates a local database

after the dependencies are installed and database setup, run:

```sh
> mix phoenix.server
```

and visit `localhost:4000` to see the app running
