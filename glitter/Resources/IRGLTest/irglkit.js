//	IRGLKit Prototype
//	Definitely not production quality

//	Evadne Wu @ Iridia Productions
//	ev@iridia.tw

window.irgl = ((function(){
	
	//	I don’t have any clue why we need a global object
	//	but this might work.
	
	var irgl = {};
	irgl.invoke = function(){
		
		window.console.log(arguments);
		
	};
	
	irgl.wrap = function (jqElement) {
		
		jqElement.bind("focus", function (event) {
		
			event.preventDefault();
			$(this).blur();
			
			irgl.callback(":D");
		
		});
		
	};
	
	irgl.callback = function (string) {
	
		var encodedArray = [];
		for (var i = 0; i < arguments.length; i++)
			encodedArray.push(arguments[i]);
		
		irgl.punt(JSON.stringify(encodedArray));
	
	};
	
	irgl.punt = function (wrappedJSON) {
	
/*
		if (console && console.log)
			console.log("Do something with JSON: " + wrappedJSON);
		else
*/
			alert("Do something with JSON: " + wrappedJSON);
	
	};
	
	return irgl;
	
})());


$(document).ready(function(){

	$("input[type*='qrcode']").each(function() {
		irgl.wrap($(this));
	});
	
});
