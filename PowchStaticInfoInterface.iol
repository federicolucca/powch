type Device: void {
    .name: string
    .class: string
    .serialCode: string
}

type Challenge: void {
    .name: string
    .publicationDate: string
    .pointsToGain: 
}

type GetStaticInfosRequest: void {
    .access_token: string
}

type GetStaticInfosResponse: void {
    .title: string
    .points: int
    .ecContract: void {
	.companyName: string
	.contractCode: string
	.url: string
    }
    .deviceList*: Device
    .acceptedChallenges: Challenge
    
}

interface PowchStaticInfoInterface {
RequestResponse:
    getStaicInfos( GetStaticInfosRequest )( GetStaticInfosResponse )
}



type GetActiveChallengesRequest: void 



interface PAInterface {
RequestResponse:
    getActiveChallenges( GetActiveChallengesRequest )( GetActiveChallengesResponse )
}