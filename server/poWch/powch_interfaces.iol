include "powch_types.iol"

interface ProfileInterface {
	RequestResponse: 
		getPointCount( AuthToken )( PointCountResponse ),
		getContracts( AuthToken )( Contracts )
}

interface LoginInterface {
	OneWay:	register( LoginRequest )
	RequestResponse: 
		login( LoginRequest )( AuthToken )
}