# Food color scan

The color of food can tell a lot about it, from what type of nutrients it might contain, to how fresh it is, so this app extrapolates the concept of checking if a meal is balanced by observing it's colors. You can take a picture of your food plate and the app will try to suggest what kinds of food the plate might be lacking, it's a quick and fun way to have some insight in what you normally lack on your meals.


## Up and running

```
$ git clone git@github.com:agencyenterprise/food-by-color.git
```
Go to the repo root folder
```
$ flutter pub get
```
Connect your phone or open android emulator (camera on emulator will be just a placeholder)
```
$ flutter run
```
## Tools and dependencies
* dio
* go_router
* flutter_bloc
* camera

* Google GPT3 api: The app uses gpt3 to make the suggestions, so you need an api key for this api: https://api.openai.com/v1/completions

* Google vision image api: https://vision.googleapis.com/v1/images:annotate: 

Google vision image api is not free, so to run it you need to pay for a apikey or if you just want to test you can generate a gcloud apikey that lasts 30 minutes by following this docs: https://cloud.google.com/docs/authentication/getting-started


## Production URL (will only if you changed the apikey to a valid one in this file /lib/utils/vision.dart)
https://www.foodcolorscan.com/