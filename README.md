# omnispec

[![Join the chat at https://gitter.im/cyclopsci/omnispec](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/cyclopsci/omnispec?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

All-in-one docker image for ansible and puppet spec testing.

# build
```
docker build -t omnispec .
docker run -it omnispec
```

# omni
The included `/usr/bin/omni` tool allows for easy switching between tool environments.

See the available tools
```
omni ls
```

Activate an environment.  The tool should be launched within `$()` to allow it to setup your shell environment and path.
```
$ $(omni enter ansible 1.0)
$ $(omni enter puppet 3.2.4)
```

To leave the environment:
```
$ $(omni exit)
```
