import 'package:dio/dio.dart';

Dio dio = new Dio();

// mostly green plate
// https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F44%2F2020%2F08%2F06%2F8427526.jpg

// meat only plate
// https://ak.picdn.net/shutterstock/videos/3932522/thumb/1.jpg

dynamic getImageProperties() async {
  dio.options.headers['authorization'] =
      'Bearer ya29.c.b0AXv0zTObBz7GcgFkFEoRFEbshbrfvu0jHP-e82Zpq9nMwck6f12G1MaZXACSBDlL2QlHXxitQku84f57kwYt_Fog1OkNscHxmWjQpH2dB0kIaWk3k941aJlZTXTMrNH_E5DtHcUjI8NrOJspyWLQKAkqJpCwH_d2R7_GISaY-0D-DVQ7H0ujQ3_0WGFGsI8m52GoYP-DOZC7jg0js0NRQEV_vcsi1ZE';
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
