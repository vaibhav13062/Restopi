This Package is used for executing APIs in a very easy form.Handling all the status codes with a loading function built in.

## Features

- Calling APIs in in a simple form.
- Easy Loading built in.
- Handling API error codes.

## Getting started

- Set Base URL in main().
- Set enableLoading true if you want to enable loading else set to false.
```dart
Restopi.baseUrl = "gorest.co.in";
Restopi.enableLoading = true;
```
- If Enabling Loading you Need to Add Restopi().builderInit() .
```dart
MaterialApp(
title: 'Flutter Demo',
theme: ThemeData(
primarySwatch: Colors.blue,
),
builder: Restopi.builderInit(),
home: const MyHomePage(title: 'Flutter Demo Home Page'),
);
```
- If Enabling Loading you can Add design to to your Loading by using:-
```dart
 Restopi().restopiInitialize(
indicatorColor: Colors.black,
progressColors: Colors.black,
backgroundColor: Colors.blueAccent,
textColor: Colors.red,
maskColor: Colors.amber,
indicatorSize: 30,
radius: 20,
userInteractions: true,
dismissOnTap: false,
easyLoadingIndicatorType: EasyLoadingIndicatorType.circle,
easyLoadingStyle: EasyLoadingStyle.dark,
);
```

## Usage

```dart
 Restopi().hitRestopi(
    buildContext: context,
    query: {},
    body: {},
    restopiMethod: RestopiMethods.post,
    urlEndPoint: 'public/v2/users',
    headers: {"content-language": "en"},
    onFail: (value) {},
    onConnectionLost: () {},
    showLoading: true,
    onSuccess: (value) {
});
```

## Additional information

Made by :- Vaibhav Chandolia
Email:- chandolia.vaibahv@gmail.com
Website:- vaibhavchandolia.info
