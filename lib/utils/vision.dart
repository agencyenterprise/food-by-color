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
              "Bearer ya29.c.b0AXv0zTM4AMpi0QoNFQFadPdYC3nHrZ29_KdWh9IuI6loINxIeuG12iVZkRj5htw2Pim5S4cSIQXJO5SYDMSLtLa_mJDi_OuPxxKHSHgy2DKnXbtxh7azyuCgOQswMXqn7-lolfK82bdzF8o-aFZDP1bkIZ-iOurHp4ntoshvwpmIUbr8mH456SKzqkYWK2p8is3nOC12Z2SmLvLRN5CmcwW9M27078c",
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
