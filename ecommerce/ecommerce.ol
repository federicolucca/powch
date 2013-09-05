include "console.iol"
include "SmallLoadInterface.iol"
include "MediumLoadInterface.iol"
include "BigLoadInterface.iol"
 
outputPort BigLoadService {
    Location: "socket://localhost:8002"
    Protocol: sodep
    Interfaces: BigLoadInterface
}

outputPort SmallLoadService {
    Location: "socket://localhost:8000"
    Protocol: sodep
    Interfaces: SmallLoadInterface
}

outputPort MediumLoadService {
    Location: "socket://localhost:8001"
    Protocol: sodep
    Interfaces: MediumLoadInterface
}
 
main
{
	buyModel@BigLoadService(5)( response );
    buyModel@SmallLoadService( response )( response );
    buyModel@MediumLoadService( response )( response );
    println@Console( response )()
}