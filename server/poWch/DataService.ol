include "powch_interfaces.iol"
include "console.iol"
include "string_utils.iol"

execution { concurrent }

inputPort self {
	Location: "local"
	Interfaces: LoginInterface, ProfileInterface
}


init {
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
		.( "mario rossi" ).count = 12314
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
		pointCountResponse.count = global.points.( _findUsernameByToken.username ).count
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
	
}