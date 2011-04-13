(function() {
	jobberBase.links = function() {
		var linkTemplate = [
			'<div class="linkItem">',
				'<div class="linkHandle"></div>',
				'<div class="linkWrapper">',
					'<a href="#" title="Delete this link" class="deleteLink"><img src="',
					'',
					'_templates/img/bin.png" alt="Delete" /></a>',
					'<label><span>Name:</span><input type="text" size="60" name="name[]" value="For example: Jobberbase" /><img class="help" src="../../_templates/img/information-balloon.png" title="The text you want to display in the frontend" /></label>',
					'<a href="#" title="Save changes" class="saveLink"><img src="',
					'',
					'_templates/img/disk.png" alt="Save" /></a>',
					'<label><span>URL:</span><input type="text" size="60" name="url[]" value="For example: http://www.jobberbase.com/" /><img class="help" src="../../_templates/img/information-balloon.png" title="The URL you want to link to. When you want to link to a Jobberbase page (e.g. the page Contact) you can use the Jobberbase URL (e.g. contact)" /></label>',
					'<label><span>Title:</span><input type="text" size="60" name="title[]" value="For example: Open Source Job Board Software" /><img class="help" src="../../_templates/img/information-balloon.png" title="Text that shows when you hover over the link, just like this help message. You can leave this blank if you don\'t want to show anything" /></label>',
				'</div>',
			'</div>'
		];
		var pointerPosition;
		var prevPointer;
		var minTop;
		var maxTop
		var currentEl;
		var elOrigPrev;
		var elOrigNext;
		var fieldOrigValue;
		var items;
		var saving = false;
		var mouseDown = function(e) {
			if ($(e.target).is('div.linkHandle') && saving == false) {
				currentEl = $(e.target.parentNode)
								.fadeTo(500, 0.4)
								.addClass('draggingItem')
								.get(0);
				elOrigPrev = currentEl.previousSibling;
				elOrigNext = currentEl.nextSibling;
				pointerPosition = e.pageY;
				minTop = -currentEl.offsetTop;
				maxTop = document.getElementById('linksContainer').offsetHeight - currentEl.offsetHeight + minTop;
				items = $('#linksContainer div.linkItem');
				$(document)
					.bind('mousemove', mouseMove)
					.bind('mouseup', mouseUp);
				return false;
			}
		};
		
		var mouseMove = function(e) {
			var newTop = Math.max(minTop,Math.min(maxTop, e.pageY - pointerPosition));
			var absTop = e.pageY - pointerPosition - minTop;
			currentEl.style.top = newTop + 'px';
			items.each(function(nr){
				if (this != currentEl) {
					var overlap = (absTop - this.offsetTop)/this.offsetHeight;
					if (overlap > 0 && overlap < 1) {
						var oldTop = minTop;
						minTop = -this.offsetTop;
						maxTop = document.getElementById('linksContainer').offsetHeight - currentEl.offsetHeight + minTop;
						if (e.pageY > prevPointer) {
							$(this).after(currentEl);
						} else {
							$(this).before(currentEl);
						}
						pointerPosition = pointerPosition  + oldTop - minTop;
						return false;
					}
				}
			});
			prevPointer = e.pageY;
			return false;
		};
		
		var mouseUp = function(e) {
			$(document)
				.unbind('mousemove', mouseMove)
				.unbind('mouseup', mouseUp);
			$(currentEl)
				.fadeTo(500,1)
				.css('top', '0')
				.removeClass('draggingItem');
			if (currentEl.nextSibling != elOrigNext ||  currentEl.previousSibling != elOrigPrev) {
				jobberBase.messages.add('Link order changed. Saving ...');
				saving = true;
				jobberBase.overlay.show(document.getElementById('linksContainer'));
				var order = [];
				$('#linksContainer div.linkItem')
					.each(function(nr){
						order.push($(this).attr('rel'));
					});
				$.ajax({
					type: 'post',
					url: Jobber.jobber_admin_url + 'links/',
					data: {
						action: 'saveOrder',
						order: order.join(',')
					},
					complete: function(){
						jobberBase.overlay.hide();
						saving = false;
					}
				});
			}
			currentEl = elOrigPrev = elOrigNext = null;
			return false;
		};
		
		var mouseClick = function(e) {
			var el = $(e.target).is('img')? e.target.parentNode : e.target;
			if ($(el).is('a.deleteLink')) {
				if (confirm('Are you sure you want to delete this link?')) {
					jobberBase.overlay.show(el.parentNode.parentNode);
					saving = true;
					$.ajax({
						type: 'post',
						dataType: 'text',
						url: Jobber.jobber_admin_url + 'links/',
						data: {
							action: 'deleteLink',
							link: $(el).parent().parent().attr('rel')
						},
						success: function(responseText) {
							if (typeof responseText == 'string' && responseText.length > 0) {
								alert(responseText);
							} else {
								$(el)
									.parent()
									.parent()
									.fadeOut(
										500, 
										function(){
											$(this).remove()
										}
									);
								jobberBase.messages.add('Link has been deleted');
							}
						},
						complete: function(){
							jobberBase.overlay.hide();
							saving = false;
						}
					});
					this.blur();
					return false;
				}
			} else if ($(el).is('a.saveLink')) {
				jobberBase.overlay.show(el.parentNode.parentNode);
				saving = true;
				$.ajax({
					type: 'post',
					dataType: 'text',
					url: Jobber.jobber_admin_url + 'links/',
					data: {
						action: 'saveLink',
						link: $(el).parent().parent().attr('rel'),
						name: $(el).parent().find('input:first').val(),
						url: $(el).parent().find('input:eq(1)').val(),
						title: $(el).parent().find('input:eq(2)').val()
					},
					success: function() {
						jobberBase.messages.add('Link has been saved');
						$(el).hide();
					},
					complete: function(){
						jobberBase.overlay.hide();
						saving = false;
					}
				});
				this.blur();
				return false;
			}
		};
		
		var inputFocus = function(e) {
			fieldOrigValue = this.value;
		};
		
		var inputBlur = function(e) {
			if (this.value != fieldOrigValue) {
				$(this)
					.parent()
					.parent()
					.find('a:last')
						.fadeIn(500);
						
				jobberBase.messages.add('Value changed. You must save the change!');
			}
		};
		
		var add = function(e) {
			this.blur();
			if (saving === true) {
				return false;
			}
			linkTemplate[4] = Jobber.jobber_admin_url;
			linkTemplate[8] = Jobber.jobber_admin_url;
			var el = $('#linksContainer')
					.append(linkTemplate.join(''))
					.find('div.linkItem:last')
						.find('input')
							.bind('focus', inputFocus)
							.bind('blur', inputBlur)
							.end()
						.hide()
						.fadeIn(500)
						.get(0);
			jobberBase.overlay.show(el);
			
			$.ajax({
				type: 'post',
				dataType: 'text',
				url: document.location.href,
				data: {
					action: 'newLink'
				},
				success: function(id) {
					$(el)
						.attr('rel', id)
						.find('input:first')
							.attr('name', 'name' + id)
							.end()
						.find('input:eq(1)')
					        .attr('name', 'url' + id )
					        .end()
					    .find('input:eq(2)')
					        .attr('name', 'title' + id )
					        .end()
				},
				complete: function(){
					jobberBase.overlay.hide();
					saving = false;
				}
			});
			return false;
		};
		return {
			init: function(){
				if (document.getElementById('linksContainer')) {
					$('#linksContainer')
						.bind('mousedown', mouseDown)
						.bind('click', mouseClick)
						.find('input')
							.bind('focus', inputFocus)
							.bind('blur', inputBlur)
							.end()
						.next()
						.next()
						.find('a:first')
							.bind('click', add);
				}
			}
		};
	}();
	jobberBase.register(jobberBase.links.init, 'init');
})();