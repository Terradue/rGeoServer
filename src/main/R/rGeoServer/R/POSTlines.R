#' Posts a line data image to a GeoServer 
#' @description Posts a line data image to a GeoServer given an existing workspace and create the corresponding dataStore. 
#'
#' @param access.point, a character vector representing a GeoServer REST API access point
#' @param workspace, a character vector representing the GeoServer workspace 
#' @param data.store, a character vector representing the data store name
#' @param input a SpatialLinesDataFrame
#' @return charecter vector
#' @examples \dontrun{
#' POSTlines("http://localhost:8080/geoserver/rest", "WorkspaceLineTest", "LineTest", LineTest.SpatialLinesDataFrame)
#' }
#'
#' @export
#' @import sp
POSTlines <- function(access.point, workspace, data.store, input) {

	if( tolower(class(input)[1]) != "spatiallinesdataframe" ){
		stop(paste("SpatialLinesDataFrame input object expected.", class(input), "object found"))
	}

	if(checkWorkspace(access.point, workspace)){
		ret<-POSTvector(access.point, workspace, data.store, input)
	}
	else{
		stop(paste("Workspace",workspace,"doesn't exist on the GeoServer"))	
	}
	return(ret)
}