package com.mvc.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mvc.model.Login;

@Controller
public class LoginController {

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public void loginProcess(HttpServletRequest request, HttpServletResponse response, 
			@ModelAttribute ("login") Login login) {
		
		System.out.println(login.getUname());
		System.out.println(login.getPword());
		
		
		
	}
	
	
	
	
}
