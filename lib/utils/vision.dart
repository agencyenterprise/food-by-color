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
                "maxResults": 10,
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
              "Bearer ya29.c.b0AXv0zTNXc6MrMze_3ZUBnFTQtDUCN74I92BP7fKV9NMhe-SnMDi3jtc75Cqyds-2SF5rWWFpktARf-4gFyfRV4m5E3fmMHbWiC2l8qdrtwJw_xxJrRLVThxwhJ9NbfoIMmJa0VAwpq8r6r_OBf0W4jR6mNBviVNeqeZRTjnCGM3ELQwqhVSslF3VhtIbM_mHks5YrbAORxNAvdt5BAp_0tfLP6nY9X0",
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
