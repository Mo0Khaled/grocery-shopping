const functions = require('firebase-functions');
const admin= require('firebase-admin');
admin.initializeApp(functions.config().functions);
exports.orderTrigger=functions.firestore.document('orders/{orderId}').onCreate(
  async (snapshot,context) => {
      var payLoad=  {notification: {title: 'new order', body: 'mohamed app'}, data: {click_action: 'FLUTTER_NOTIFICATION_CLICK'}};
      const respone  = await admin.messaging().sendToTopic('Admin',payLoad)
  }
);
exports.finsihedOrderTrigger=functions.firestore.document('orders/{token}').onCreate(

  async (snapshot,context) => {
    var tokens = [];
    tokens.push(snapshot.data().token);
      var payLoad=  {notification: {title: 'hello user', body: 'order is ready'}, data: {click_action: 'FLUTTER_NOTIFICATION_CLICK'}};
      const respone  = await admin.messaging().sendToDevice(tokens,payLoad)
  }
);