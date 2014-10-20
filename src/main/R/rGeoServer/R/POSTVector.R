#' Posts a vector data image to a GeoServer 
#' @description Posts a vector data image to a GeoServer given an existing workspace and coverage store. 
#'
#' @param access.point GeoServer REST API access point
#' @param workspace GeoServer workspace 
#' @param file.name
#' @param layer.name
#' @param input a SpatialObjectDataFrame
#' @return charecter vector
#' @examples \dontrun{
#' TO DO
#' filename <- "/Users//fbrito/Downloads/ARMOR3D_REPv3-1_20121121_20140420-2.nc"
#' r <- raster(filename)
#' POSTVector("http://localhost:8080/geoserver/rest", workspace="aname", coverage.store="astore", r)
#' }
#'
#' @export
#' @import sp

POSTVector <- function(access.point, workspace, file.name, layer.name, input) {
     # store the current work dir
     orig.wd <- getwd()
     
     # save shapefile data
     writeOGR(input, layer.name, file.name, driver="ESRI Shapefile")
     
     temp.dir <- paste(orig.wd, layer.name, sep="/")
     files <- list.files(temp.dir, recursive = TRUE)
     zip.fileName <- paste(file.name,"zip",sep=".")
     zip(zip.fileName,files=paste(temp.dir, files, sep="/"),)
     
     # curl -v -u admin:geoserver -XPUT -H "Content-type: application/zip"
     # --data-binary @roads.zip
     # http://localhost:8080/geoserver/rest/workspaces/acme/datastores/roads/file.shp
     
     # access.point <- "http://localhost:8080/geoserver/rest"
     # workspace <- "acme"
     # datastore <- "roads"
     
     # build the access point
     end.point <- paste(access.point, "workspaces", workspace, "datastores", file.name, "file.shp", sep="/")
     command.args <- paste("-v -u '", geoserver.authn, "' -XPUT -H 'Content-type: application/zip' --data-binary @", zip.fileName, " ", end.point, sep="")
     
     # the command create the datastore "file.name" too
     # invoke the system call to curl.
     ret <- system2("curl", command.args, stdout=TRUE, stderr=TRUE)
     
     # remove files
     file.remove(paste(orig.wd,zip.fileName,sep="/"))
     file.remove(paste(orig.wd,layer.name,files,sep="/"))
     file.remove(paste(orig.wd,layer.name,sep="/"))
     
     return(ret) 
}