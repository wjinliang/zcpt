var Menu = function() {

	var menu_json=[];//�˵�json���ݱ���
	
	//���ɶ����˵�
	var initChildMenus = function(id){
		$.each(menu_json,function(index,content){
			if(content.pId==id){
				if($('#ul_'+id).length<=0){
					$('#a_'+id).append('<span class="fa arrow"></span>');
					$('#li_'+id).append('<ul id="ul_'+id+'" class="nav nav-second-level"></ul>');
				}
				$('#ul_'+id).append('<li id="li_'+content.id+'" class=""><a id="a_'+content.id+'" href="javascript:void(0)"><i class="'+content.icon+'"></i><span class="nav-label">'+content.name+'</span></a></li>');
				initThirdChildMenus(content.id);
			}
			
		});
	}
	
	//�����������ϲ˵�
	var initThirdChildMenus = function(id){
		
		$.each(menu_json,function(index,content){
			if(content.pId==id){
				if($('#ul_'+id).length<=0){				
					$('#a_'+id).append('<span class="fa arrow"></span>');
					$('#li_'+id).append('<ul id="ul_'+id+'" class="nav nav-third-level"></ul>');					
				}
				$('#ul_'+id).append('<li id="li_'+content.id+'" class=""><a id="a_'+content.id+'" href="javascript:void(0)"><i class="'+content.icon+'"></i><span class="nav-label">'+content.name+'</span></a></li>');
				//��������ݹ�
				initThirdChildMenus(content.id);
			}
			
		});

	}
	
	//��ʼ�������˵��������˵�pIdΪ0��
	var initTopMenus = function(){
		$.each(menu_json,function(index,content){			
			if(content.pId==0){				
				$('#side-menu').append('<li id="li_'+content.id+'" class=""><a id="a_'+content.id+'" href="javascript:void(0)"><i class="'+content.icon+'"></i><span class="nav-label">'+content.name+'</span></a></li>');	
				initChildMenus(content.id);
			}
			
		});
	}
	//��ʼѡ�е�ǰ����
	var initActiveNav = function(id){
		$('#li_'+id).addClass("active");
		$('#li_'+id).parents('li').addClass("active");
		
	}

	return {
		init : function(menus){
			menu_json = menus;
			initTopMenus();
		},
		aciveNav : function(id){
			initActiveNav(id);
		}
	}
}();