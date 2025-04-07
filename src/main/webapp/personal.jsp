<%@ page import="vn.edu.hcmuaf.fit.sourcedoannoithat.dao.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đồ án web</title>
    <link href="https://fonts.googleapis.com/css?family=Fira+Sans+Condensed:300,400,600i&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/personal_style.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>

<body>
<div class="personal">

    <jsp:include page="/components/header.jsp"/>
    <script src="js/showSearch.js"></script>
    <script src="js/actionOfProfile.js"></script>
    <div class="overlay" id="overlay"></div>

    <script src="js/showCart.js"></script>
    <div class="navigation_titlePage">
        <div class="container">
            <div class="alpha">
                <img src="img/background.jpg" alt="">
            </div>
            <div class="omega">
                <h1 class="title">Thông tin</h1>
                <div class="path">
                    <div class="home">Trang chủ</div>
                    <div class="icon">
                        <ul class="icons">
                            <li><i class="fa fa-chevron-right"></i></li>
                        </ul>
                    </div>
                    <div class="contact">Thông tin</div>
                </div>
            </div>
        </div>
    </div>
    <div class="content_section">
        <div class="container">
            <div class="alpha">
                <div class="avt">
                    <img src="img/avt.jpg" alt="">
                    <div class="welcomeName">
                        <h5>Welcome<br><strong>${sessionScope.userName}</strong></h5>
                    </div>
                </div>
                <div class="address" id="homePage"><h5><i class="fa fa-home"></i>TRANG TÀI KHOẢN</h5></div>
                <a href="cart.jsp" class="button">
                    <div class="address"><h5><i class="fa fa-box"></i> ĐƠN HÀNG</h5>
                    </div>
                </a>
                <a href="contact.jsp" class="button">
                    <div class="address"><h5><i class="fa fa-location-dot"></i> ĐỊA CHỈ</h5>
                    </div>
                </a>
                <a href="returnProduct.jsp" class="button">
                    <div class="address"><h5><i class="fa fa-arrow-rotate-left"></i> ĐỔI/TRẢ</h5>
                    </div>
                </a>
                <div class="address" id="account"><h5><i class="fa fa-person"></i> TÀI KHOẢN</h5></div>
                <a href="changePassword.jsp" class="button">
                    <div class="address"><h5><i class="fa fa-lock"></i> ĐỔI MẬT KHẨU</h5>
                    </div>
                </a>
                <div class="address" onclick="document.getElementById('logoutForm').submit();">
                    <h5><i class="fa fa-right-from-bracket"></i> ĐĂNG XUẤT</h5>
                    <form id="logoutForm" action="logout" method="post">
                        <button type="submit" class="button" style="display: none;"></button>
                    </form>
                </div>
            </div>
            <div class="omega">
                <div class="container rounded bg-white mb-5">
                    <div class="row" style="display:none" id="md5Section">
                        <div class="col-md-5 border-right">
                            <div class="p-3 py-5">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h2 class="text-right">Cài đặt thông tin</h2>
                                </div>
                                <form action="updateProfile" method="post">
                                    <div class="col-md-6 editable">
                                        <h5 class="labels">Tên khách hàng:</h5>
                                        <p id="userName">${sessionScope.userName}</p>
                                        <input type="text" name="userNameInput" id="userNameInput"
                                               style="display:none;"/>
                                    </div>
                                    <div class="col-md-6 editable">
                                        <h5 class="labels">Ngày sinh:</h5>
                                        <p id="userBirthday">${sessionScope.userBirthday}</p>
                                        <input type="text" name="userBirthdayInput" id="userBirthdayInput"
                                               style="display:none;"/>
                                    </div>
                                    <div class="col-md-12 editable">
                                        <h5 class="labels">Số điện thoại:</h5>
                                        <p id="userPhone">${sessionScope.userPhone}</p>
                                        <input type="text" name="userPhoneInput" id="userPhoneInput"
                                               style="display:none;"/>
                                    </div>
                                    <div class="col-md-12 editable">
                                        <h5 for="province" style="margin-top: 6px">Tỉnh/Thành phố:</h5>
                                        <select id="province" name="province" style="height: 35px;width: 150px">
                                            <option value="">Chọn tỉnh/thành phố</option>
                                        </select><br>

                                        <h5 for="district" style="margin-left: 20px;margin-top: 6px">Quận/Huyện:</h5>
                                        <select id="district" name="district" disabled style="height: 35px;width: 150px">
                                            <option value="">Chọn quận/huyện</option>
                                        </select><br>
                                    </div>
                                    <div class="col-md-12 editable">
                                        <h5 class="labels">Địa chỉ:</h5>
                                        <p id="userAddress">${sessionScope.userAddress}</p>
                                        <input type="text" name="userAddressInput" id="userAddressInput"
                                               style="display:none;"/>
                                    </div>
                                    <div class="col-md-12 editable">
                                        <h5 class="labels">Email:</h5>
                                        <p id="userEmail">
                                            <a href="mailto:${sessionScope.userEmail}">
                                                ${sessionScope.userEmail}
                                            </a>
                                        </p>
                                        <input type="email" name="userEmailInput" id="userEmailInput"
                                               style="display:none;"/>
                                    </div>
                                    <button class="saveBtn" type="submit" style="display:none;">Lưu thông tin</button>
                                    <button class="editBtn" type="button">Chỉnh sửa</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="homePageSection" id="homePageSection">
                        <h5>Xin chào <strong>${sessionScope.userName}</strong>(Không phải
                            <Strong>${sessionScope.userName}</Strong>? Hãy <u>thoát ra</u> và đăng nhập vào tài khoản
                            của bạn) </h5>
                        <div class="content">
                            <a href="cart.jsp" class="button">
                                <div class="box"><h5><i class="fa fa-box"></i> <br> ĐƠN HÀNG</h5></div>
                            </a>
                            <a href="contact.jsp" class="button">
                                <div class="box"><h5><i class="fa fa-location-dot"></i> <br> ĐỊA CHỈ</h5></div>
                            </a>
                            <a href="returnProduct.jsp" class="button">
                                <div class="box"><h5><i class="fa fa-arrow-rotate-left"></i> <br> ĐỔI/TRẢ</h5></div>
                            </a>
                            <div class="box" id="account1"><h5><i class="fa fa-person"></i> <br> TÀI KHOẢN</h5></div>
                            <a href="changePassword.jsp" class="button">
                                <div class="box"><h5><i class="fa fa-lock"></i> <br> ĐỔI MẬT KHẨU</h5></div>
                            </a>
                            <div class="box" onclick="document.getElementById('logoutForm').submit();">
                                <h5><i class="fa fa-right-from-bracket"></i> <br> ĐĂNG XUẤT</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        document.getElementById("homePage").addEventListener("click", function () {
            document.getElementById("md5Section").style.display = "none";
            document.getElementById("homePageSection").style.display = "block";
        });

        document.getElementById("account").addEventListener("click", function () {
            document.getElementById("homePageSection").style.display = "none";
            document.getElementById("md5Section").style.display = "block";
        });
        document.getElementById("account1").addEventListener("click", function () {
            document.getElementById("homePageSection").style.display = "none";
            document.getElementById("md5Section").style.display = "block";
        });
    </script>
    <script>
        async function getProvinces() {
            try {
                const response = await fetch('https://provinces.open-api.vn/api?depth=2');
                if (!response.ok) {
                    throw new Error('Không thể lấy danh sách tỉnh/thành phố');
                }
                const provinces = await response.json();
                console.log('Danh sách tỉnh/thành phố:', provinces);
                const provinceSelect = document.getElementById('province');

                // Thêm các tỉnh/thành phố vào dropdown
                provinces.forEach(province => {
                    const option = document.createElement('option');
                    option.value = province.name;
                    option.textContent = province.name;
                    provinceSelect.appendChild(option);
                });
            } catch (error) {
                console.error('Lỗi khi lấy tỉnh/thành phố:', error);
            }
        }

        async function getDistricts(provinceName) {
            try {
                const response = await fetch(`https://provinces.open-api.vn/api/${provinceCode}?depth=2`);
                if (!response.ok) {
                    console.error(`Lỗi khi gọi API quận/huyện, mã lỗi: ${response.status}`);
                    throw new Error('Không thể lấy danh sách quận/huyện');
                }
                const provinces = await response.json();
                const provinceData = provinces.find(item => item.name === provinceName);
                const districtSelect = document.getElementById('district');
                districtSelect.innerHTML = '<option value="">Chọn quận/huyện</option>';
                if (provinceData && provinceData.districts && Array.isArray(provinceData.districts)) {
                    provinceData.districts.forEach(district => {
                        const option = document.createElement('option');
                        option.value = district.code;
                        option.textContent = district.name;
                        districtSelect.appendChild(option);
                    });
                    districtSelect.disabled = false;
                } else {
                    districtSelect.innerHTML = '<option value="">Không có quận/huyện</option>';
                    districtSelect.disabled = true;
                }
            } catch (error) {
                console.error('Lỗi khi lấy quận/huyện:', error);
                const districtSelect = document.getElementById('district');
                districtSelect.innerHTML = '<option value="">Không thể tải quận/huyện</option>';
                districtSelect.disabled = true;
            }
        }

        document.getElementById('province').addEventListener('change', function () {
            const provinceName = event.target.value;
            if (provinceName) {
                getDistricts(provinceName);
            } else {
                const districtSelect = document.getElementById('district');
                districtSelect.innerHTML = '<option value="">Chọn quận/huyện</option>';
                districtSelect.disabled = true;
            }
        });
        getProvinces();
    </script>
    <script>
        $(document).ready(function () {
            $(".saveBtn").click(function (e) {
                e.preventDefault();

                let formData = {
                    userNameInput: $("#userNameInput").val(),
                    userBirthdayInput: $("#userBirthdayInput").val(),
                    userPhoneInput: $("#userPhoneInput").val(),
                    userAddressInput: $("#userAddressInput").val(),
                    userEmailInput: $("#userEmailInput").val(),
                    province: $("#province").find("option:selected").text(),
                    district: $("#district").find("option:selected").text()
                };

                $.ajax({
                    type: "POST",
                    url: "updateProfile",
                    data: formData,
                    dataType: "json",
                    success: function (response) {
                        if (response.status === "success") {
                            alert("Cập nhật thành công!");
                            $(".avt .welcomeName strong").text(response.updatedUser.userName);
                            $("#homePageSection h5 strong").text(response.updatedUser.userName);
                            $(".editable").each(function () {
                                let p = $(this).find("p");
                                let input = $(this).find("input");
                                let select = $(this).find("select");
                                if (p.length && input.length) {
                                    p.text(input.val());
                                    p.show();
                                    input.hide();
                                }
                                if (select.length) {
                                    p.text(select.find("option:selected").text());
                                    p.show();
                                    select.hide();
                                }
                            });
                            $(".saveBtn").hide();
                            $(".editBtn").show();
                        } else {
                            alert("Cập nhật thất bại! Lỗi: " + (response.message || "Không rõ"));
                        }
                    },
                    error: function (xhr, status, error) {
                        let errorMessage = "Lỗi kết nối đến server!";
                        if (xhr.status === 404) {
                            errorMessage = "Không tìm thấy URL (404). Vui lòng kiểm tra lại endpoint.";
                        } else if (xhr.status === 500) {
                            errorMessage = "Lỗi máy chủ (500). Vui lòng thử lại sau.";
                        } else if (status === 'timeout') {
                            errorMessage = "Thời gian chờ kết nối hết hạn. Vui lòng kiểm tra kết nối mạng.";
                        } else if (xhr.responseText) {
                            errorMessage = "Lỗi từ server: " + xhr.responseText;
                        }
                        console.error("Chi tiết lỗi từ server:", xhr.responseText);
                        alert(errorMessage);
                    },
                    timeout: 10000 // Đặt timeout nếu server mất quá lâu để phản hồi
                });
            });

            $(".editBtn").click(function () {
                $(".editable").each(function () {
                    let p = $(this).find("p");
                    let input = $(this).find("input");
                    let select = $(this).find("select");
                    if (p.length && input.length) {
                        input.val(p.text());
                        p.hide();
                        input.show();
                    }
                    if (select.length) {
                        select.val(p.text());
                        p.hide();
                        select.show();
                    }
                });
                $(".saveBtn").show();
                $(this).hide();
            });

        });
    </script>

    <jsp:include page="components/footer.jsp"/>
</div>
</body>

</html>
