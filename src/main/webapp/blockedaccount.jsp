<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tài khoản bị khóa</title>
    <style>
        body {
            font-family: Poppins, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f8d7da;
            margin: 0;
        }

        .container {
            text-align: center;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 400px;
        }

        h1 {
            color: #721c24;
        }

        p {
            color: #721c24;
            font-size: 16px;
        }

        .btn {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 20px;
            color: white;
            background-color: #dc3545;
            text-decoration: none;
            border-radius: 5px;
        }

        .btn:hover {
            background-color: #c82333;
        }
        .button {
            background-color: #f8d7da;
            color:brown;
            margin-top: 20px;
            font-weight: bold;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Tài khoản bị khóa</h1>
    <p>Tài khoản của bạn đã bị khóa. Vui lòng liên hệ với admin để biết thêm chi tiết.</p>
    <a href="" class="btn">Admin: 1900 1508</a>
    <form id="logoutForm" action="logout" method="post">
        <button type="submit" class="button">ĐĂNG XUẤT</button>
    </form>

</div>
</body>
</html>
