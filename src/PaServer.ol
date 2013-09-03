include "PaServerInterface.iol"
 
inputPort PaService {
    Location: "socket://localhost:8000"
    Protocol: sodep
    Interfaces: PaServerInterface
}
 
main
{
    twice( number )( result ) {
        result = number * 2
    }
}