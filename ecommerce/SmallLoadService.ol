include "SmallLoadInterface.iol"
 
inputPort SmallLoadService {
    Location: "socket://localhost:8000"
    Protocol: sodep
    Interfaces: SmallLoadInterface
}
 
main
{
    buyModel( number )( result ) {
        result = number * 2
    }
}