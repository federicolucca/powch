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
	.constracts[1,*]: Contract
}

type Contract: void {
	.id: string
	.label: string
	.users[1,*]: string
}