(function() 
{
	Jobber = {
		
		jobber_url: "",
		
		FixPng: function()
		{
			var arVersion = navigator.appVersion.split("MSIE");
			var version = parseFloat(arVersion[1]);

			if ((version >= 5.5) && (document.body.filters)) 
			{
			   for(var i=0; i<document.images.length; i++)
			   {
			      var img = document.images[i];
			      var imgName = img.src.toUpperCase();

			      if (imgName == this.jobber_url.toUpperCase() + "IMG/BT-RSS.PNG")
			      {
			         var imgID = (img.id) ? "id='" + img.id + "' " : "";
			         var imgClass = (img.className) ? "class='" + img.className + "' " : "";
			         var imgTitle = (img.title) ? "title='" + img.title + "' " : "title='" + img.alt + "' ";
			         var imgStyle = "display:inline-block;" + img.style.cssText;
			         if (img.align == "left") imgStyle = "float:left;" + imgStyle;
			         if (img.align == "right") imgStyle = "float:right;" + imgStyle;
			         if (img.parentElement.href) imgStyle = "cursor:hand;" + imgStyle;
			         var strNewHTML = "<span " + imgID + imgClass + imgTitle;
			         strNewHTML += " style=\"" + "width:" + img.width + "px; height:" + img.height + "px;" + imgStyle + ";";
			         strNewHTML += "filter:progid:DXImageTransform.Microsoft.AlphaImageLoader";
			         strNewHTML += "(src=\'" + img.src + "\', sizingMethod='scale');\"></span>";
			         img.outerHTML = strNewHTML;
			         i = i - 1;
			      }
			   }
			}

		},
		
		PerformSearch: function(url, keywords)
		{
			clearTimeout(window.search_timer);	
			$('#job-listings').load(url + encodeURIComponent(keywords) + '/');	
			$("#indicator").hide();	
		},
		
		HandleLocationOutsideRo: function()
		{
			if ($("#location_outside_ro").is(":visible"))
			{
				$("#city_id").removeAttr("disabled");
				$("#location_outside_ro").hide();
				$("#other_location_label").html(Jobber.I18n.js.location_other);
			}
			else
			{
				$("#city_id").attr("disabled", "disabled");
				$("#location_outside_ro").show();
				$("#location_outside_ro_where").focus();
				$("#other_location_label").html(Jobber.I18n.js.location_pick_from_list);
			}
		},
		
		SendToFriend: {
			showHide: function()
			{
				$("#send-to-friend").toggle();
			},

			init: function()
			{
				$("#frm-send-to-friend").ajaxForm(function(responseText) { 
					if (responseText == "0")
					{
						var msg = Jobber.I18n.js.send_to_friend_unsuccessful;
						$("#send-to-friend-response").css({ color: "red" });
					}
					else
					{
						var msg = Jobber.I18n.js.send_to_friend_successful;
						$("#frm-send-to-friend").clearForm();
						$("#send-to-friend-response").css({ color: "green" });
					}
					$("#send-to-friend-response").html(msg);
				});
			}
		},
		
		ReportSpam: function(url, job_id)
		{
			$.ajax({
			  type: "POST",
			  url: url,
			  data: "job_id=" + job_id,
			  success: function(msg) {
			   	if (msg == "0")
					{
						var status = Jobber.I18n.js.report_spam_unsuccessful;
						$("#report-spam-response").css({ color: "red" });
					}
					else
					{
						var status = Jobber.I18n.js.report_spam_successful;
						$("#frm-send-to-friend").clearForm();
						$("#report-spam-response").css({ color: "green" });
					}
					$("#report-spam-response").html(status);
			  }
			});
		}
	}
})();