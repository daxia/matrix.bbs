<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*" %>
<%
 Logger logger = Logger.getLogger("testLog4j.jsp"); 
 
 //PropertyConfigurator.configure("log4j.properties"); 
		logger.debug("hello!!!");

%>