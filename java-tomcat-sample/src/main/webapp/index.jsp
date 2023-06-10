<%@ include file="/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Sample secured web application</title>
</head>
<body>
<h1>
	You are authorized to view
	<%=((HttpServletRequest) pageContext.getRequest()).getServletPath().replaceAll("/(.*)/index.*", "$1")
                   .replaceAll(".*index.*", "unprotected home")%>
	page
</h1>
<pre>
ServletPath: ${pageContext.request.servletPath}
PathInfo: ${pageContext.request.pathInfo}
AuthType:  ${pageContext.request.authType}
Principal: ${empty pageContext.request.userPrincipal ?"": pageContext.request.userPrincipal.name}
isUserInRole("Admin"): <%= request.isUserInRole("Admin") %>
isUserInRole("User"): <%= request.isUserInRole("User") %>
</pre>
<p>This application contains several pages:</p>
<ul>
	<li><a href="<c:url value='/'/>">Home page</a> - unprotected</li>
	<li><a href="<c:url value='/user/'/>">User page</a> - only users with User or Admin role can access it</li>
	<li><a href="<c:url value='/admin/'/>">Admin page</a> - only users with Admin role can access it</li>
</ul>
<p>Also test Servlets (3.0 - annotations used) are included:</p>
<ul>
	<li><a href="<c:url value='/SimpleServlet'/>">SimpleServlet</a> - prints UserPrincipal - unprotected 
	    (<a href="<c:url value='/SimpleServlet?createSession='/>">with session</a>)</li>
	<li><a href="<c:url value='/SysPropServlet'/>">SysPropServlet</a> - prints (if allowed) java.home system property value
	    (<a href="<c:url value='/SysPropServlet?property=java.version'/>">java.version</a>,
	    <a href="<c:url value='/SysPropServlet?property=user.home'/>">user.home</a>)</li>
	<li><a href="<c:url value='/RolePrintingServlet'/>">RolePrintingServlet</a> - prints those role names from list given as a parameter
	    (<a href="<c:url value='/RolePrintingServlet?role=Admin&amp;role=User&amp;role=Echo'/>">role=Admin&amp;role=User&amp;role=Echo</a>)</li>
	<li><a href="<c:url value='/ReadFileServlet'/>">ReadFileServlet</a> - prints (if allowed) content of /etc/passwd file
	    (<a href="<c:url value='/ReadFileServlet?file=%2Fetc%2Fgroup'/>">/etc/group</a>,
	    <a href="<c:url value='/ReadFileServlet?file=%2Fvar%2Flog%2Fauth.log'/>">/var/log/auth.log</a>)</li>
	<li><a href="<c:url value='/SimpleSecuredServlet'/>">SimpleSecuredServlet</a> - prints UserPrincipal - protected - only Admin role has access 
	    (<a href="<c:url value='/SimpleSecuredServlet?createSession='/>">with session</a>)</li>
	<li><a href="<c:url value='/SessionCounterServlet'/>">SessionCounterServlet</a> - tests session - unprotected 
	    (<a href="<c:url value='/SessionCounterServlet?invalidateSession='/>">invalidate</a>,
		<a href="<c:url value='/SessionCounterServlet?removeCounter='/>">remove counter attribute</a>)</li>
	<li><a href="<c:url value='/SessionStatusCheckServlet'/>">SessionStatusCheckServlet</a> - check session status - unprotected</li>
	<li><a href="<c:url value='/JSMCheckServlet'/>">JSMCheckServlet</a> - checks if the Java Security Manager is enabled</li>
	<li><a href="<c:url value='/LoggingServlet'/>">LoggingServlet</a> - logs messages using java.util.logging</li>
	<li><a href="<c:url value='/ListKeystoreTypesServlet'/>">ListKeystoreTypesServlet</a> - prints available keystore types</li>
	<li><a href="<c:url value='/SendErrorServlet'/>">SendErrorServlet</a> - uses <code>HttpServletRequest.sendError(int)</code> method to reply with errror
		    (error code: 
		    <a href="<c:url value='/SendErrorServlet?code=100'/>">100</a>,
		    <a href="<c:url value='/SendErrorServlet?code=200'/>">200</a>,
		    <a href="<c:url value='/SendErrorServlet?code=204'/>">204</a>,
		    <a href="<c:url value='/SendErrorServlet?code=304'/>">304</a>,
		    <a href="<c:url value='/SendErrorServlet?code=500'/>">500</a>
		    )</li>
	<li><a href="<c:url value='/SubjectInfoServlet'/>">SubjectInfoServlet</a> - prints info about <code>javax.security.auth.Subject</code> instance retrieved from <code>javax.security.jacc.PolicyContext.getContext("javax.security.auth.Subject.container")</code> call
	    (<a href="<c:url value='/SubjectInfoServlet?jaas='/>">JAAS way</a> - <code>Subject.getSubject(AccessController.getContext());</code>)</li>
	<li><a href="<c:url value='/CallProtectedEjbServlet'/>">CallProtectedEjbServlet</a> - unprotected servlet which calls a simple protected <code>HelloWorld</code> EJB</li>
	<li><a href="<c:url value='/SecuredCallEjbServlet'/>">SecuredCallEjbServlet</a> - protected servlet which calls a simple protected <code>HelloWorld</code> EJB</li>
	<li><a href="<c:url value='/RunAsServlet'/>">RunAsServlet</a> - <code>@RunAs</code> child of <code>/CallProtectedEjbServlet</code> servlet.
		This servlet also calls the protected EJB method in its <code>init()</code> and <code>destroy()</code> methods.</li>
