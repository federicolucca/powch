include "EcServerInterface.iol"
 
inputPort EcService {
    Location: "socket://localhost:9000"
    Protocol: sodep
    Interfaces: EcServerInterface
}
 
main
{
    twice( number )( result ) {
        result = number * 2
    }
}