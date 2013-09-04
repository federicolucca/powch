include "BigLoadInterface.iol"
 
inputPort BigLoadService {
    Location: "socket://localhost:8002"
    Protocol: sodep
    Interfaces: BigLoadInterface
}
 
main
{
    buyModel( number )( result ) {
        result = number * 2
    }
}