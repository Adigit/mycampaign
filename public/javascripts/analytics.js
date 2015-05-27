/*function SetJSONCookie(key, value){
    document.cookie = key+"="+value;
}
function GetJSONCookie(key){
    var result = document.cookie.match(new RegExp(key + '=([^;]+)'));
    if (result == null){
    	return "";
    }
    return result[1];
}
var browering_urls = {};
function get_id_or_fingerprint () {
	var id = GetJSONCookie('u_id');
	if (id == ""){
		return fingerprint;
	}
	return id;
}
var fingerprint = new Fingerprint().get();
function should_be_inserted(val){
	for (var i = 0; i < browering_urls.length; i++) {
		if (browering_urls[i] == val) {
			return false;
		}
	};
	return true;
}
function get_browsering_data(){
	var url = document.URL;
	if (browering_urls[url] == undefined){
		browering_urls[url] = 0;
	}
	else{
		browering_urls[url] += 100;	
	}
	
}
setInterval(get_browsering_data, 500);
var inFormOrLink;
$('a').on('click', function() { inFormOrLink = true; });
$('form').on('submit', function() { inFormOrLink = true; });

$(window).on("beforeunload", function() { 
	update_cookie();
    return inFormOrLink ? "Do you really want to close?" : null; 
})

function update_cookie () {
	var id = get_id_or_fingerprint();
	val = GetJSONCookie(id);
	console.log(val);
	if (val != ""){
		console.log("inside if")
		val = val + JSON.stringify(browering_urls);
	}
	else{
		console.log("else condition");
		val = JSON.stringify(browering_urls);
	}
	SetJSONCookie(id, val);
}
*/
/*
var idleTime = 0;
$(document).ready(function () {
    //Increment the idle time counter every minute.
    var idleInterval = setInterval(timerIncrement, 60000); // 1 minute

    //Zero the idle timer on mouse movement.
    $(this).mousemove(function (e) {
        idleTime = 0;
    });
    $(this).keypress(function (e) {
        idleTime = 0;
    });
});

function timerIncrement() {
    idleTime = idleTime + 1;
    if (idleTime > 19) { // 20 minutes
        window.location.reload();
    }
}
*/
/*
var validNavigation = 0;
 
function endSession() 
{
   // Browser or Broswer tab is closed
   // Write code here
   alert('Browser or Broswer tab closed');
}
 
// Attach the event keypress to exclude the F5 refresh
$(document).keydown(function(e)
{
   var key=e.which || e.keyCode;
   console.log(key);
   if (key == 116)
   {
     validNavigation = 1;
   }
});

// Attach the event click for all links in the page
$("a").bind("click", function() 
{
   validNavigation = 1;
});
 
 // Attach the event submit for all forms in the page
 $("form").bind("submit", function() 
{
   validNavigation = 1;
});
 
 // Attach the event click for all inputs in the page
$("input[type=submit]").bind("click", function() 
{
   validNavigation = 1;
});


$(window).unload(function() 
{
   if (validNavigation==0) 
   {
     endSession();
   }
});
*/
function detectRefresh(){
 try
 {
   if(window.opener == undefined){
 isRefresh = true;
 console.log('Window was refreshed!');
   }
 }
 catch(err)
 {
 isRefresh = false;
 //console.log('Window was closed!');
 //alert("bbjcv");
 return true ? "Do you really want to close?" : null; 
 } 
 }

$(window).on("beforeunload", function() { 
//	update_cookie();
detectRefresh();
    //return (validNavigation==0 )? "Do you really want to close?" : null; 
  //alert("before unload");
  
   	//return (validNavigation==0 )? "Do you really want tonncv close?" : null; 
  
}); 
