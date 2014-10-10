# rGeoServer

R interface to rGeoServer

<!---[![DOI](https://zenodo.org/badge/3806/Terradue/rOpenSearch.png)](http://dx.doi.org/10.5281/zenodo.10642)-->

### Documentation


Inside R, use ?_<function name>_ to view the function's help page. Example:

```coffee
?rGeoserverFunciton
```

### Citing this package

<!---To cite rOpenSearch use its [DOI](http://dx.doi.org/10.5281/zenodo.10642)-->

### Installing a release

The releases are available at: https://github.com/Terradue/rGeoServer/releases

Releases can be installed using [devtools](http://www.rstudio.com/products/rpackages/devtools/)

Start an R session and run:

```coffee
library(devtools)
install_url("https://github.com/Terradue/rGeoServer/releases/download/v0.1-SNAPSHOT/rGeoServer_0.1.0.tar.gz")
library(rGeoServer)
```

> Note the example above install the v0.1-SNAPSHOT release, adapt it to the current release

### Building and installing the development version

The rGeoServer package is built using maven.

From a terminal: 

```bash
cd
git clone git@github.com:Terradue/rGeoServer.git
cd rGeoServer
mvn compile
```

That generates a compressed archive with the rOpenSearch package in:

```
~/rGeoServer/target/R/src/rGeoServer_x.y.z.tar.gz
```
To install the package, start an R session and run:

```coffee
install.packages("~/rGeoServer/target/R/src/rGeoServer_x.y.z.tar.gz", repos=NULL, type="source")
```

> Note x.y.z is the development version number.

Then load the library:

```coffee
library(rGeoServer)
```

## Getting Started 

### to do: make an example

This example:


```coffee
library(rGeoServer)


```

## Questions, bugs, and suggestions

Please file any bugs or questions as [issues](https://github.com/Terradue/rGeoServer/issues/new) or send in a pull request.


