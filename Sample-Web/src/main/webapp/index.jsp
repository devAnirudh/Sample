<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<style>
body {
	background-image: url("/resources/img/robotic_automation1.jpg");
	background-size: auto;
}

.container_login {
	padding-top: 250px;
	padding-bottom: 50px;
}

label {
	padding-right: 30px;
	padding-bottom: 20px;
	color: #d9d9d9;
}

input {
	margin-right: 30px;
	margin-bottom: 10px;
	width: 150px;
}

#message {
	position: absolute;
	top: 280px;
	left: 50px;
	color: #ffe8e8;
}

.error_msg {
	color: #ff3041;
	display: none;
}
</style>
<meta charset="ISO-8859-1">
<title>Log In Page - RPA Central</title>
</head>

<body>
	

	<form modelAttribute="login" action="login" method="post">
		<div class="container_login" id="container_login"
			style="display: block">

			<label><b> Username </b></label> <input type="text"
				placeholder="Username" name="uname" id="uname"
				onblur="trim_input(this.id)" required> <label> <b>
					Password </b>
			</label> <input type="password" placeholder="Password" name="pword"
				id="pword" onblur="trim_input(this.id)" required> <input
				type="submit" onclick="validateInput()" id="login" value="Login">

		</div>
	</form>

	<i><font color="#edf0f2"> New employee..? </font></i>
	<input type="submit" id="register" value="Register">

	<form method="post" action="Signup" onsubmit="return validateSignup();">
		<div class="container_signup" id="container_signup"
			style="display: none">
			<table>
				<tr>
					<td><label><b> Employee ID: </b></label></td>
					<td><input type="text" placeholder="Employee ID" name="emp_id"
						id="emp_id" onblur="trim_input(this.id)"></td>
					<td><span role="alert" class="error_msg" id=emp_err>You
							can't leave this field empty.</span></td>
				</tr>
				<tr>
					<td><label><b> Name: </b></label></td>
					<td><input type="text" placeholder="First Name"
						name="emp_f_name" id="emp_f_name" onblur="trim_input(this.id)"></td>
					<td><input type="text" placeholder="Last Name"
						name="emp_l_name" id="emp_l_name" onblur="trim_input(this.id)"></td>
					<td><span role="alert" class="error_msg" id=emp_name_err>You
							can't leave this field empty.</span></td>
				</tr>
				<tr>
					<td><label><b> Mobile: </b></label></td>
					<td><input type="tel" placeholder="Mobile" name="mobile"
						id="mobile" maxlength="10" autocomplete="on"
						onblur="trim_input(this.id)"></td>
					<td><span role="alert" class="error_msg" id=mob_err>You
							can't leave this field empty.</span></td>
				</tr>
				<tr>
					<td><label><b> E-mail ID: </b></label></td>
					<td><input type="email" placeholder="innovation@tcs.com"
						name="email_id" id="email_id" onblur="trim_input(this.id)"></td>
					<td><span role="alert" class="error_msg" id=mail_err>You
							can't leave this field empty.</span></td>
				</tr>
				<tr>
					<td><label><b> Password: </b></label></td>
					<td><input type="password" placeholder="Password"
						name="pword_signup" id="pword_signup" onblur="trim_input(this.id)"></td>
					<td><span role="alert" class="error_msg" id=pword_err>You
							can't leave this field empty.</span></td>
				</tr>

				<tr>
					<td><label><b> Confirm Password: </b></label></td>
					<td><input type="password" placeholder="Confirm Password"
						name="conf_pword" id="conf_pword" onblur="trim_input(this.id)"></td>
					<td><span role="alert" class="error_msg" id=c_pword_err>You
							can't leave this field empty.</span> <span role="alert"
						class="error_msg" id=pword_no_match>Password doesn't match.</span></td>
				</tr>

			</table>

			<input type="submit" id="signup" value="Signup">

		</div>
	</form>



	<script type="text/javascript">
			
	
		
	
		function validateInput() {
			var uname = document.getElementById("uname").value;
			var pword = document.getElementById("pword").value;
		}

		function validateSignup() {

			var is_complete = true;
			var employee_id = document.getElementById("emp_id").value;
			var mob = document.getElementById("mobile").value;
			var mail = document.getElementById("email_id").value;
			var pword = document.getElementById("pword_signup").value;
			var c_pword = document.getElementById("conf_pword").value;
			var f_name = document.getElementById("emp_f_name").value;
			var l_name = document.getElementById("emp_l_name").value;

			var emp_err = document.getElementById("emp_err");
			var mob_err = document.getElementById("mob_err");
			var mail_err = document.getElementById("mail_err");
			var pword_err = document.getElementById("pword_err");
			var c_pword_err = document.getElementById("c_pword_err");
			var pword_no_match = document.getElementById("pword_no_match");
			var emp_name_err = document.getElementById("emp_name_err");
			

			if (employee_id.trim() == "") {
				emp_err.style.display = "block";
				is_complete = false;
			} else {
				emp_err.style.display = "none";
			}
			if (mob.trim() == "") {
				mob_err.style.display = "block";
				is_complete = false;
			} else {
				mob_err.style.display = "none";
			}
			if (mail.trim() == "") {
				mail_err.style.display = "block";
				is_complete = false;
			} else {
				mail_err.style.display = "none";
			}
			if (pword.trim() == "") {
				pword_err.style.display = "block";
				is_complete = false;

			} else {
				pword_err.style.display = "none";
			}
			if (c_pword.trim() == "") {
				c_pword_err.style.display = "block";
				is_complete = false;
			} else {
				c_pword_err.style.display = "none";
			}
			if(f_name.trim() == "" || l_name.trim() == "") {
				emp_name_err.style.display = "block";
				is_complete = false;
			}else {
				emp_name_err.style.display = "none";
			}
			
			if(pword.trim() != c_pword.trim() && c_pword.trim() != "") {
				pword_no_match.style.display = "block";
				is_complete = false;
			} else {
				pword_no_match.style.display = "none"; 
			}

			return is_complete;
		}
		
		function trim_input(id) {
			var input = document.getElementById(id);
			input.value = input.value.trim();	
		}
		
		$(document).ready(function(){
			$("#register").click(function(){
				$("#container_signup").toggle(500);
				
				
			});
		});
	</script>

</body>
</html>