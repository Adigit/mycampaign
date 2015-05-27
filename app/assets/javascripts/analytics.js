function SetJSONCookie(key, value){
    document.cookie = key+"="+JSON.stringify(value);
}
function GetJSONCookie(key){
    var result = document.cookie.match(new RegExp(key + '=([^;]+)'));
    return result[1];
}
var browering_urls = {};
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
	SetJSONCookie(fingerprint, browering_urls);
}
setInterval(get_browsering_data, 100);
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
