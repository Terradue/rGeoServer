#' Posts a point data image to a GeoServer 
#' @description Posts a point data image to a GeoServer given an existing workspace and create the corresponding dataStore. 
#'
#' @param access.point, a character vector representing a GeoServer REST API access point
#' @param workspace, a character vector representing the GeoServer workspace 
#' @return boolean value (TRUE if workspace existes, FALSE otherwise)
#' @examples \dontrun{
#' checkWorkspace("http://localhost:8080/geoserver/rest", "WorkspaceTest")
#' }
#'

checkWorkspace <- function(access.point, workspace) {
    
    # NOTE (http://docs.geoserver.org/stable/en/user/rest/examples/curl.html#Adding-a-new-workspace):
	# The Accept header is optional. The following request omits the Accept header, but will return the same response as above.
	# curl -v -u admin:geoserver -XGET http://localhost:8080/geoserver/rest/workspaces/acme.xml
	# the function doesn't check the xml file, but try to find the "404 not found" string

	workspace.found <- TRUE

	# build the command 
	end.point <- paste(access.point, "workspaces", paste(workspace,"xml",sep="."), sep="/")
	command.args <- paste("-v -u '", geoserver.authn, "' -XGET ", end.point, sep="")

	# invoke the system call to curl.
	ret <- tolower(system2("curl", command.args, stdout=TRUE, stderr=TRUE))

	# get a list of results, a result for each response line
	response.list <- !grepl("404 not found", ret)

	for(i in 1:length(response.list)){
		workspace.found <- workspace.found & response.list[i]
	}

	return(workspace.found)
}