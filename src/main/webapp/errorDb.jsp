<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>502 Bad Gateway</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
            color: #333;
        }

        .container {
            margin-top: 100px;
        }

        h1 {
            font-size: 48px;
            color: #dc3545;
        }

        p {
            font-size: 18px;
        }

        a {
            text-decoration: none;
            color: #007bff;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>502 Database Error</h1>
    <p>Xin lỗi nha! Cấu hình lại Database mới truy cập được nhé.</p>
    <p><a href="${pageContext.request.contextPath}/index">Quay lại trang chủ</a></p>
</div>
</body>
</html>