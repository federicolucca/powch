include "console.iol"
include "powch_interfaces.iol"

outputPort Powch {
	Location: "socket://localhost:9000"
	Protocol: sodep
	Interfaces: LoginInterface
}

main {
	loginRequest.username = "mario rossi";
	loginRequest.password = "password";
	login@Powch( loginRequest )( authToken );
	println@Console( authToken.token )()
}