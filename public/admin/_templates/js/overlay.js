(function() {
	jobberBase.overlay = function() {
		var el;
		return {
			init: function() {
				el = document.getElementById('overlay');
				jobberBase.overlay.hide();
			},
			show: function(elTo) {
				if (!elTo) {
					return;
				}
				var sz = $(elTo).offset();
				el.style.top = sz.top + 'px';
				el.style.left = sz.left + 'px';
				el.style.width = elTo.offsetWidth + 'px';
				el.style.height = elTo.offsetHeight + 'px';
				el.style.display = 'block';
			},
			hide: function() {
				el.style.display = 'none';
			}
		};
	}();
	jobberBase.register(jobberBase.overlay.init, 'init');
})();