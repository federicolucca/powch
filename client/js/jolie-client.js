
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
    API.getConsumption = function( request, callback, errorHandler ) {
        jolieCall( "getConsumption", request, callback, errorHandler );
    }
    API.getSuggestion = function( request, callback, errorHandler ) {
        jolieCall( "getSuggestion", request, callback, errorHandler );
    }
    API.getAdvice = function( request, callback, errorHandler ) {
        jolieCall( "getAdvice", request, callback, errorHandler );
    }
    API.getPointCount = function( request, callback, errorHandler ) {
        jolieCall( "getPointCount", request, callback, errorHandler );
    }
    API.getContracts = function( request, callback, errorHandler ) {
        jolieCall( "getContracts", request, callback, errorHandler );
    }
    return API;
})();
