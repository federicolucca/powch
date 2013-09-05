include "powch_interfaces.iol"
include "console.iol"
include "string_utils.iol"
include "math.iol"

execution { concurrent }

inputPort self {
	Location: "local"
	Interfaces: LoginInterface, ProfileInterface,	ContractInterface
}

init {
	if ( !( global.first ) ){
		global.first=true;
		
		with ( global.users ){
			.("mario rossi").password = "password";
			.("mario rossi").token = new
		};
		
		with ( global.contracts ){
			.( "mario rossi" )[ #.( "mario rossi" ) ] = "ENEL010000";
			.( "mario rossi" )[ #.( "mario rossi" ) ] = "HERA148231"
		};
		
		with( global.contract ){
			with( .("ENEL010000") ){
				.label = "House";
				.users[ #.users ] = "mario rossi";
				.users[ #.users ] = "mario bianchi"
			};
			
			with( .( "HERA148231" ) ){
				.label = "Building";
				.users[ #.users ] = "mario rossi"
			}
			
		};
		
		with( global.points ){
			.( "mario rossi" ).( "HERA148231" ) = 12314;
			.( "mario rossi").("ENEL010000") = 52345
		};
		
		with( global.consumption ){
			for( i=0, i<12, i++){
				.("ENEL010000")[ i ].date = "20120" + (i+1);
				random@Math()( value );
				.("ENEL010000")[ i ].value = value*100
			};
			
			for( i=0, i<12, i++){
				.( "HERA148231" )[ i ].date = "20120" + (i+1);
				random@Math()( value );
				.( "HERA148231" )[ i ].value = value*100
			}
		};
		
		with( global.suggestion ){
			for( i=0, i<12, i++){
				.("ENEL010000")[ i ].date = "20120" + (i+1);
				random@Math()( value );
				.("ENEL010000")[ i ].value = value*75
			};
			
			for( i=0, i<12, i++){
				.( "HERA148231" )[ i ].date = "20120" + (i+1);
				random@Math()( value );
				.( "HERA148231" )[ i ].value = value*80
			}
		}
		
	}
}

define findUsernameByToken {
	foreach ( name : global.users ){
		if ( global.users.(name).token == _findUsernameByToken.token ){
			_findUsernameByToken.username = name
		}
	}
}

main {
	
	[ login( loginRequest )( authToken ){
		if( loginRequest.password == global.users.( loginRequest.username ).password ){
			authToken.token = global.users.(loginRequest.username).token
		} else {
			throw( LoginFault )
		}
	}]{ println@Console( "Successful login procedure for " + loginRequest.username )() }
	
	[ getPointCount( authToken )( pointCountResponse ){
		_findUsernameByToken.token = authToken.token;
		findUsernameByToken;
		foreach ( contract : global.points.( _findUsernameByToken.username ) ){
			pointCountResponse.count = pointCountResponse.count + 
				global.points.( _findUsernameByToken.username ).( contract )
		}
	}]{ nullProcess }
	
	[ getContracts( authToken )( response ){
		_findUsernameByToken.token = authToken.token;
		findUsernameByToken;
		username = _findUsernameByToken.username;
		for( i=0, i < #global.contracts.( username ), i++ ){
			contractID = global.contracts.( username )[ i ];
			response.contracts[ #response.contracts ].id = contractID;
			with ( response.contracts[ #response.contracts-1 ] ){
				.label = global.contract.( contractID ).label;
				.users << global.contract.( contractID ).users
			}
		}
	}]{ nullProcess }
	
	[ getConsumption( request )( response ){
		_findUsernameByToken.token = request.contractData.token;
		findUsernameByToken;
		if ( is_defined( _findUsernameByToken.username ) ) {
			consumptionData << global.consumption.( request.contractData.id );
			response.startDate = consumptionData[ 0 ].date;
			// TODO LIMIT FROM DATE TO DATE
			for( i=0, i < #consumptionData, i++ ){
				response.data[ i ] = consumptionData[ i ].value
			}
		}
	}]{ nullProcess }
	
		[ getSuggestion( request )( response ){
		_findUsernameByToken.token = request.contractData.token;
		findUsernameByToken;
		if ( is_defined( _findUsernameByToken.username ) ) {
			suggestionData << global.suggestion.( request.contractData.id );
			response.startDate = suggestionData[ 0 ].date;
			// TODO LIMIT FROM DATE TO DATE
			for( i=0, i < #suggestionData, i++ ){
				response.data[ i ] = suggestionData[ i ].value
			}
		}
	}]{ nullProcess }
	
	[ getContractPointCount( request )( response ){
		_findUsernameByToken.token = request.token;
		findUsernameByToken;
		response.count = global.points.( _findUsernameByToken.username ).( request.id )
	}]{ nullProcess }
	
}