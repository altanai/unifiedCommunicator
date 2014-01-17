<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>




</head>
<body>

<script type="text/javascript">
function showStuff(id, text, btn) {
    document.getElementById(id).style.display = 'block';
    // hide the lorem ipsum text
    document.getElementById(text).style.display = 'none';
    // hide the link
    btn.style.display = 'none';
}
</script>

<td class="post">

<a href="#" onclick="showStuff('answer1', 'text1', this); return false;">Edit</a>
<span id="answer1" style="display: none;">
<textarea rows="10" cols="115"></textarea>
</span>

<span id="text1">Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum</span>
</td>
</body>
</html>