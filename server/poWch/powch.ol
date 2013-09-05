include "console.iol"
include "powch_interfaces.iol"

execution { concurrent }

outputPort DataService {
	Interfaces: LoginInterface, ProfileInterface, ContractInterface
}

inputPort self {
	Location: "local"
	Interfaces: PowchAdministrationInterface
	Aggregates: DataService
}

embedded {
	Jolie: "DataService.ol" in DataService
}

init { println@Console("powch running")() }

main {
	[ quit() ]{ nullProcess }
}