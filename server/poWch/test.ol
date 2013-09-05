include "console.iol"
include "powch_interfaces.iol"
include "string_utils.iol"

outputPort Powch {
	Location: "socket://localhost:9000"
	Protocol: sodep
	Interfaces: LoginInterface, ProfileInterface, ContractInterface
}

main {
	loginRequest.username = "mario rossi";
	loginRequest.password = "password";
	login@Powch( loginRequest )( authToken );
	println@Console( authToken.token )();
	getPointCount@Powch( authToken )( pointCount );
	println@Console( "pointCount: " + pointCount.count  )();
	getContracts@Powch( authToken )( contracts );
	valueToPrettyString@StringUtils( contracts )( prettyValue );
	println@Console( prettyValue )();
	// picking the first contract
	consumptionRequest.contractData.id = contracts.contracts[ 0 ].id; 
	contractPointCountRequest.id = contracts.contracts[ 0 ].id;
	contractPointCountRequest.token = authToken.token;
	
	getContractPointCount@Powch( contractPointCountRequest )( pointCount );
	println@Console( "contractPointCount for " + contractPointCountRequest.id + ":" + 
		pointCount.count )();
	
	consumptionRequest.contractData.token = authToken.token;
	getConsumption@Powch( consumptionRequest )( consumptionResponse );
	valueToPrettyString@StringUtils( consumptionResponse )( prettyValue );
	println@Console( prettyValue )();
	
	suggestionRequest.contractData.token = authToken.token;
	suggestionRequest.contractData.id = consumptionRequest.contractData.id;
	getSuggestion@Powch( suggestionRequest )( suggestionResponse );
	valueToPrettyString@StringUtils( suggestionResponse )( prettyValue );
	println@Console( prettyValue )()
	
}