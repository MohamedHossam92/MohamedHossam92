const String sWTal = 'رسالة من تطبيق  \n- الورشة الذكية - The Smart Workshop';

String whatsApp({phone, message}) =>
    'https://wa.me/2$phone?text=$sWTal \n $message';
