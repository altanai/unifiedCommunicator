<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
URL url = new URL("https://ajax.googleapis.com/ajax/services/search/images?" +
        "v=1.0&q=barack%20obama&userip=INSERT-USER-IP");
URLConnection connection = url.openConnection();
connection.addRequestProperty("Referer", "http://localhost:8080/Interest/NewFile.jsp");

String line;
StringBuilder builder = new StringBuilder();
BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
while((line = reader.readLine()) != null) {
builder.append(line);
}

JSONObject json = new JSONObject(builder.toString());
%>
</body>
</html>