interface ProfileInterface {
	RequestResponse: 
		getPointCount( AuthToken )( PointCountResponse ),
		getContracts( AuthToken )( Contracts )
}

interface LoginInterface {
	OneWay:	register( UserRegistration )
	RequestResponse: 
		login( LoginRequest )( AuthToken )
}