include "console.iol"
include "powch_interfaces.iol"

execution { concurrent }

outputPort DataService {
	Interfaces: LoginInterface, ProfileInterface, ContractInterface
}

inputPort self {
<<<<<<< HEAD
	Location: local
=======
	Location: "local"
>>>>>>> de09d29ef508a4bb76921d4f56f8d78fceba3d85
	Protocol: sodep
	Interfaces: PowchAdministrationInterface
	Aggregates: DataService
}

embedded {
	Jolie: "DataService.ol" in DataService
}

main {
	[ quit() ]{ nullProcess }
}