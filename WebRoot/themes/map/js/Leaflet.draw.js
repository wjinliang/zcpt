/*
 * Leaflet.draw assumes that you have already included the Leaflet library.
 */

L.drawVersion = '0.2.4-dev';

L.drawLocal = {
	draw: {
		toolbar: {
			actions: {
				title: '取消绘图',
				text: '取消'
			},
			undo: {
				title: '删除上一点',
				text: '删除上一点'
			},
			buttons: {
				polyline: '画线',
				polygon: '画多边形',
				rectangle: '区域广播画矩形',
				circle: '画圆',
				marker: '虚拟标'
			}
		},
		handlers: {
			circle: {
				tooltip: {
					start: '单击拖拽完成画图'
				}
			},
			marker: {
				tooltip: {
					start: '单击地图进行标记.'
				}
			},
			polygon: {
				tooltip: {
					start: '单击开始绘画',
					cont: '单击继续绘画',
					end: '单击起点结束'
				}
			},
			polyline: {
				error: '<strong>Error:</strong> 形状不能交叉!',
				tooltip: {
					start: '单击开始画线',
					cont: '单击继续画线',
					end: '单击最后节点完成绘画'
				}
			},
			rectangle: {
				tooltip: {
					start: '单击拖拽完成绘画.'
				}
			},
			simpleshape: {
				tooltip: {
					end: '释放鼠标完成绘画'
				}
			}
		}
	},
	edit: {
		toolbar: {
			actions: {
				save: {
					title: '保存.',
					text: '保存'
				},
				cancel: {
					title: '取消',
					text: '取消'
				}
			},
			buttons: {
				edit: '编辑',
				editDisabled: '没有可编辑图层',
				remove: '删除图层.',
				removeDisabled: '没有可删除图层'
			}
		},
		handlers: {
			edit: {
				tooltip: {
					text: '拖拽进行修改',
					subtext: '单击取消来还原操作.'
				}
			},
			remove: {
				tooltip: {
					text: '单击图层删除'
				}
			}
		}
	}
};
