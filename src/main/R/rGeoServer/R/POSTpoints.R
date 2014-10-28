#' Posts a point data image to a GeoServer 
#' @description Posts a point data image to a GeoServer given an existing workspace and create the corresponding dataStore. 
#'
#' @param access.point, a character vector representing a GeoServer REST API access point
#' @param workspace, a character vector representing the GeoServer workspace 
#' @param data.store, a character vector representing the data store name
#' @param input a SpatialPointsDataFrame
#' @return charecter vector
#' @examples \dontrun{
#' POSTpoints("http://localhost:8080/geoserver/rest", "WorkspacePointTest", "PointTest", PointTest.SpatialPointsDataFrame)
#' }
#'
#' @export
#' @import sp
POSTpoints <- function(access.point, workspace, data.store, input) {

	if( tolower(class(input)[1]) != "spatialpointsdataframe" ){
		stop(paste("SpatialPointsDataFrame input object expected.", class(input), "object found"))
	}

	if(checkWorkspace(access.point, workspace)){
		ret<-POSTvector(access.point, workspace, data.store, input)
	}
	else{
		stop(paste("Workspace",workspace,"doesn't exist on the GeoServer"))	
	}
	return(ret)
}