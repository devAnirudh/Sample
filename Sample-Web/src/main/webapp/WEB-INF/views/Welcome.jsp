<%@page import="java.util.Enumeration"%>
<%@page import="com.entity.Bugs"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
<title>Welcome to RPA bug tracker</title>
<style type="text/css">
#assigned {
	margin-bottom: 50px;
	margin-top: 50px
}
</style>
</head>
<body>

	<%
		String username = null;
		String last_name = null;
		Cookie co[] = request.getCookies();
		if (co.length > 1) {

			Enumeration<String> e = session.getAttributeNames();
			
			for (Cookie co_temp : co) {

				if (co_temp.getName().equalsIgnoreCase("user_f_name"))
					username = co_temp.getValue();
				else if (co_temp.getName().equalsIgnoreCase("user_l_name"))
					last_name = co_temp.getValue();
			}
		} else {
			response.sendRedirect("SessionExpired.html");
		}

		ArrayList<String> bug_list = new ArrayList<String>();
		Bugs b = new Bugs();
		b.initialize_db();
		bug_list = b.getDistinctBugs();
	%>

	<p>
		Welcome
		<%=username + " " + last_name + ","%></p>

	<div class="dropdown">

		<button class="btn btn-primary dropdown-toggle" type="button"
			data-toggle="dropdown">
			More<span = class="caret"> </span>
		</button>
		<ul class="dropdown-menu">
			<li><a href="#">About</a></li>
			<li><a href="#">Help</a></li>
			<li><a href="Logout.jsp">Logout</a></li>
		</ul>
	</div>
	<div id="assigned">
		<table>
			<tr>
				<td><font size="5px">Bugs assigned to you</font></td>
			</tr>
			<tr>
				<td>Select type of bug:</td>
				<td><select id="bug_list" onchange="sendSelected()">
						<option value = "%25">
							Select
						</option>
						<%
							for (String bug_type : bug_list) {
						%>
						<option>
							<%=bug_type%>
						</option>
						<%
							}
						%>
				</select></td>
			</tr>
		</table>
	</div>

	<div id="div1">

		<table id="bug_table" class="table">
			<tr>
				<th>Bug Id</th>
				<th>Bug Description</th>
				<th>Bug Type</th>
				<th>Status</th>
				<th></th>
			</tr>
			<%
				if (session.getAttribute("employee_id") != null) {
					String emp_id = session.getAttribute("employee_id").toString();
					ArrayList<Bugs> bugs = b.getBugs(emp_id);
					for (int i = 0; i < bugs.size(); i++) {
			%>
			<tr>
				<td><%=bugs.get(i).getBug_id()%></td>
				<td><%=bugs.get(i).getBug_desc()%></td>
				<td><%=bugs.get(i).getBug_type()%></td>
				<td><%=bugs.get(i).getStatus()%></td>
				<td class="update"><a data-toggle="modal" data-target="#myModal"
					style="cursor: pointer;" onclick="updateDesc()">Update</a></td>
			</tr>
			<%
				}
				}
			%>
		</table>
	</div>

	<div class="container">
		
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Enter description</h4>
					</div>
					<div class="modal-body">
						<p class="label label-primary">
							Bug Id : <span id="b_id"></span>
						</p>
						<p style="padding-top: 10px">
							<b>Bug Details</b>
						</p>
						<p id="b_desc"></p>

						<p>
							<b>Description</b>
						</p>
						<textarea id="desc_input" name="desc" cols="60" rows="5"></textarea>
						
						<p id = "type" hidden></p>
						<p>
							<b>Status</b>
						</p>
						<select id="status">
							<option>Select</option>
							<option>Unresolved</option>
							<option>Resolved</option>
							<option>WIP</option>
						</select>
					</div>
					<div class="modal-footer">
						<button id="updateSubmit" type="button"
							onclick="getDescription();" class="btn btn-default"
							data-dismiss="modal">Submit</button>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>

<script type="text/javascript">
	function HandleBackFunctionality() {

		if (window.event) {
			if (window.clientX < 40 && window.clientY < 0) {
				alert("back button was clicked")
			} else {
				alert("refresh button was clicked")
			}

		} else {

			if (event.currentTarget.performance.navigation.type == 1) {
				alert("refresh button was clicked")
			} else if (event.currentTarget.performance.navigation.type == 2) {
				alert("back button was clicked")
			}
		}

	}

	function sendSelected() {
		var d = document.getElementById("bug_list");
		var bug_table = document.getElementById("bug_table");
		var selectedBug = d.options[d.selectedIndex].value;
		
		var url = "FilteredBugs.jsp?bug=" + selectedBug;

		request = new XMLHttpRequest();
		request.open("GET", url, true);
		request.send();

		request.onreadystatechange = function getInfo() {
			if (request.readyState == 4) {

				setTable(this.responseText, bug_table);
			}
		}
	}

	function getDescription() {
		var desc = document.getElementById("desc");
		var option_status = document.getElementById("status");
		desc.value = "";
		option_status.value = "Select";

	}
	
	function setTable(responseText, bug_table) {
		
		for (i = 1; i < bug_table.rows.length; i++) {

			for (j = 0; j < bug_table.rows[i].cells.length; j++) {
				bug_table.rows[i].cells[j].innerHTML = "";
			}
		}
		var obj = JSON.parse(responseText);
		for (i = 0; i < obj.length; i++) {
			if (obj[i].status == "Unresolved") {
				bug_table.rows[i + 1].className = "danger";
			} else if (obj[i].status == "Resolved"){
				bug_table.rows[i + 1].className = "success";
			} else if ((obj[i].status == "WIP")) {
				bug_table.rows[i + 1].className = "warning";
			}
			bug_table.rows[i + 1].cells[0].innerHTML = obj[i].id;
			bug_table.rows[i + 1].cells[1].innerHTML = obj[i].desc;
			bug_table.rows[i + 1].cells[2].innerHTML = obj[i].type;
			bug_table.rows[i + 1].cells[3].innerHTML = obj[i].status;
			if(obj[i].resolution != null){
					bug_table.rows[i + 1].cells[3].title = obj[i].resolution;
			}
			bug_table.rows[i + 1].cells[4].innerHTML = "<a data-toggle=\"modal\" data-target=\"#myModal\" style=\"cursor: pointer;\" onclick=updateDesc()>Update</a>";

		}
		
		for (i = 1; i < bug_table.rows.length; i++) {

				if(bug_table.rows[i].cells[0].innerHTML == "") {
					bug_table.deleteRow(i);
				}
		}
		
	}

	$(document).ready(function() {
		$(".update").click(function() {
			var index = $(".update").index(this);
			var table = document.getElementById("bug_table");
			var id = table.rows[index + 1].cells[0].innerHTML;
			var desc = table.rows[index + 1].cells[1].innerHTML;
			var type = table.rows[index + 1].cells[2].innerHTML;
			$("#b_id").html(id);
			$("#b_desc").html(desc);
			$("#type").html(type);
		});

		$("#updateSubmit").click(function() {
			$.ajax({
				url : "UpdateBugs.jsp",
				type : "post",
				data : {
					id : $("#b_id").html(),
					bug_desc : $("#desc_input").val(),
					status : $("#status").val(),
					bug_type : $("#type").html(),
				},
				async : false,
				
				success : function(result) {
					setTable(result);
				}
			});
			
			$("#status").val("Select");
			$("#desc_input").val("");

		});
	});
</script>

</html>