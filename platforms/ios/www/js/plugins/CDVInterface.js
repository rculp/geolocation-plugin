//
//  CDVInterface.js
//
//
//  Created by Stas Gorodnichenko on 20/08/13.
//  MIT Licensed
//

var successCallBackFunction,
    errorCallBackFunction,
    successCallBackName = 'yourCallBack',
    errorCallBackName = 'yourErrorCallBack',
    CDVInterface = {
    
start: function( callbackSuccess , callbackError ) {
    if ( typeof callbackSuccess === 'function' ) {
        
        if ( callbackSuccess.name === '' ) {
            successCallBackFunction = function( result ) { callbackSuccess(result); };
        } else {
            successCallBackName = callbackSuccess.name;
        }
        
        
        if ( ( typeof callbackError === 'function') ) {
            if (  callbackError.name === '') {
                errorCallBackFunction = function( result ) { callbackError(result); };
            } else {
                errorCallBackName = callbackError.name;
            }
        }
        
        cordova.exec( null, callbackError, "CDVInterface", "start", [{
                                                                         "dcsUrl": "http://devcycle.se.rit.edu/",
                                                                         "startTime": 1391526000,
                                                                         "endTime": 11398434400,
                                                                         "tourId": "sussex",
                                                                         "riderId": "TcH4FR09ROSA4b42WJX6i1J8mQf+44faAOl9A5RZHcQ="
                                                                     }]
        );
    } else {
        callbackError.call({ message: 'invalid signature of the success callback function' });
    }
},
        
resumeTracking: function(callbackSuccess, callbackError){
    cordova.exec( callbackStop, callbackError, "CDVInterface", "resumeTracking", [] );
},
    
pauseTracking: function( callbackStop, callbackError ) {
    cordova.exec( callbackStop, callbackError, "CDVInterface", "pauseTracking", [] );
}
    
};