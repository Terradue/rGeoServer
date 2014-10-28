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

Note: 
The rGeoServer package only supports the Username/password authentication http://docs.geoserver.org/stable/en/user/security/auth/providers.html#username-password-authentication 
The user must save his own access GeoServer credentials on a R variable "geoserver.authn" in "username:password"  form or he will not be able to send data to the GeoServer server.

```coffee
geoserver.authn <- "my.username:my.password"
```

### Exemple, create and publish a ratser image 

```coffee
library(rGeoServer)
library(sp)
library(gstat)
data(meuse)

setwd("~/Downloads")

geoserver.accessPoint <- "http://localhost:8080/geoserver/rest"
geoserver.workspacename <- "Test.GeoServerRaster"
geoserver.coveragestore <- "example.coverageStore"

# create the workspace name on the geoserver or use an already created workspace
CreateGeoServerWorkspace(geoserver.accessPoint, geoserver.workspacename)

coordinates(meuse) = ~x+y
data(meuse.grid)
gridded(meuse.grid) = ~x+y
m <- vgm(.59, "Sph", 874, .04)
# ordinary kriging:
x <- krige(log(zinc)~1, meuse, meuse.grid, model = m)
r <- raster(x[1])

cs<-CreateGeoServerCoverageStore(geoserver.accessPoint,
		                         geoserver.workspacename,
		                         geoserver.coveragestore,
		                         TRUE,
		                         "GeoTIFF",
		                         "file:data/raster.tif")

t<-POSTraster(access.point, workspace, coverage.store, r)

```

### Exemple, create and publish a vector image on the GeoServer server
```coffee
library(rGeoServer)

data(meuse.riv)
setwd("~/Downloads")

geoserver.accessPoint <- "http://localhost:8080/geoserver/rest"
geoserver.workspacename <- "Test.GeoServerVector"
dataStore <- "River.Datastore"

# create the workspace name on the geoserver or use an already created workspace
CreateGeoServerWorkspace(geoserver.accessPoint, geoserver.workspacename)

river_polygon <- Polygons(list(Polygon(meuse.riv)), ID = "meuse")
rivers <- SpatialPolygons(list(river_polygon))
proj4string(rivers) <- CRS(paste("+init=epsg:28992","+towgs84=565.237,50.0087,465.658,-0.406857,0.350733,-1.87035,4.0812"))

rivers <- spTransform(rivers, CRS("+init=epsg:4326"))

rivers_df <- SpatialPolygonsDataFrame(rivers,data=data.frame(row.names=row.names(rivers)))
River<- SpatialPolygonsDataFrame(rivers, data = data.frame(ID="meuse", row.names="meuse",stringsAsFactors=FALSE))
response <- POSTpolygons(geoserver.accessPoint, geoserver.workspacename, dataStore, River)
```

## Questions, bugs, and suggestions

Please file any bugs or questions as [issues](https://github.com/Terradue/rGeoServer/issues/new) or send in a pull request.


