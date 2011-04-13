(function() {
	jobberBase.categories = function() {
		var categoryTemplate = [
			'<div class="categoryItem">',
				'<div class="categoryHandle"></div>',
				'<div class="categoryWrapper">',
					'<a href="#" title="Delete" class="deleteCategory"><img src="',
					'',
					'img/icon-delete.png" alt="" /> Delete</a>',
					'<label><span>Name:</span><input type="text" size="60" name="name[]" value="New category" /></label>',
					'<a href="#" title="Save" class="saveCategory"><img src="',
					'',
					'img/disk.png" alt="Save" /> Save</a>',
					'<label><span>Title:</span><input type="text" size="60" name="title[]" value="newcategory" /></label>',
					'<label><span>Description:</span><input type="text" size="60" name="description[]" value="newcategory" /></label>',
					'<label><span>Keywords:</span><input type="text" size="60" name="keywords[]" value="newcategory" /></label>',
					'<label><span>URL:</span><input type="text" size="60" name="url[]" value="newcategory" /></label>',
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
			if ($(e.target).is('div.categoryHandle') && saving == false) {
				currentEl = $(e.target.parentNode)
								.fadeTo(500, 0.4)
								.addClass('draggingItem')
								.get(0);
				elOrigPrev = currentEl.previousSibling;
				elOrigNext = currentEl.nextSibling;
				pointerPosition = e.pageY;
				minTop = -currentEl.offsetTop;
				maxTop = document.getElementById('categoriesContainer').offsetHeight - currentEl.offsetHeight + minTop;
				items = $('#categoriesContainer div.categoryItem');
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
						maxTop = document.getElementById('categoriesContainer').offsetHeight - currentEl.offsetHeight + minTop;
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
		
		var updateCategoriesList = function() {
			$.ajax({
				type: 'post',
				url: Jobber.jobber_admin_url + 'categories/',
				data: {
					action: 'getCategoriesList'
				},
				success: function(responseText){
					$('#categs-nav ul').html(responseText);
				},
				complete: function(){
					jobberBase.overlay.hide();
				}
			})
			jobberBase.overlay.show(document.getElementById('categs-nav'));
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
				jobberBase.messages.add('Categories order changed. Saving ...');
				saving = true;
				jobberBase.overlay.show(document.getElementById('categoriesContainer'));
				var order = [];
				$('#categoriesContainer div.categoryItem')
					.each(function(nr){
						order.push($(this).attr('rel'));
					});
				$.ajax({
					type: 'post',
					url: Jobber.jobber_admin_url + 'categories/',
					data: {
						action: 'saveOrder',
						order: order.join(',')
					},
					success: function() {
						updateCategoriesList();
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
			if ($(el).is('a.deleteCategory')) {
				if (confirm('Are you sure you want to delete this category?')) {
					jobberBase.overlay.show(el.parentNode.parentNode);
					saving = true;
					$.ajax({
						type: 'post',
						dataType: 'text',
						url: Jobber.jobber_admin_url + 'categories/',
						data: {
							action: 'deleteCategory',
							category: $(el).parent().parent().attr('rel')
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
								jobberBase.messages.add('Category has been deleted');
								updateCategoriesList();
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
			} else if ($(el).is('a.saveCategory')) {
				jobberBase.overlay.show(el.parentNode.parentNode);
				saving = true;
				$.ajax({
					type: 'post',
					dataType: 'text',
					url: Jobber.jobber_admin_url + 'categories/',
					data: {
						action: 'saveCategory',
						category: $(el).parent().parent().attr('rel'),
						name: $(el).parent().find('input:first').val(),
						title: $(el).parent().find('input:eq(1)').val(),
						description: $(el).parent().find('input:eq(2)').val(),
						keywords: $(el).parent().find('input:eq(3)').val(),
						url: $(el).parent().find('input:last').val()
					},
					success: function() {
						jobberBase.messages.add('Category has been saved');
						$(el).hide();
						updateCategoriesList();
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
			categoryTemplate[4] = Jobber.jobber_admin_url;
			categoryTemplate[8] = Jobber.jobber_admin_url;
			var el = $('#categoriesContainer')
					.append(categoryTemplate.join(''))
					.find('div.categoryItem:last')
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
				url: Jobber.jobber_admin_url + 'categories/',
				data: {
					action: 'newCategory'
				},
				success: function(id) {
					$(el)
						.attr('rel', id)
						.find('input:first')
							.attr('name', 'name[' + id + ']')
							.end()
						.find('input:text.eq(1)')
					        .attr('name', 'title[' + id + ']')
					        .end()
					    .find('input:text.eq(2)')
					        .attr('name', 'description[' + id + ']')
					        .end()
					    .find('input:text.eq(3)')
					        .attr('name', 'keywords[' + id + ']')
					        .end()
						.find('input:last')
							.attr('name', 'url[' + id + ']')
							.end();
					updateCategoriesList();
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
				if (document.getElementById('categoriesContainer')) {
					$('#categoriesContainer')
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
	jobberBase.register(jobberBase.categories.init, 'init');
})();