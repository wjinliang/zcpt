<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
   <style>
    /*  .ais-panel{
    margin: 2px;
    padding: 2px;
    border: 2px solid #119ed6;
    width:100%;
    font-size: 12pt;
    font-weight: normal;
} */
		.bg-blue{
		    background-color: #d3e6ed;
		}
		#ais-table{
		    border: 1px solid #227ca1;
		}
		.ais-table{
		    text-align: center;
		}
		.ais-tp .ais-table{
		    width: 100%;
		}
		.ais-table thead tr th{
		    padding: 5px 3px;
		    text-align: center;
		    background-color: #d3e6ed;
		    font-weight: bold;
		    border-right: 1px solid #88a0aa;
		}
		.ais-table thead tr th:last-child{
		    border-right: none;
		}
		.ais-table tbody tr:hover{
		    background-color: #c7edfa;
		}
		.ais-table tbody tr.even:hover{
		    background-color: #c7edfa;
		}
		.ais-table tbody tr td{
		    padding: 4px 3px 3px 3px;
		    border-bottom: 1px solid #e6e6e6!important;
		    cursor: default;
		}
		.ais-table tbody tr.even{
		     background-color: #ecf5fc;
		 }
		.ais-tp{
		    padding-top: 1px;
		    height: 288px;
		    overflow: auto;
		}
	 .ais-table td {
          border-right: 1px solid #88a0aa;
          border-bottom: 1px solid #88a0aa;
		} 
   </style>
</head>
<body> 
    <div class="ais-panel">
        <div id="ais-table">
            <div class="ais-tp">
                <table class="ais-table">
                    <thead>
                    <tr>
                        <th>MMSI</th>
                        <th>IMO</th>
                        <th>呼号</th>
                        <th>船旗</th>
                        <th>类型</th>
                        <th>船名</th>
                        <th>状态</th>
                        <th>DWT</th>
                    </tr>
                    </thead>
                    <tbody id="boat-table">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>