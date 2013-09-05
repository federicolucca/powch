include "powch_types.iol"

interface ProfileInterface {
	RequestResponse: 
		getPointCount( AuthToken )( PointCountResponse ),
		getContracts( AuthToken )( Contracts )
}

interface ContractInterface {
	RequestResponse:
		getConsumption( ConsumptionRequest )( ConsumptionResponse ),
		getContractPointCount( ContractRequest )( PointCountResponse ),
		getSuggestion( ConsumptionRequest )( ConsumptionResponse ),
		getAdvices( AuthToken )( Messages ),
		getContractAdvices( ContractRequest )( Messages ),
		getChallenges( AuthToken )( Messages ),
		getContractChallenges( ContractRequest )( Messages )
}

interface PowchAdministrationInterface{
	OneWay: quit( void )
}

interface LoginInterface {
	OneWay:	register( LoginRequest )
	RequestResponse: 
		login( LoginRequest )( AuthToken ) throws LoginFault
}