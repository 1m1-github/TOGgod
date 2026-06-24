# TOGgod

## Install julia

```
curl -fsSL https://install.julialang.org | sh
```

## Create directory

```
mkdir <nameofgod> && cd <nameofgod>
```

## Install

```
env JULIA_PROJECT=.tog JULIA_DEPOT_PATH=.tog/julia julia --optimize=3 --threads=auto --quiet --eval 'using Pkg
Pkg.Registry.add("General")
Pkg.Registry.add(url="https://github.com/1m1-github/TOGRegistry.git")
Pkg.add("TOGi")'
```

## Run

```
env JULIA_PKG_DEVDIR=$HOME/.julia/dev JULIA_PROJECT=.tog JULIA_DEPOT_PATH=.tog/julia julia --optimize=3 --threads=auto --interactive --quiet --eval 'using TOGi;TOGi.awaken()'
```

## Update

```
env JULIA_PROJECT=.tog JULIA_DEPOT_PATH=.tog/julia julia --optimize=3 --threads=auto --quiet --eval 'using Pkg;Pkg.update(update_registry=false)'
```
