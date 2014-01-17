(function () {
    var textarea = document.getElementById('message');
    if (textarea) document.getElementById('send-message').onclick = function () {
		if(!textarea.value.length || textarea.value.length < 50)
		{
		    alert('Too short message. Please type a real message. If possible include your email too. Thanks.');
		    textarea.focus();
			return;
		}

		this.disabled = true;
		
        var element = this;
        element.style.color = 'gray';
        element.innerHTML = 'Sending...';

        window.messenger && messenger.deliver(textarea.value, function () {
            element.style.color = 'white';
            textarea.value = '';
            element.innerHTML = 'Send Message';
            element.disabled = false;
            alert('You message has been delivered successfully. Hope you included your email address in the message. Thanks.');
        });
    };
})();

setTimeout(function () {
    var s = document.getElementsByTagName('script')[0];

    var script = document.createElement('script');
    script.async = true;
    script.src = 'https://apis.google.com/js/plusone.js';
    s.parentNode.insertBefore(script, s);

    script = document.createElement('script');
    script.async = true;
    script.src = 'https://webrtc-experiment.appspot.com/dependencies/messenger.js';
    s.parentNode.insertBefore(script, s);
}, 3000);