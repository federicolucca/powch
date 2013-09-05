type LoginRequest:void{
	.username[1,1]:string
	.password[1,1]:string
}

type AuthToken:void{
	.token[1,1]:string
}
type PointCountResponse:void{
	.count[1,1]:int
}
type Contracts:void{
	.contracts[0,*]:Contract
}
type ConsumptionRequest:void{
	.time[0,1]:void{ 
		.start[1,1]:int
		.end[0,1]:int
	}
	.contractData[1,1]:ContractRequest
}
type ConsumptionResponse:void{
	.startDate[1,1]:string
	.data[1,*]:double
}
type Messages:void{
	.message[0,*]:Message
}
type ContractRequest:void{
	.id[1,1]:string
	.token[1,1]:string
}

type Contract:void{
	.id[1,1]:string
	.users[1,*]:string
	.label[1,1]:string
}
type Message:void{
	.content[1,1]:string
	.title[1,1]:string
}

interface selfSurface {
OneWay:
	register( LoginRequest )
RequestResponse:
	login( LoginRequest )( AuthToken ) throws LoginFault( undefined ),
	getPointCount( AuthToken )( PointCountResponse ),
	getContracts( AuthToken )( Contracts ),
	getConsumption( ConsumptionRequest )( ConsumptionResponse ),
	getChallenges( AuthToken )( Messages ),
	getContractPointCount( ContractRequest )( PointCountResponse ),
	getSuggestion( ConsumptionRequest )( ConsumptionResponse ),
	getContractChallenges( ContractRequest )( Messages ),
	getAdvices( AuthToken )( Messages ),
	getContractAdvices( ContractRequest )( Messages )
}

outputPort self{
	Location:"local"
	Protocol:sodep
	Interfaces:selfSurface
}
