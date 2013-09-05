include "powch_interfaces.iol"
include "console.iol"

execution { concurrent }

inputPort self {
	Location: "local"
	Interfaces: LoginInterface, ProfileInterface
}


init {
	with ( global.users ){
		.("mario rossi").password = "password";
		.("mario rossi").token = "blablabla"
	};
	
	with ( global.contracts ){
		.("mario rossi")[ #.( "mario rossi" ) ] = "ENEL010000";
		.("mario rossi")[ #.( "mario rossi") ] = "HERA148231";
		.( "mario rossi")[ #.( "mario rossi" )] = "ENELENERGIA173123"
	};
	
	with( global.contract ){
		.( "ENEL010000" ).label = "House";
		.( "HERA148231" ).label = "Building";
		.( "ENELENERGIA173123000" ).label = "Garden"
	};
	
	with( global.points ){
		.( "mario rossi" ).count = 12314
	}
}

define findUsernameByToken {
	foreach ( name : global.users ){
		if ( global.users.( name ).token == _findUsernameByToken.token ){
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
		println@Console( _findUsernameByToken.username )();
		pointCountResponse.count = global.points.( _findUsernameByToken.username ).count;
		println@Console( pointCountResponse.count )()
	}]{ nullProcess }
	
}