# Build

```bash
make build
```
__or__
```bash
docker build --rm --no-cache --pull  -t bertuss/sickrage .
```

# Run

```bash
docker run \
    -d \
    --name sickrage \
    -p 8081:8081 \
	-v /host/data:/data \
    -e USERNAME=username \
    -e PASSWORD=password \
    -e DEBUG=true \
    bertuss/sickrage
```