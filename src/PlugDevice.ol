include "PlugDeviceInterface.iol"
 
inputPort PlugService {
    Location: "socket://localhost:10000"
    Protocol: sodep
    Interfaces: PlugDeviceInterface
}
 
main
{
    getLoadNow( void )( result ) {
        result = 3 * 2
    }
}