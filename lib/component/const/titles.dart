import 'dart:io';

const String sWTal = 'رسالة من تطبيق  \n- الورشة الذكية - The Smart Workshop';

String whatsApp({String? phone, message}) {
  if(!phone!.startsWith('+2')){
    phone = '+2' + phone;
  }
  return Platform.isIOS ? 'https://api.whatsapp.com/send?phone=$phone=${Uri.parse('رسالة من تطبيق - الورشة الذكية - The Smart Workshop')}' : 'https://wa.me/2$phone?text=$sWTal \n $message';
}
