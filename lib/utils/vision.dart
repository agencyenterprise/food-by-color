import 'package:dio/dio.dart';

final token =
    'ya29.c.b0AXv0zTPdjSJa4TzxcrIHM37xuNKY_-VqUG33PNP_AwVVNhGSNbWYvCgWdf-G4YeFiAwiVlZnkAWh4qCa7soyoqsVlJwMUvz1g398jjkfl7NtpjMQR8cpl9vBVJ8nqn6x_BvXkMsA_8BMygKC08ooHptjjM0V8tfYZNugNXdpgugFQEB1sKtxwxzoPoSGSeJQiQOHo0xDd115utdy8GsIh9JRFMiKfmc';

Dio dio = new Dio();

// mostly green plate
// https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F44%2F2020%2F08%2F06%2F8427526.jpg

// meat only plate
// https://ak.picdn.net/shutterstock/videos/3932522/thumb/1.jpg

dynamic getImageProperties() async {
  dio.options.headers['authorization'] = token;

  try {
    var response = await dio
        .post('https://vision.googleapis.com/v1/images:annotate', data: {
      "requests": [
        {
          "features": [
            {
              "maxResults": 10,
              "type": "IMAGE_PROPERTIES",
            }
          ],
          "image": {
            "source": {
              "imageUri":
                  "https://ak.picdn.net/shutterstock/videos/3932522/thumb/1.jpg"
            }
          }
        }
      ]
    });

    return response.data;
  } catch (e) {
    print(e);
  }
}
