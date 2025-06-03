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
                    <img src="img/avt/avt.jpg" alt="">
                    <div class="welcomeName">
                        <h5>Welcome<br><strong>${sessionScope.userName}</strong></h5>
                    </div>
                </div>
                <div class="address" id="homePage"><h5><i class="fa fa-home"></i>TRANG TÀI KHOẢN</h5></div>
                <a href="orderInformation" class="button">
                    <div class="address"><h5><i class="fa fa-box"></i> ĐƠN HÀNG</h5>
                    </div>
                </a>
                <a href="contact.jsp" class="button">
                    <div class="address"><h5><i class="fa fa-location-dot"></i> ĐỊA CHỈ</h5>
                    </div>
                </a>
                <a href="shop?onlyFavorite=true" class="button">
                    <div class="address"><h5><i class="fa fa-arrow-rotate-left"></i> ƯA THÍCH</h5>
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
                                        <select id="province" name="province"
                                                style="height: 35px;width: 150px; display:none;"
                                                onchange="loadDistricts()">
                                            <option value="">Chọn tỉnh/thành phố</option>
                                        </select><br>

                                        <h5 for="district" style="margin-left: 20px;margin-top: 6px">Quận/Huyện:</h5>
                                        <select id="district" name="district"
                                                style="height: 35px;width: 150px; display:none;"
                                                onchange="loadWards()">
                                            <option value="">Chọn quận/huyện</option>
                                        </select><br>
                                        <h5 for="ward" style="margin-left: 20px;margin-top: 6px">Phường/Xã:</h5>
                                        <select id="ward" name="ward"
                                                style="height: 35px;width: 150px; display:none;"
                                                onchange="saveAddressToStorage()">
                                            <option value="">Chọn phường/xã</option>
                                        </select><br>
                                    </div>
                                    <div class="col-md-12 editable">
                                        <h5 class="labels">Địa chỉ:</h5>
                                        <p id="userAddress">${sessionScope.userAddress}</p>
                                        <input type="text" name="userAddressInput" id="userAddressInput"
                                               style="display:none;" oninput="saveAddressToStorage()"/>
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
                                    <button class="saveBtn" type="submit" style="display:none;width: 30%">Lưu thông
                                        tin
                                    </button>
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
                            <a href="orderInformation" class="button">
                                <div class="box"><h5><i class="fa fa-box"></i> <br> ĐƠN HÀNG</h5></div>
                            </a>
                            <a href="contact.jsp" class="button">
                                <div class="box"><h5><i class="fa fa-location-dot"></i> <br> ĐỊA CHỈ</h5></div>
                            </a>
                            <a href="shop?onlyFavorite=true" class="button">
                                <div class="box"><h5><i class="fa fa-arrow-rotate-left"></i> <br> ƯA THÍCH</h5></div>
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
        $(document).ready(function () {
            $('#province').on('change', function () {
                loadDistricts();
                saveAddressToStorage();
            });

            $('#district').on('change', function () {
                loadWards();
                saveAddressToStorage();
            });

            $('#ward').on('change', function () {
                saveAddressToStorage();
            });

            $('#userAddressInput').on('input', function () {
                saveAddressToStorage();
            });

            $(".saveBtn").click(function (e) {
                e.preventDefault();

                let provinceId = $("#province").val();
                let districtId = $("#district").val();
                let wardCode = $("#ward").val();
                let streetAddress = $("#userAddressInput").val();

                let hasLocationChange = provinceId && districtId && wardCode;

                if ((provinceId || districtId || wardCode) && !hasLocationChange) {
                    alert("Vui lòng chọn đầy đủ Tỉnh/Thành phố, Quận/Huyện và Phường/Xã");
                    return;
                }

                let formData = {
                    userNameInput: $("#userNameInput").val(),
                    userBirthdayInput: $("#userBirthdayInput").val(),
                    userPhoneInput: $("#userPhoneInput").val(),
                    userAddressInput: streetAddress,
                    userEmailInput: $("#userEmailInput").val()
                };

                if (hasLocationChange) {
                    let provinceName = $("#province option:selected").attr('data-name') || $("#province option:selected").text();
                    let districtName = $("#district option:selected").attr('data-name') || $("#district option:selected").text();
                    let wardName = $("#ward option:selected").attr('data-name') || $("#ward option:selected").text();

                    let fullAddress = streetAddress + ", " + wardName + ", " + districtName + ", " + provinceName;

                    formData.provinceId = provinceId;
                    formData.provinceName = provinceName;
                    formData.districtId = districtId;
                    formData.districtName = districtName;
                    formData.wardCode = wardCode;
                    formData.wardName = wardName;
                    formData.fullAddress = fullAddress;

                    const addressData = {
                        provinceId: provinceId,
                        provinceName: provinceName,
                        districtId: districtId,
                        districtName: districtName,
                        wardCode: wardCode,
                        wardName: wardName,
                        streetAddress: streetAddress,
                        fullAddress: fullAddress,
                        timestamp: new Date().getTime()
                    };
                    localStorage.setItem('selectedAddress', JSON.stringify(addressData));
                }

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

                            if (response.updatedUser.userAddress) {
                                $("#userAddress").text(response.updatedUser.userAddress);
                            }

                            $("#userName").text(response.updatedUser.userName);
                            $("#userBirthday").text(response.updatedUser.userBirthday);
                            $("#userPhone").text(response.updatedUser.userPhone);
                            $("#userEmail a").text(response.updatedUser.userEmail);

                            $(".editable").each(function () {
                                let p = $(this).find("p");
                                let input = $(this).find("input");
                                if (p.length && input.length) {
                                    p.show();
                                    input.hide();
                                }
                            });

                            $("#province, #district, #ward").hide();
                            $(".saveBtn").hide();
                            $(".editBtn").show();
                            $(".editable h5").show();
                        } else if (response.status === "info") {
                            alert(response.message);
                            if (hasLocationChange) {
                                saveAddressToStorage();
                            }
                        } else {
                            alert("Cập nhật thất bại! Lỗi: " + (response.message || "Không rõ"));
                        }
                    },
                    error: function (xhr, status, error) {
                        alert("Lỗi kết nối đến server!");
                    },
                    timeout: 10000
                });
            });

            $(".editBtn").click(function () {
                $(".editable").each(function () {
                    let p = $(this).find("p");
                    let input = $(this).find("input");

                    if (p.length && input.length) {
                        input.val(p.text().trim());
                        p.hide();
                        input.show();
                    }

                    if ($(this).find("#province").length || $(this).find("#district").length || $(this).find("#ward").length) {
                        $(this).find("h5").show();
                        $(this).find("select").show();
                    }
                });

                let currentAddress = $("#userAddress").text().trim();
                parseAndSetAddress(currentAddress);

                $(".saveBtn").show();
                $(this).hide();
            });
        });
    </script>

    <jsp:include page="components/footer.jsp"/>
</div>
<script src="js/personal.js"></script>
</body>
</html>