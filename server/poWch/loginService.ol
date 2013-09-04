include "powch_interfaces.iol"
include "console.iol"
include "database.iol"

inputPort self {
	Location: "socket://localhost:8001"
	Protocol: sodep
	Interfaces: LoginInterface
}

constants {
  DatabaseDir = "./",
  DerbyLibDir = "./lib/derby.jar"
}


//execution { concurrent }

main {
	

define initDatabase
{
	i = 0;
	q.statement[i++] = "create table names (
		id integer generated always as identity primary key,
		name varchar(128) not null,
		domain varchar(128) not null,
		registry varchar(128) not null,
		resource_type varchar(128)
	)";

	q.statement[i++] = "create table registries (
		id integer generated always as identity primary key,
		domain varchar(128) not null,
		protocol varchar(128) not null,
		location varchar(128) not null,
		registry_type varchar(128)
	)";

	q.statement[i++] = "create table service_registry_domains (
		id integer generated always as identity primary key,
		domain varchar(128) not null
	)";
	executeTransaction@Database( q )()
}

init {
	if ( #args > 0 ) {
		settings_file_name = args[ 0 ]    
	} else {
		settings_file_name = SETTINGS_FILE
	};
	// reading settings file
	scope( settings ) {
		    install( FileNotFound => 
					     println@Console( PROMPT + settings_file_name + " does not exist, setting default values for working_dir (./database/file/) and database_dir (./database/)")();
					     DATABASE_DIR = "./database/";
					     WORKING_DIR = "./database/files/"
		    );

		    rq.filename = settings_file_name;
		    rq.format = "xml";
		    readFile@File( rq )( settings_file );
		    println@Console( PROMPT + settings_file_name + " read" )();
		    DATABASE_DIR = settings_file.settings.database_dir;
		    WORKING_DIR = settings_file.settings.working_dir
	};
	
	// connecting with the database
	loadLibrary@Runtime( DerbyLibDir )();
	scope( ConnectionScope ) {
	    install( IOException => println@Console( ConnectionScope.IOException.stackTrace )() );
	    install( ConnectionError => 
		    println@Console( PROMPT + "Database does not exists in " + DatabaseDir + ", creating a new database..." )();
		    connectionInfo.attributes = "create=true";
		    connect@Database( connectionInfo )();
		    initDatabase;
		    println@Console( PROMPT + "Database created" )()
	    );
	    with( connectionInfo ) {
		    .host = "";
		    .driver = "derby_embedded";
		    .port = 0;
		    .database = DatabaseDir;
		    .username = "";
		    .password = ""
	    };
	    connect@Database( connectionInfo )();
	    println@Console( PROMPT + "connection with " + connectionInfo.database + " done.")()
	}
	
//	[ register( loginRequest )]{ 
//		
//	}
//	[ login( loginRequest )( authToken ){
//		
//	}]{
//		
//	}
}