(function(){
	var jobberBase = window.jobberBase = function () {
		var _registered = {};
		return {
			init: function() {
				if (_registered.init) {
					$.each(_registered.init, function(nr, fn){
						fn.call();
					});
				}
			},
			extend: function(prop) {
				for (var i in prop) {
					if (prop[i] != undefined) {
						this[i] = prop[i];
					}
				}
			},
			register: function(fn, type) {
				if (!_registered[type]) {
					_registered[type] = [];
				}
				_registered[type].push(fn);
			},
			template: function(tpl, callback) {
				return tpl.replace(/\{([\w-]+)(?:\:([\w\.]*)(?:\((.*?)?\))?)?\}/g, callback);
			},
			insertLink: function(path, text) {
				if (typeof tinyMCE != 'object') {
					return;
				}
				var inst = tinyMCE.selectedInstance;
				inst.contentWindow.focus();
				
				var elm = inst.selection.getNode();
				elm = inst.dom.getParent(elm, "A");
				inst.execCommand('mceBeginUndoLevel');
				var sel = inst.selection.getContent();
				if (elm == null) {
					if (sel != '') {
						inst.execCommand('mceInsertLink',text, path);
					} else {
						tinyMCE.execCommand(
							"mceInsertContent",
							false,
							' <a href="' + path + '">' + text + '</a> '
						);
					}
				} else {
					elm.setAttribute('href',path);
					elm.setAttribute('mce_href',path);
				}
				try {
					inst.selection.collapse(false);
				} catch (ex) {
				}
				inst.execCommand("mceEndUndoLevel");
			}
			,
			deleteCity: function(url, cityID)
			{
				if(confirm('Are you sure you want to delete this city?'))
				{
					$.ajax({
					  type: "POST",
					  url: url,
					  data: "cityID=" + cityID,
					  success: function(msg) {
					   	if (msg != "0")
						{
							var cityElementID = 'item'+cityID;
							$("#"+cityElementID).remove();
						}
					   	else
					   		alert('There was a problem deleting the city!')
					  }
					});
				}
			}
		}
	}();
	$(jobberBase.init);
})();