# Inventory API Server

A server app built using [Shelf](https://pub.dev/packages/shelf).

## Running with the Dart SDK

Run with the [Dart SDK](https://dart.dev/get-dart).

For in-memory database:
```shell
$ dart -DPET_SQL_PATH=db/inventory.sql bin/server.dart
$ Server listening on port 8080...
```

For database file:
```shell
$ dart -DPET_SQL_PATH=db/inventory.sql -DDB_PATH=db/inventory.db bin/server.dart
$ Server listening on port 8080...
```

And then from a second terminal:

```shell
# GET: Root
$ curl -X GET http://localhost:8080

# GET: Select all items
$ curl -X GET http://localhost:8080/pets

# GET: Select one item by id
$ curl -X GET http://localhost:8080/pets/1

# GET: Search by given 'term'
$ curl -X GET http://localhost:8080/search/term

# POST: Insert a record
$ curl -X POST http://localhost:8080 -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":350000}'

# PATCH: Update a record by given id
$ curl -X PATCH http://localhost:8080/1 -H 'Content-Type: application/json' -d '{"animal":"Elephant", "description":"A giant and heavy creature", "age":250, "price":250000}'

# DELETE: Delete a record by given id
$ curl -X DELETE http://localhost:8080/1
```

## Web

A bare-bones Dart web app.

Uses [`package:web`](https://pub.dev/packages/web)
to interop with JS and the DOM.

## Running and building

To run the app,
activate and use [`package:webdev`](https://dart.dev/tools/webdev):

```
dart pub global activate webdev
webdev serve
```

To build a production version ready for deployment,
use the `webdev build` command:

```
webdev build
```

To learn how to interop with web APIs and other JS libraries,
check out https://dart.dev/interop/js-interop.

```
Access-Control-Allow-Origin = http://localhost:8080 (instead of '*')
Access-Control-Allow-Credentials = true
```

Find process by port and kill.

```sh
$ lsof -i tcp:8080
$ kill -9 pId
```
