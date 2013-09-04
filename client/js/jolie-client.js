
var JolieClient = JolieClient || (function() {
    var API = {};
    var isError = function( data ) {
        if ( data['jolieFault'] ) {
            alert( data.jolieFault.faultName );
            return true;
        }
        return false;
    }
    
    var jolieCall = function( operation, request, callback, errorHandler ) {
        $.ajax({
               url: '/' + operation,
               dataType: 'json',
               data: JSON.stringify( request ),
               type: 'POST',
               contentType: 'application/json',
               success: function( data ){
               if ( isError( data ) ) {
               errorHandler( data.jolieFault );
               } else {
               callback( data );
               }
               },
               error:function(errorType, textStatus, errorThrown) {
               alert( errorThrown );
               }
               });
    }

    API.login = function( request, callback, errorHandler ) {
        jolieCall( "login", request, callback, errorHandler );
    }
    API.consumption = function( request, callback, errorHandler ) {
        jolieCall( "consumption", request, callback, errorHandler );
    }
    API.advice = function( request, callback, errorHandler ) {
        jolieCall( "advice", request, callback, errorHandler );
    }
    return API;
})();
