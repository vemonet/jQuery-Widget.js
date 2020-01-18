# Comunica SPARQL jQuery Widget
[<img src="http://linkeddatafragments.org/images/logo.svg" width="200" align="right" alt="" />](http://linkeddatafragments.org/)

[![Build Status](https://travis-ci.org/comunica/jQuery-Widget.js.svg?branch=master)](https://travis-ci.org/comunica/jQuery-Widget.js)
[![Docker Automated Build](https://img.shields.io/docker/automated/comunica/jquery-widget.js.svg)](https://hub.docker.com/r/comunica/jquery-widget.js/) [![Greenkeeper badge](https://badges.greenkeeper.io/comunica/jQuery-Widget.js.svg)](https://greenkeeper.io/)

**[Try the _Comunica SPARQL jQuery Widget_ online.](http://query.linkeddatafragments.org/)**

This jQuery widget is a browser-based user interface to the [Comunica SPARQL client](https://github.com/comunica/comunica/tree/master/packages/actor-init-sparql).
It allows users to execute SPARQL queries over one or multiple heterogeneous interfaces, such as [Triple Pattern Fragments interfaces](http://www.hydra-cg.com/spec/latest/triple-pattern-fragments/).

## Using the code
- Run `yarn install` to fetch dependencies and build the browser version of the client code.
- Run `yarn run start` to run a local Web server.
- Edit datasources in `settings.json` and queries in the `queries` folder, and run `queries-to-json` to compile both of them in a single JSON file.
- Run `yarn run production` to generate a production version in the `build` folder.

## How the browser client works
The original _Comunica SPARQL_ engine is written for the Node.js environment.
The [Webpack](https://webpack.js.org/) library makes it compatible with browsers.

The query engine itself runs in a background thread
using [Web Workers](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers).
The user interface (`ldf-client-ui.js`)
instructs the worker (`ldf-client-worker.js`) to evaluate queries
by sending messages,
and the worker sends results back.

### Running in a Docker container

Configure your widget by editing the [settings.json](https://github.com/comunica/jQuery-Widget.js/blob/master/settings.json) file.
Next, create a [queries directory](https://github.com/comunica/jQuery-Widget.js/tree/master/queries) in which you should insert the queries that will be present by default in the widget.

Build the [Docker](https://www.docker.com/) container as follows:

```bash
docker build -t comunica-sparql-widget .
```

After that, you can run your newly created container by mounting your current folder to the Docker container:
```bash
docker run -p 8080:80 --name comunica -it --rm comunica-sparql-widget
```

Settings and queries can be passed at runtime:

```bash
# Compile the file in queries folder and settings.json to queries.json
./queries-to-json

# Provide the compiled queries.json at runtime
docker run -v $(pwd)/queries.json:/usr/share/nginx/html/queries.json -p 8080:80 --name comunica -it --rm comunica-sparql-widget
```

## License

The Linked Data Fragments jQuery Widget was originally written by [Ruben Verborgh](https://ruben.verborgh.org/)
and ported for Comunica SPARQL by [Ruben Taelman](http://rubensworks.net/).

This code is copyrighted by [Ghent University – imec](http://idlab.ugent.be/)
and released under the [MIT license](http://opensource.org/licenses/MIT).
