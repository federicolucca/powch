include "console.iol"
include "EcServerInterface.iol"
include "PaServerInterface.iol"
include "PlugDeviceInterface.iol"
 
outputPort EcService {
    Location: "socket://localhost:9000"
    Protocol: sodep
    Interfaces: EcServerInterface
}

outputPort PaService {
    Location: "socket://localhost:8000"
    Protocol: sodep
    Interfaces: PaServerInterface
}

outputPort PlugService {
    Location: "socket://localhost:10000"
    Protocol: sodep
    Interfaces: PlugDeviceInterface
}
 
main
{
	getLoadNow@PlugService()( response );
    twice@EcService( response )( response );
    twice@PaService( response )( response );
    println@Console( response )()
}