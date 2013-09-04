include "MediumLoadInterface.iol"
include "PowchStaticInfoInterface.iol"
 
inputPort MediumLoadService {
    Location: "socket://localhost:8001"
    Protocol: sodep
    Interfaces: MediumLoadInterface
}
 
main
{
	//devices*

	devices[0].name="tv"
	devices[0].class="A+"
	devices[0].serialcode="1234567890"

    buyModel( number )( result ) {
        result = devices[0]
    }
}