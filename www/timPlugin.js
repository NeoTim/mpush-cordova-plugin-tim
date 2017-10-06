
var timPlugin = function(){
};

timPlugin.prototype.isPlatformIOS = function(){
	return device.platform == "iPhone" || device.platform == "iPad" || device.platform == "iPod touch" || device.platform == "iOS"
}

timPlugin.prototype.error_callback = function(msg){
	console.log("-==--=---= Callback Error: " + msg)
}

timPlugin.prototype.call_native = function(name, args, callback){

	ret = cordova.exec(callback,this.error_callback,'timPlugin',name,args);
	return ret;
}


timPlugin.prototype.setTags = function(data){

	try{
		this.call_native("setTags",data,null);
	}
	catch(exception){
		console.log(exception);
	}
}

timPlugin.prototype.deleteTags = function(data){
    try{
        this.call_native("deleteTags",data,null);
    }
    catch(exception){
        console.log(exception);
    }
}

timPlugin.prototype.setAlias = function(data){
	try{
		this.call_native("setAlias",[data],null);
	}
	catch(exception){
		console.log(exception);
	}
}

timPlugin.prototype.authSms = function(data){
    try{
        this.call_native("authSms",[data],null);
    }
    catch(exception){
        console.log(exception);
    }
}

timPlugin.prototype.addLocalNotification = function(options){
     try{
         var defaults = {
             title:'',
             message:'',
             action:[],
             extention:[],
             date:false
         };
         for (var key in defaults) {
             if (typeof options[key] !== "undefined") defaults[key] = options[key];
         }
         if (typeof defaults.date == 'object') {
             defaults.date = Math.round(defaults.date.getTime() / 1000);
         }

         this.call_native("addLocalNotification",[defaults]);
     }
    catch(exception){
        console.log(exception);
    }
}

timPlugin.prototype.cancelNotification = function(data){
     try{
          this.call_native("cancelNotification",data);
     }
    catch (exception){
        console.log(exception);
    }
}

timPlugin.prototype.cancelAllNotification = function(data){
    try{
        this.call_native("cancelAllNotification",data);
    }
    catch (exception){
        console.log(exception);
    }
}


timPlugin.prototype.receiveLocalNotificationCreatedCallback = function(data){
    try{
        console.log("timPlugin:receiveLocalNotificationCreatedCallback--NotificationId:"+data);
        console.log(data);
    }
    catch(exception){
        console.log("timPlugin:receiveLocalNotificationCreatedCallback"+exception);
    }
}

timPlugin.prototype.receiveVerificationCodeCallback = function(data){
    try{
        console.log("-==-=-----timPlugin:receiveVerificationCodeCallback--Verification Code:"+data);
        console.log(data);
    }
    catch(exception){
        console.log("-----==--timPlugin:receiveVerificationCodeCallback"+exception);
    }
}

timPlugin.prototype.receiveRemoteMessageForiOSCallback = function(data){
	try{
		console.log("---------timPlugin:receiveRemoteMessageForiOSCallback--data:"+data);
		var bToObj = JSON.parse(data);
		var content = bToObj.content;
    console.log(content);
	}
	catch(exception){
		console.log("========timPlugin:receiveRemoteMessageForiOSCallback"+exception);
	}
}

if(!window.plugins){
	window.plugins = {};
}

if(!window.plugins.mPushPlugin){
	window.plugins.mPushPlugin = new timPlugin();
}

module.exports = new timPlugin();
