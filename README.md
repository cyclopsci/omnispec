# omnispec

All-in-one docker image for ansible and puppet spec testing.

# usage
```
docker build -t omnispec .
docker run -it omnispec
```
Building the image takes about 5 mins for base dependencies.
Each ansible version takes approximately 1 minute.
Each puppet version takes approximately 15 seconds.
