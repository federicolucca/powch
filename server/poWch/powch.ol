include "console.iol"
include "powch_interfaces.iol"

execution { concurrent }

outputPort LoginService {
	Interfaces: LoginInterface
}

inputPort self {
	Location: "socket://localhost:9000"
	Protocol: sodep
	Interfaces: ProfileInterface
	Aggregates: LoginService
}

embedded {
	Jolie: "loginService.ol" in LoginService
}

main {
	[ getPointCount()(){ nullProcess }]{ nullProcess }
	[ getContracts()(){ nullProcess }]{ nullProcess }
}