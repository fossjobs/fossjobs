{include file="header.tpl"}
		<div id="content">
				
				<h2 id="categories">Categories</h2>
				
				<div id="categoriesContainer">
				{foreach from=$categories item=category}
					<div class="categoryItem" rel="{$category.id}">
						<div class="categoryHandle"></div>
						<div class="categoryWrapper">
							<a href="#" title="Delete this category" class="deleteCategory"><img src="{$BASE_URL_ADMIN}_templates/img/bin.png" alt="Delete" /></a>
							<label><span>Name:</span><input type="text" size="60" name="name[{$category.id}]" value="{$category.name}" /></label>
							<a href="#" title="Save changes" class="saveCategory"><img src="{$BASE_URL_ADMIN}_templates/img/disk.png" alt="Save" /></a>
							<label><span>Title:</span><input type="text" size="60" name="title[{$category.id}]" value="{$category.title}" /></label>
							<label><span>Description:</span><input type="text" size="60" name="desc[{$category.id}]" value="{$category.description}"/></label>
							<label><span>Keywords:</span><input type="text" size="60" name="keys[{$category.id}]" value="{$category.keywords}" /></label>
							<label><span>URL:</span><input type="text" size="60" name="url[{$category.id}]" value="{$category.var_name}" /></label>
						</div>
					</div>
				{/foreach}
				</div>
				<p></p>
				<p>
					<a href="#" title="Add new category"><img src="{$BASE_URL_ADMIN}_templates/img/plus-button.png" alt="Add new category" /></a>
		</div><!-- #content -->

{include file="footer.tpl"}