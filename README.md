# QuakeJs - CPMA

# build docker image

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

open [http://localhost:8080/](http://localhost:8080/)
agree the EULA of Quake