package com.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.db.Validation;

@Controller
public class LoginController {

	@RequestMapping(value = "/Login", method = RequestMethod.POST)
	public ModelAndView Login(@RequestParam("uname") String uname,@RequestParam("pword") String pword, 
			HttpServletRequest request, HttpServletResponse response ) {
		
		if(request.getCookies() !=  null) {
			if(request.getCookies().length > 1) {
				return new ModelAndView("Welcome");
			}else {

				response.setContentType("text/html");

				PrintWriter out = null;
				try {
					out = response.getWriter();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				Validation val = new Validation();
				Cookie co_f_name, co_l_name = null;


				if(uname.trim().equalsIgnoreCase("") || pword.trim().equalsIgnoreCase("")) {

					out.println("Username or Password can't be blank..!!");
					RequestDispatcher dis = request.getRequestDispatcher("index.jsp");
					try {
						dis.include(request, response);
					} catch (ServletException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

				}else if(!val.validate(uname, pword).equalsIgnoreCase("")) {
					/**
					 * Session Tracking using Session
					 */
					HttpSession session = request.getSession();
					session.setAttribute("employee_id", val.getEmployee_id());

					/**
					 * Session Tracking using Cookies
					 * */

					String username = val.getEmployee_name();
					String name[] = username.split(" ");
					co_f_name = new Cookie("user_f_name", name[0]);
					co_f_name.setMaxAge(1800);
					session.setMaxInactiveInterval(1800);

					if(name.length > 1 ) {
						co_l_name = new Cookie("user_l_name",name[1]);
						co_l_name.setMaxAge(1800);
					}

					if(co_f_name != null) {
						response.addCookie(co_f_name);
					}
					if(co_l_name != null) {
						response.addCookie(co_l_name);
					}

					return new ModelAndView("Welcome.jsp");

				} else {
					out.println("<p id = \"message\">Username or Password incorrect..!!</p>");
					RequestDispatcher dis = request.getRequestDispatcher("index.jsp");
					try {
						dis.include(request, response);
					} catch (ServletException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

				}
			}
		}
		return null;
	}
	
	
	
	
}
