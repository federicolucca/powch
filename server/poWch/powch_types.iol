type LoginRequest: void {
	.username: string
	.password: string
}

type AuthToken: void {
	.token: string
}

type PointCountResponse: void {
	.count: int
}

type Contracts: void {
	.contracts*: Contract
}

type Contract: void {
	.id: string
	.label: string
	.users[1,*]: string
}

type ContractRequest: void {
	.id: string
	.token: string
}

type ConsumptionRequest: void {
	.contractData: ContractRequest
	.time?: void {
		.start: int
		.end?: int 
	}
}

type ConsumptionResponse: void {
	.startDate: string
	.data[1,*]: double
}