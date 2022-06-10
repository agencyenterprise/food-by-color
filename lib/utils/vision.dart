import 'package:dio/dio.dart';

// prato sem verdura
//http://www.tendergrassfedmeat.com/wp-content/uploads/2011/11/my-plate-20111107_0001.jpg

dynamic getImageProperties(base64image) async {
  try {
    Dio dio = new Dio();
    var response = await dio.post(
      'https://vision.googleapis.com/v1/images:annotate',
      data: {
        "requests": [
          {
            "features": [
              {
                "maxResults": 20,
                "type": "IMAGE_PROPERTIES",
              }
            ],
            "image": {"content": base64image}
          }
        ]
      },
      options: Options(
        headers: {
          "authorization":
              "Bearer ya29.c.b0AXv0zTP_UdyHX-icqMpDmaBUvfAAp0x_4XE5O_IH6xq6LHr5tOM8xb_koSKaaG2x2LCNfKOpKttHXZ_pjR9UdyFhsr-14nKfC6pGmz232rhfTGHnSHZLZN6gro2deRT5mTL8KRldvlKRjTUNvzjdKyEM5sXUoT-9n9yvgqyeqodr1c-EZzGEoAg5GP0Gxf1Q2KUodya6BRNjZNcDMSage0kO3DS17m0",
        },
        receiveTimeout: 10000,
        sendTimeout: 10000,
      ),
    );

    return response.data;
  } catch (e) {
    print(e);
  }
}
