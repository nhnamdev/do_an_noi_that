package vn.edu.hcmuaf.fit.sourcedoannoithat.service;


import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

// call api tu giao hang nhanh
public class GHNService {
    private static final String shippingAPI = "https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee";
    private static final String provinceURL = "https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/province";
    private static final String districtURL = "https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/district";
    private static final String wardURL = "https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id";
    private static final String token = "51e4eb39-1367-11f0-95d0-0a92b8726859";
    private static final String shopID = "196340";

    public static String getProvinces() throws IOException {
        return executeRequest(new URL(provinceURL), "GET");
    }

    public static String getDistricts(String provinceId) throws IOException {
        URL url = new URL(districtURL + "?province_id=" + provinceId);
        return executeRequest(url, "GET");
    }

    public static String getWards(String districtID) throws IOException {
        URL url = new URL(wardURL);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setRequestProperty("Token", token);
        connection.setDoOutput(true);

        try (OutputStream os = connection.getOutputStream()) {
            String jsonInputString = "{\"district_id\":" + districtID + "}";
            byte[] input = jsonInputString.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        return executeRequest(connection);
    }

    public static String calculateShippingFee(int fromDistrictId, String fromWardCode,
                                              int toDistrictId, String toWardCode,
                                              int weight, int length, int width, int height) throws IOException {
        URL url = new URL(shippingAPI);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setRequestProperty("Token", token);
        connection.setRequestProperty("ShopId", shopID);
        connection.setDoOutput(true);

        // service_type_id=5 dung de giao hang nang, ma noi that thi tat nhien nang r
        String jsonInputString = String.format(
                "{"
                        + "\"service_type_id\":2,"
                        + "\"from_district_id\":%d,"
                        + "\"from_ward_code\":\"%s\","
                        + "\"to_district_id\":%d,"
                        + "\"to_ward_code\":\"%s\","
                        + "\"weight\":%d,"
                        + "\"length\":%d,"
                        + "\"width\":%d,"
                        + "\"height\":%d,"
                        + "\"insurance_value\":0,"
                        + "\"items\": ["
                        + "  {"
                        + "    \"name\": \"Sample Item\","
                        + "    \"code\": \"ITEM01\","
                        + "    \"quantity\": 1,"
                        + "    \"weight\": %d,"
                        + "    \"length\": %d,"
                        + "    \"width\": %d,"
                        + "    \"height\": %d"
                        + "  }"
                        + "]"
                        + "}",
                fromDistrictId, fromWardCode, toDistrictId, toWardCode,
                weight, length, width, height,
                weight, length, width, height
        );

        try (OutputStream os = connection.getOutputStream()) {
            byte[] input = jsonInputString.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        return executeRequest(connection);
    }

    private static String executeRequest(URL url, String method) throws IOException {
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod(method);
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setRequestProperty("Token", token);
        return executeRequest(connection);
    }

    private static String executeRequest(HttpURLConnection connection) throws IOException {
        int responseCode = connection.getResponseCode();
        InputStream inputStream = responseCode == HttpURLConnection.HTTP_OK ?
                connection.getInputStream() : connection.getErrorStream();

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            return responseCode == HttpURLConnection.HTTP_OK ?
                    response.toString() :
                    "{\"code\": " + responseCode + ", \"message\": \"" + response.toString() + "\"}";
        }
    }

    // call api theo tham so mac dinh
    public static void main(String[] args) {
        try {
            String result = GHNService.getProvinces();
            System.out.println(result);

            // Test API quan/huyen provinceId = 201 (TP.HCM)
            String districtResult = GHNService.getDistricts("201");
            System.out.println(districtResult);

            // Test API phuong/xa districtId = 1442 (Q1)
            String wardResult = GHNService.getWards("1442");
            System.out.println(wardResult);

            System.out.println(calculateShippingFee(1442, "20101", 3440,
                    "20110", 1700, 10, 10, 10));

        } catch (Exception e) {
            System.err.println("Lỗi: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
