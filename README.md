# QuakeJs - CPMA

## Build docker image

```sh
cd quake-server
docker build -t rmsrob/quake3js .
docker-compose up
```

> If you need to check inside the container

```sh
docker exec -it quakejs bash
# apply change and exit
docker restart quakejs
```

> In **Google Chrome** open [http://localhost:8080/](http://localhost:8080/)
> Agree the EULA and frag!

> Again open in Google Chrome if you see this kind of error in the console after accepting the EULA and the game not loading.
```js
ioquake3.js:12428 Uncaught RangeError: Invalid array length
    at Uint8Array.slice (<anonymous>)
    at Object.ensureFlexible (ioquake3.js:12428:49)
```

## Add map or `.pk3`

deposit your `.pk3` file inside `updates/` folder and then you need to apply a fix
- on the name of the file and on the `manifest.json`

> to do this use the script

```sh
./quakejs/cctools/crc-rename ../../updates/baseq3/*
```

## Drop your cfg

- open google chrome dev console `CTRL + J`
- pass your cfg in between the back tick
```js
FS.writeFile(
  "base/baseq3/your_name.cfg",
  ``
);
```
- if you change some video setings
    - open the quakejs console with `@` or `~`
    - type `/reconnect`