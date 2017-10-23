var Menu = function() {

	var menu_json=[];//�˵�json��ݱ���
	
	//��ɶ����˵�
	var initSideChildMenus = function(id){
		$.each(menu_json,function(index,content){
			if(content.pId==id){
				if($('#ul_'+id).length<=0){
					$('#a_'+id).append('<span class="arrow"></span>');
					$('#li_'+id).append('<ul id="ul_'+id+'" class="sub-menu"></ul>');
				}
				var url = ';';
				if(content.isLeaf){
					url ='go("'+content.url+'");'; 
				}
				$('#ul_'+id).append('<li id="li_'+content.id+'"  title="'+content.name+'" ><a id="a_'+content.id+'" href=\'javascript:'+url+'\'><i class="'+content.icon+'"></i><span class="title">'+content.name+'</span>'
						+'<span id="span_'+content.id+'"></span></a></li>');
				initSideChildMenus(content.id);
			}
			
		});
	}
	
	
	//��ʼ�������˵��������˵�pIdΪ0��
	var initSideMenus = function(){
		$.each(menu_json,function(index,content){			
			if(content.pId==0){		
				var url = ';';
				if(content.isLeaf){
					url ='go("'+content.url+'");'; 
				}
				$('.page-sidebar-menu').append('<li id="li_'+content.id+'" title="'+content.name+'" ><a id="a_'+content.id+'" href=\'javascript:'+url+'\' ><i class="'+content.icon+'"></i><span class="title">'+content.name+'</span>'
						+'<span id="span_'+content.id+'"></span></a></li>');	
				initSideChildMenus(content.id);
			}
			
		});
	}
	
	var initTopChildMenus = function(id){
		$.each(menu_json,function(index,content){
			if(content.pId==id){
				if($('#ul_'+id).length<=0){
					$('#a_'+id).append('<span class="arrow"></span>');
					$('#li_'+id).append('<ul id="ul_'+id+'" class="dropdown-menu"></ul>');
				}
				var url = ';';
				var extra = '';
				if(content.isLeaf){
					url ='go("'+content.url+'");'; 
				}else{
					extra = 'data-toggle="dropdown" class="dropdown-toggle"';
				}
				$('#ul_'+id).append('<li id="li_'+content.id+'"  title="'+content.name+'" ><a id="a_'+content.id+'" '+extra+' href=\'javascript:'+url+'\'>'+content.name
						+'<span id="span_'+content.id+'"></span></a></li>');
				initTopChildMenus(content.id);
			}
			
		});
	}
	
	var initTopMenus = function(){
		$('#vertical > .navbar-inner').append('<ul id="top_menu" class="nav"></ul>');
		$.each(menu_json,function(index,content){			
			if(content.pId==0){		
				var url = ';';
				var extra = '';
				if(content.isLeaf){
					url ='go("'+content.url+'");'; 
				}else{
					extra = 'data-toggle="dropdown" class="dropdown-toggle"';
				}
				$('#top_menu').append('<li id="li_'+content.id+'" title="'+content.name+'" ><a data="top_a" id="a_'+content.id+'" '+extra+' href=\'javascript:'+url+'\' >'+content.name
						+'<span id="span_'+content.id+'"></span></a></li>');	
				initTopChildMenus(content.id);
			}
			
		});
	}
	//��ʼѡ�е�ǰ����
	var initActiveNav = function(id){
		
		$('#li_'+id).addClass("active");
		
		$('#li_'+id).parents('li').addClass("active");
		$('#li_'+id).parents('li').find('.arrow:first').addClass("open");
		
		
		if($("#layoutSetting").val()=='0')
    	{
			$('#li_'+id).parents('li').find('a').append("<span class='selected'></span>");
			$('#li_'+id).find('a').find("#span_"+id).addClass("selected");
    	}else{
    		if($('#li_'+id).parents('li').length==0){
    			$('#li_'+id).find('a').find("#span_"+id).addClass("selected");
    		}else{
    			$('#li_'+id).parents('li').find('a[data="top_a"]').append("<span class='selected'></span>");
    		}
    	}
		
	}

	return {
		init : function(menus){
			menu_json = menus;
			if($("#layoutSetting").val()=='0'){
				initSideMenus();
			}else{
				initTopMenus();
			}
			
		},
		aciveNav : function(id){
			initActiveNav(id);
		}
	}
}();