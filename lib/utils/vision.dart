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
              "Bearer ya29.c.b0AXv0zTN_Ln_X21BC6Ju9OYPY4-OTLE6qJ156qbmHV4k7emx6X2Z9FdgffWaYS4hNDFJyd_sKrWoYPsR4nJYzTCT-tlbLXaTk2biXJ8wW28Xi1v_HJY-V3O4BrKA-Dibg5lhRV0Gwg0qtd_2807YcCLpMqhPvm9dgxwQg4q7votlN8gQMJegDPUvPOUCJR1a2GTx5oqhahObn-3JUgAlPUmQ7U2-LLhI",
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
