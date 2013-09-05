include "console.iol"
include "powch_interfaces.iol"

execution { concurrent }

outputPort DataService {
	Interfaces: LoginInterface, ProfileInterface
}

inputPort self {
	Location: "socket://localhost:9000"
	Protocol: sodep
	Interfaces: PowchAdministrationInterface
	Aggregates: DataService
}

embedded {
	Jolie: "DataService.ol" in DataService
}

main {
	[ quit() ]{ EXIT }
}