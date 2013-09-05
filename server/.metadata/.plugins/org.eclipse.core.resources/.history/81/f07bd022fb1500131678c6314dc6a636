include "console.iol"

execution { concurrent }

inputPort self {
	Location: "socket://localhost:8000"
	Protocol: sodep
	Interfaces: ProfileInterface
}

embedded {
	Jolie: "loginServer.ol" in loginService

main {
	[ getPointCount()(){}]{ nullProcess }
	[ getContracts()(){}]{ nullProcess }
}