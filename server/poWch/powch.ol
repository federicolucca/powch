include "console.iol"
include "powch_interfaces.iol"
include "DataServiceSurface.iol"

execution { concurrent }

outputPort DataService {
	Interfaces: selfSurface
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

init { println@Console("powch running")() }

main {
	[ quit() ]{ nullProcess }
}