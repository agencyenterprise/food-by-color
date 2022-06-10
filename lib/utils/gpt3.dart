import 'package:dio/dio.dart';

Future<String> getAnswer(properties) async {
  print(properties);
  try {
    final colors = (properties['responses'][0]['imagePropertiesAnnotation']
            ['dominantColors']['colors'] as List)
        .toList();
    print('colors');
    print(colors);
    var prompt = 'If my food plate has foods with the color';

    for (int i = 0; i < colors.length; i++) {
      if (i == colors.length - 1) {
        prompt =
            '$prompt RGB(${colors[i]['color']['red']}, ${colors[i]['color']['green']}, ${colors[i]['color']['blue']})';
      } else {
        prompt =
            '$prompt RGB(${colors[i]['color']['red']}, ${colors[i]['color']['green']}, ${colors[i]['color']['blue']}), and ';
      }
    }

    prompt =
        '${prompt}. What are the foods that my food plate is lacking? Then give some examples of the foods that my plate is lacking.';
    // prompt = '${prompt}. Then tell me what colors i lack and then list the categories of foods that have the colors i am lacking and then give me examples of foods on those categories.';
    prompt = prompt.replaceAll(', and a type of food with .', '.');

    print('prompt');
    print(prompt);

    var dio = Dio();
    var response = await dio.post(
      'https://api.openai.com/v1/completions',
      data: {
        "model": "text-davinci-002",
        "prompt": prompt,
        "temperature": 0,
        "max_tokens": 256,
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "authorization":
              "Bearer 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",
        },
      ),
    );
    var respText = response.data['choices'][0]['text'].toString();

    return respText;
  } catch (err) {
    print('err gpt3');
    print(err);
    return 'Unable to get an answer';
  }
}
/**
 {
  "responses": [
    {
      "imagePropertiesAnnotation": {
        "dominantColors": {
          "colors": [
            {
              "color": {
                "red": 243,
                "green": 177,
                "blue": 133
              },
              "score": 0.18074834,
              "pixelFraction": 0.013533333
            },
            {
              "color": {
                "red": 204,
                "green": 205,
                "blue": 213
              },
              "score": 0.092455424,
              "pixelFraction": 0.19266666
            },
            {
              "color": {
                "red": 114,
                "green": 77,
                "blue": 64
              },
              "score": 0.090447456,
              "pixelFraction": 0.034133334
            },
            {
              "color": {
                "red": 224,
                "green": 57,
                "blue": 64
              },
              "score": 0.010952942,
              "pixelFraction": 0.014266667
            },
            {
              "color": {
                "red": 248,
                "green": 125,
                "blue": 130
              },
              "score": 0.006984347,
              "pixelFraction": 0.0057333335
            },
            {
              "color": {
                "red": 150,
                "green": 107,
                "blue": 92
              },
              "score": 0.081589326,
              "pixelFraction": 0.019666666
            },
            {
              "color": {
                "red": 233,
                "green": 185,
                "blue": 158
              },
              "score": 0.08035342,
              "pixelFraction": 0.0122
            },
            {
              "color": {
                "red": 221,
                "green": 221,
                "blue": 226
              },
              "score": 0.045200635,
              "pixelFraction": 0.202
            },
            {
              "color": {
                "red": 105,
                "green": 77,
                "blue": 75
              },
              "score": 0.030223774,
              "pixelFraction": 0.013866667
            },
            {
              "color": {
                "red": 189,
                "green": 145,
                "blue": 123
              },
              "score": 0.028689377,
              "pixelFraction": 0.0069333334
            }
          ]
        }
      },
      "cropHintsAnnotation": {
        "cropHints": [
          {
            "boundingPoly": {
              "vertices": [
                {
                  "x": 1020
                },
                {
                  "x": 1972
                },
                {
                  "x": 1972,
                  "y": 1699
                },
                {
                  "x": 1020,
                  "y": 1699
                }
              ]
            },
            "confidence": 0.71875006,
            "importanceFraction": 0.5688889
          }
        ]
      }
    }
  ]
}

 */