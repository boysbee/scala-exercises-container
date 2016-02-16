# scala-exercises-container

This is a Docker example project which uses this repo: https://github.com/47deg/scala-exercises
To run the original url: http://scala-exercises.47deg.com/index in a container.

To run with docker, execute the following commands:

```bash
git clone ....
```

```bash
cd scala-exercises-container
```

```bash
docker build -t scala/exer
```

```bash
docker run -p 9000:9000 scala/exer
```
