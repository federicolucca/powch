include "console.iol"
include "powch_interfaces.iol"
include "string_utils.iol"

outputPort Powch {
	Location: "socket://localhost:9000"
	Protocol: sodep
	Interfaces: LoginInterface, ProfileInterface
}

main {
	loginRequest.username = "mario rossi";
	loginRequest.password = "password";
	login@Powch( loginRequest )( authToken );
	println@Console( authToken.token )();
	getPointCount@Powch( authToken )( pointCount );
	println@Console( "pointCount: " + pointCount.count  )();
	getContracts@Powch( authToken )( contracts );
	valueToPrettyString@StringUtils( contracts)( prettyValue );
	println@Console( prettyValue )()
}