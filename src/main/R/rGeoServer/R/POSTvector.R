#' Posts a vector data image to a GeoServer 
#' @description Posts a vector data image to a GeoServer given an existing workspace and create the corresponding dataStore. 
#'
#' @param access.point, a character vector representing a GeoServer REST API access point
#' @param workspace, a character vector representing the GeoServer workspace 
#' @param data.store, a character vector representing the data store name
#' @param input a SpatialObjectDataFrame
#' @return charecter vector
#' @examples \dontrun{
#' POSTvector("http://localhost:8080/geoserver/rest", "WorkspaceRoadRiver", "RoadRiver", RoadRiver.SpatialDataFrameObj)
#' }
#'
#' @export
#' @import sp
#' @import rgdal

POSTvector <- function(access.point, workspace, data.store, input) {
     # store the current work directory
     orig.wd <- getwd()
     
     # save shapefile data
     writeOGR(input, data.store, data.store, driver="ESRI Shapefile")
     
     #get the shapefiles directory
     shapefiles.dir <- paste(orig.wd,data.store,sep="/")
     
     files <- list.files(shapefiles.dir, recursive = TRUE)
     setwd(shapefiles.dir)

     zip.fileName <- paste(data.store,"zip",sep=".")
     zip(paste("../" ,zip.fileName, sep=""), files)
     setwd(orig.wd)

     # build the command 
     end.point <- paste(access.point, "workspaces", workspace, "datastores", data.store, "file.shp", sep="/")
     command.args <- paste("-v -u '", geoserver.authn, "' -XPUT -H 'Content-type: application/zip' --data-binary @", zip.fileName, " ", end.point, sep="")
     
     # invoke the system call to curl.
     ret <- system2("curl", command.args, stdout=TRUE, stderr=TRUE)
     
     # remove files
     file.remove(paste(orig.wd,zip.fileName,sep="/"))
     file.remove(paste(orig.wd,data.store,files,sep="/"))
     file.remove(paste(orig.wd,data.store,sep="/"))
     
     return(ret) 
}