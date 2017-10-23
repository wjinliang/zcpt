var Inbox = function() {

	var content = $('.inbox-content');
	var loading = $('.inbox-loading');
	var note = $('#note');
	var note_msg = $('#note_msg');

	var noteHide = function() {
		note_msg.html('');
		note.hide();
	}

	var noteShow = function(tip) {
		note_msg.html(tip);
		note.show();
		setTimeout(noteHide, 1500);
	}
	var template = '<tr class="template-upload fade in">'
			+ '<td>'
			+ '<span class="preview"><canvas width="46" height="40"></canvas></span>'
			+ '</td>'
			+ '<td>'
			+ '<p class="name">${fileName_}</p>'
			+ '</td>'
			+ '<td>'
			+ '    <p class="size">${fileSize_} KB</p>'
			+ '    <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="bar" style="width:0%;"></div></div>'
			+ '</td>' 
			+ '<td style="vertical-align: middle;">' 
			+ '    <button type="button" class="btn btn-primary start">'
			+ '       <i class="icon-upload icon-white"></i>'
			+ '       <span>开始上传</span>' 
			+ '    </button>'
			+ '    <button type="button" class="btn btn-warning cancel">'
			+ '       <i class="icon-ban-circle icon-white"></i>'
			+ '       <span >取消</span>' 
			+ '    </button>        ' 
			+ '</td>'
			+ '<input type="hidden" name="attId" class="att"/>'
			+ '</tr>';
	var deleteStr = '<i class="icon-trash icon-white"></i>'
			+ '<span >删除</span>'; 
	var currentData = {};
	var initFileupload = function() {

		$('#fileupload').fileupload(
				{
					// Uncomment the following to send cross-domain cookies:
					// xhrFields: {withCredentials: true},
					url : '/DM/file/upload',
					autoUpload : true,
					dataType : 'json',
					previewCrop: true,
					add : function(e, data) {
						var templateImpl = $.tmpl(
								template,
								{
									"fileName_" : data.files[0].name,
									"fileSize_" : (data.files[0].size / 1000)
											.toFixed(2)
								}).appendTo(".files");
						data.content = templateImpl;
						$(".start", templateImpl).click(
								function() {
									currentData.bar = templateImpl;
									$('<p/>').text('上传中...').addClass(
											"uploading").replaceAll($(this));
							data.submit();
						});
						$(".cancel", templateImpl).click(function() {
							$('<p/>').text('已取消...').replaceAll($(this));
							data.abort();
							$(templateImpl).remove();
						});
						
					},
					done : function(e, data) {// 设置文件上传完毕事件的回调函数
						$(".uploading", data.content).text('').after('<i class="icon-ok"></i>');
						$(".att", data.content).val(data.result.id);
						$(".cancel", data.content).html(deleteStr);
					},
					progressall : function(e, data) {// 设置上传进度事件的回调函数
						 var progress = parseInt(data.loaded / data.total * 100, 10);
				         $('.bar', currentData.bar).css(
				                'width',
				                progress + '%'
				         );
					}
				});

	}

	var loadInbox = function(name) {
		var url = '';
		if (name == 'sent') {
			url = '/DM/message/listOutbox';
		} else if (name == 'inbox') {
			url = '/DM/message/listInbox';
		} else if (name == 'draft') {
			url = '/DM/message/listDraft';
		} else if (name == 'trash') {
			url = '/DM/message/listTrash';
		} else if (name == 'mark') {
			url = '/DM/message/listMark';
		}
		var title = $('.inbox-nav > li.' + name + ' a').attr('data-title');

		loading.show();
		content.html('');

		$.post(url, {
			thispage : 0
		}, function(res) {
			$('.inbox-nav > li.active').removeClass('active');
			$('.inbox-nav > li.' + name).addClass('active');
			$('.inbox-header > h1').text(title);

			loading.hide();
			content.html(res);
			App.fixContentHeight();
			App.initUniform();
		});
	}

	var initTags = function(input) {
		$.post("/DM/useraccount/loadUsers", {}, function(res) {
			var strs = res.split(",");
			input.tag({
				autosizedInput : true,
				containerClasses : 'span12',
				inputClasses : 'm-wrap',
				source : function(query, process) {
					return strs
				}
			});
		});
	}

	var initWysihtml5 = function() {
		$('.inbox-wysihtml5')
				.wysihtml5(
						{
							"stylesheets" : [ "../themes/media/assets/plugins/bootstrap-wysihtml5/wysiwyg-color.css" ]
						});
	}

	var loadCompose = function() {
		var url = '/DM/message/writeMessage';

		loading.show();
		content.html('');

		// load the form via ajax
		$.post(url, {}, function(res) {
			$('.inbox-nav > li.active').removeClass('active');
			$('.inbox-header > h1').text('写站内信');

			loading.hide();
			content.html(res);

			initTags($('[name="to"]'));
			initWysihtml5();

			$('.inbox-wysihtml5').focus();

			initFileupload();

			App.fixContentHeight();
			App.initUniform();
		});
	}

	var loadSearchResults = function() {
		var url = 'inbox_search_result.html';

		loading.show();
		content.html('');

		$.post(url, {}, function(res) {
			$('.inbox-nav > li.active').removeClass('active');
			$('.inbox-header > h1').text('Search');

			loading.hide();
			content.html(res);
			App.fixContentHeight();
			App.initUniform();
		});
	}

	var setMarkMessage = function(id) {
		var url = '/DM/message/markMessage';
		$.post(url, {
			msg_user_id : id
		}, function(res) {
			if (res == "y") {
				$("#mark_" + id).removeClass("icon-star").addClass(
						"icon-star-empty");
			} else {

			}
		});
	}

	var cancelMarkMessage = function(id) {
		var url = '/DM/message/cancelMarkMessage';
		$.post(url, {
			msg_user_id : id
		}, function(res) {
			if (res == "y") {
				$("#mark_" + id).removeClass("icon-star-empty").addClass(
						"icon-star");
			} else {
			}
		});
	}

	return {
		// main function to initiate the module
		init : function() {

			// handle compose btn click
			$('.inbox .compose-btn a').live('click', function() {
				loadCompose();
			});

			// handle inbox listing
			$('.inbox-nav > li.inbox > a').click(function() {
				loadInbox('inbox');
			});

			// handle sent listing
			$('.inbox-nav > li.sent > a').click(function() {
				loadInbox('sent');
			});

			// handle draft listing
			$('.inbox-nav > li.draft > a').click(function() {
				loadInbox('draft');
			});

			// handle trash listing
			$('.inbox-nav > li.trash > a').click(function() {
				loadInbox('trash');
			});

			// handle trash listing
			$('.inbox-nav > li.mark > a').click(function() {
				loadInbox('mark');
			});

			$('.icon-star').click(function() {
				$(this).removeClass("icon-star").addClass("icon-star-empty");
			});

			$('.icon-star-empty').click(function() {
				$(this).removeClass("icon-star-empty").addClass("icon-star");
			});

			// handle loading content based on URL parameter
			if (App.getURLParameter("a") === "view") {
				loadMessage();
			} else if (App.getURLParameter("a") === "compose") {
				loadCompose();
			} else {
				loadInbox('inbox');
			}

		},

		loadMessage : function(msgId) {
			var url = '/DM/message/loadMessage?msg_user_id=' + msgId;

			loading.show();
			content.html('');

			$.post(url, {}, function(res) {
				// $('.inbox-nav > li.active').removeClass('active');
				$('.inbox-header > h1').text('查看接收的信息');
				loading.hide();
				content.html(res);
				App.fixContentHeight();
				App.initUniform();
			});
		},

		replyMessage : function(msgId) {
			var url = '/DM/message/replyMessage?msg_user_id=' + msgId;
			loading.show();
			content.html('');

			$.post(url, {}, function(res) {
				// $('.inbox-nav > li.active').removeClass('active');
				$('.inbox-header > h1').text('回复信息');
				loading.hide();
				content.html(res);

				initTags($('[name="to"]'));
				initWysihtml5();

				$('.inbox-wysihtml5').focus();

				App.fixContentHeight();
				App.initUniform();
			});
		},

		editMessage : function(msgId) {
			var url = '/DM/message/editMessage?msg_user_id=' + msgId;
			loading.show();
			content.html('');

			$.post(url, {}, function(res) {
				// $('.inbox-nav > li.active').removeClass('active');
				$('.inbox-header > h1').text('回复信息');
				loading.hide();
				content.html(res);

				initTags($('[name="to"]'));
				initWysihtml5();

				$('.inbox-wysihtml5').focus();

				App.fixContentHeight();
				App.initUniform();
			});
		},

		loadSentMessage : function(msgId) {
			var url = '/DM/message/loadSentMessage?msg_user_id=' + msgId;

			loading.show();
			content.html('');

			$.post(url, {}, function(res) {
				// $('.inbox-nav > li.active').removeClass('active');
				$('.inbox-header > h1').text('查看已发信息');
				loading.hide();
				content.html(res);
				App.fixContentHeight();
				App.initUniform();
			});
		},

		loadDraftMessage : function(msgId) {
			var url = '/DM/message/loadDraftMessage?msg_user_id=' + msgId;

			loading.show();
			content.html('');

			$.post(url, {}, function(res) {
				// $('.inbox-nav > li.active').removeClass('active');
				$('.inbox-header > h1').text('编辑草稿');
				loading.hide();
				content.html(res);

				initTags($('[name="to"]'));
				initWysihtml5();

				$('.inbox-wysihtml5').focus();

				initFileupload();
				
				App.fixContentHeight();
				App.initUniform();
			});
		},

		loadMarkMessage : function(msgId, type) {
			if (type == '1') {
				Inbox.loadMessage(msgId);
			} else if (type == '2') {
				Inbox.loadSentMessage(msgId);
			} else if (type == '3') {
				Inbox.loadDraftMessage(msgId);
			}
		},

		trashMessage : function(id, type) {
			var url = '/DM/message/trashMessage';
			loading.show();
			content.html('');
			$.post(url, {
				msg_user_id : id
			}, function(res) {
				if (res == "y") {
					if (type == '1') {
						loadInbox('inbox');
					} else if (type == '2') {
						loadInbox('sent');
					} else if (type == '3') {
						loadInbox('draft');
					}
				} else {
				}
			});
		},

		recycleMessage : function(id) {
			var url = '/DM/message/recycleMessage';
			loading.show();
			content.html('');
			$.post(url, {
				msg_user_id : id
			}, function(res) {
				if (res == "y") {
					loadInbox('trash');
				} else {
				}
			});
		},

		deleteMessage : function(id) {
			var url = '/DM/message/deleteMessage';
			loading.show();
			content.html('');
			$.post(url, {
				msg_user_id : id
			}, function(res) {
				if (res == "y") {
					loadInbox('trash');
				} else {
				}
			});
		},

		deleteDraftMessage : function(id) {
			window.bootbox.confirm("确定删除吗？", function(result) {
				if (result) {
					var url = '/DM/message/deleteMessage';
					loading.show();
					content.html('');
					$.post(url, {
						msg_user_id : id
					}, function(res) {
						if (res == "y") {
							noteShow("删除草稿成功！");
							loadInbox('draft');
						} else {
						}
					});
				}
			});
		},

		markMessage : function(id) {
			if ($("#mark_" + id).attr("class") == "icon-star") {
				setMarkMessage(id);
			} else {
				cancelMarkMessage(id);
			}
		}

	};

}();