</ul>
<p>Authentication-related servlets:</p>
<ul>
	<li><a href="<c:url value='/AuthnServlet'/>">AuthnServlet</a> - calls HttpServletRequest.authenticate(HttpServletResponse) (<a href="<c:url value='/AuthnServlet?createSession='/>">with session</a>)</li>
	<li><a href="<c:url value='/LoginServlet?user=admin&password=admin'/>">LoginServlet - admin/admin</a> (<a href="<c:url value='/LoginServlet?user=admin&password=admin&createSession='/>">with session</a>)</li>
	<li><a href="<c:url value='/LoginServlet?user=user&password=user'/>">LoginServlet - user/user</a> (<a href="<c:url value='/LoginServlet?user=user&password=user&createSession='/>">with session</a>)</li>
	<li><a href="<c:url value='/JaasLoginServlet?user=user&password=user'/>">JaasLoginServlet - user/user</a> (<a href="<c:url value='/JaasLoginServlet?user=user&password=user&createSession='/>">with session</a>)</li>
	<li><a href="<c:url value='/LogoutServlet'/>">LogoutServlet</a> (<a href="<c:url value='/LogoutServlet?createSession='/>">with session</a>, <a href="<c:url value='/LogoutServlet?invalidateSession='/>">invalidate session</a>)</li>
</ul>

<h2>REST</h2>
<ul>
	<li><a href="<c:url value='/rest/login?username=user&password=user'/>">/rest/login?username=user&password=user</a> - calls HttpServletRequest.login()</li>
	<li><a href="<c:url value='/rest/login?username=admin&password=admin'/>">/rest/login?username=admin&password=admin</a> - calls HttpServletRequest.login()</li>
	<li><a href="<c:url value='/rest/secured'/>">/rest/secured</a> resource protected by security-contrainst in web.xml - only Admin role allowed</li>
	<li><a href="<c:url value='/rest/role-based'/>">/role-based</a> RestEasy implementation of role based access control - class level @RolesAllowed({ "Admin", "User" })</li>
	<li><a href="<c:url value='/rest/role-based/admin'/>">/role-based/admin</a> RestEasy implementation of role based access control - method level @RolesAllowed("Admin")</li>
	<li><a href="<c:url value='/rest/role-based/permit'/>">/role-based/permit</a> RestEasy implementation of role based access control - method level @PermitAll</li>
</ul>



<c:if test="${not empty pageContext.request.userPrincipal}">
	<a href="<c:url value='/logout.jsp'/>">Logout JSP</a> - invalidates session and redirects user to context root.
</c:if>
<p>There are 2 user accounts prepared for JBoss AS testing:</p>
<ul>
	<li>user/user with role User</li>
	<li>admin/admin with role Admin</li>
</ul>
<p>You'll need a new security domain in WildFly (standalone.xml):</p>
<pre>
&lt;security-domain name=&quot;web-tests&quot; cache-type=&quot;default&quot;&gt;
	&lt;authentication&gt;
		&lt;login-module code=&quot;UsersRoles&quot; flag=&quot;required&quot;/&gt;
	&lt;/authentication&gt;
&lt;/security-domain&gt;

or use CLI (jboss-cli.sh):

connect
/subsystem=security/security-domain=web-tests:add(cache-type=default)
/subsystem=security/security-domain=web-tests/authentication=classic:add(login-modules=[{"code"=>"UsersRoles", "flag"=>"required"}]) {allow-resource-service-restart=true}
</pre>
</body>
</html>
