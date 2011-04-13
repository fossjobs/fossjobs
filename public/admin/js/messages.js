(function() {
	jobberBase.messages = function() {
		var el, timer = false, queued = 0;
		var clearQueue = function() {
			queued --;
			if (el.firstChild) {
				el.removeChild(el.firstChild);
			}
			if (queued == 0) {
				clearInterval(timer);
				timer = false;
			}
		};
		return {
			init: function() {
				el = document.getElementById('messagesContainer');
			},
			add: function(txt) {
				queued ++;
				el.appendChild(document.createElement('div'));
				el.lastChild.innerHTML = txt;
				if (timer == false) {
					timer = setInterval(clearQueue, 2000);
				}
			}
		};
	}();
	jobberBase.register(jobberBase.messages.init, 'init');
})();