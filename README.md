# Docker Webgrind
## About
This is a containerized version of the
[jokkedk/webgrind](https://github.com/jokkedk/webgrind) project.

## Usage
### Simple
1. Put your `cachegrind.out.*` files into `perf/`
1. Run `make webgrind`

   This builds the container locally on your machine and then launches,
   listening on port `8090/tcp`.

### Advanced
If you don't want to move your cachegrind files around, you may also link
their containing directory into the container:

```sh
make webgrind PERF_DIR=/path/to/your/files
```

Or if you'd like to change the port number it's listening on:

```sh
make webgrind PORT=12345
```

### Expert
If you know Docker, read the [Makefile](Makefile) and
[Dockerfile](Dockerfile) to get a look under the hood.
