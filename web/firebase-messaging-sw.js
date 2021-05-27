importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js");

firebase.initializeApp({
    apiKey: "AIzaSyCxLKv_O4aljV8U223aihgtNb2xl2IGVmk",
    authDomain: "useful-useless.firebaseapp.com",
    databaseURL: "https://useful-useless.firebaseio.com",
    projectId: "useful-useless",
    storageBucket: "useful-useless.appspot.com",
    messagingSenderId: "775335503384",
    appId: "1:775335503384:web:2e0f5eb80b093174fd456d",
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});
