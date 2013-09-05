include "console.iol"
include "powch_interfaces.iol"

execution { concurrent }

outputPort DataService {
	Interfaces: LoginInterface, ProfileInterface
}

inputPort self {
	Location: "local"
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