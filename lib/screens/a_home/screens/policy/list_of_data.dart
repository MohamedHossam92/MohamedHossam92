import 'package:flutter/material.dart';
import 'package:the_smart_workshop/screens/a_home/screens/about_us/data.dart';

List<AboutUsData> policy = [
  AboutUsData(
      title: 'تعريف سياسة الخصوصة',
      content:
          'بيان سياسة الخصوصية هذا يوضح كيف يستخدم و يحمي تطبيق الورشة الذكية أي معلومات يتم جمعها عند استخدام هذا التطبيق . ويلتزم تطبيق الورشة الذكية بضمان حماية خصوصيتك ومعلوماتك. حيث سوف يطلب منك تقديم بعض المعلومات التي يمكن التعرف من خلالها على هويتك عند استخدام هذا التطبيق ، ولن يتم استخدام هذه المعلومات إلا وفقاً لبيان سياسة الخصوصية. علماَ أنه قد تتغير سياسة الخصوصية من وقت لآخر عن طريق تحديث هذه الصفحة فيجب عليك مراجعة هذه الصفحة من وقت لآخر للتأكد من مناسبة هذه التغييرات لاستخدامك .',
      icon: Icons.label,
      color: Colors.green),
  AboutUsData(
      title: 'البيانات التي يتم جمعها',
      content: 'نحن نقوم بجمع البيانات التالية :-' +
          '\n\n•	الإسم – رقم الهاتف – البريد الألكتروني – العنوان – الموقع الجغرافي .' +
          '\n\n•	ونجمع أيضا نوع العضوية وتخصص عملك .' +
          '\n\nوذلك تدخلها بنفسك عند التسجيل في التطبيق .',
      icon: Icons.account_box,
      color: Colors.red),
  AboutUsData(
      title: 'استخدام بياناتك الخاصة',
      content: 'نجمع هذه البيانات لتقديم خدمة أفضل لك في استخدام التطبيق مثل :-' +
          '\n\n•	استخدام البريد الألكتروني لاستعادة كلمة المرور الخاصة بك عن الحاجة لذلك .' +
          '\n\n•	استخدام رقم الهاتف في التواصل معك من قبل مستخدمي التطبيق للحصول علي الخدمات التي تقدمها أنت داخل التطبيق ويكون ذلك بموافقة مسبقة منك .' +
          '\n\n•	استخدام العنوان والموقع الجغرافي في حالة رغبة أحد مستخدمي التطبيق للوصول إلي مكانك لتبادل خدمة أو عمل تجاري بينكم .' +
          '\n\n•	نوع العضوية وتخصص عملك نحتاجه في تقديم الخدمة المناسبة التي تلبي احتياجاتك فالفني يتمتع بخدمات فنية مثل التخصيمات والمعرض علي سبيل المثال بينما التاجر يتمتع بالخدمات التجارية من تلقي طلبات الشراء والإضافة إلي دليل التجار. ' +
          '\n\n•	قد نستخدم عنوانك وتخصصك في الرسائل الترويجية للمنتجات الجديدة والعروض الخاصة بالمُعلنين عن طريق ارسالها داخل التطبيق .' +
          '\n\n•	قد نستخدم معلومات التواصل الخاصة بك لعمل دراسة ميدانية بهدف تحسين مستوي الخدمة أو التسويق .',
      icon: Icons.message,
      color: Colors.blue),
  AboutUsData(
      title: 'تعاملاتك وبياناتك الخاصة',
      content: 'هناك بعض التعاملات التي تتسم بشدة الخصوصية لمستخدمي التطبيق مثل :-' +
          '\n\n •	حسابات العملاء الخاصة بك ، نضمن لك سرية تامة لمعلومات العملاء الخاصة بك ويتم تشفيرها بطريقة تضمن لك سريتها .' +
          '\n\n •	معرض الصور ، هو معرض خاص بك غير مسموح لأحد غيرك بالاطلاع علي المحتوي الخاص به .' +
          '\n\n •	التخصيمات ، هي عملية لا يتم تسجيلها ويتم حذف محتوياتها فور الخروج منها .' +
          '\n\n •	طلبات الشراء ، عمليات الشراء هي عملية شديدة الخصوصية علي مستوي البائع والمشتري لذا تتسم بالخصوصية .' +
          '\n\n •	ملتقي الفنيين ، تتيح لك هذه الخدمة التواصل مع الفنيين حال احتاجت لذلك وتبادل الخدمات والمعلومات واذا قمت باضافة محتوي فإنه يصبح عام ومتاح لمستخدمي التطبيق .' +
          '\n\n •	الدعم الفني , نضمن لك داخل الدعم الفني الحصول علي إجابات لكل استفساراتك وأسألتك دون معرفة السائل ولا اي معلومات عنه .' +
          '\n\n •	دليل التجار ، يتيح للتاجر الظهور في دليل التجار بمجرد تسجيله تصبح بياناته عامة ومتاحة للجميع ويمكنه حذف نفسه من دليل التجار من خلال الإعدادات الخاصة به.',
      icon: Icons.work,
      color: Colors.pink),
  AboutUsData(
      title: 'ضمان حماية بياناتك',
      content:
          'نضمن لك ضمان بياناتك الخاصة  من الوصول إليها أو الكشف عنها من أي جهة غير مصرح بها لذلك , واتخذنا جميع الإجراءات الإلكترونية لحماية وتأمين المعلومات التي يتم جمعها من خلال التطبيق .' +
              '\n\n جميع بيانات التواصل الخاصة بك متاحة لزائري الملف الشخصي الخاص بك وذلك لسهولة التعامل والتواصل وتبادل الخدمات بين مستخدمي التطبيق .',
      icon: Icons.local_police,
      color: Colors.blueGrey),
  AboutUsData(
      title: 'استخدام ملفات الكوكيز',
      content:
          'ملفات الكوكيز هي ملفات صغيرة يطلب منك السماح بوضعها على المساحة التخزينية الخاصة بهاتفك المحمول . بمجرد الموافقة ، يتم إضافتها مما يساعد  على تحليل حركة المرورداخل التطبيق و يتيح لك معرفة متى قمت بزيارة موقع معين . ملفات الكوكيز تسمح لتطبيقات الويب للرد عليك كفرد، وعليه يتم تخصيص التطبيق حسب احتياجاتك، معتمداً على خياراتك السابقة والخدمات التي تتعامل بها أغلب وقتك .' +
              '\n\nنحن نستخدم ملفات الكوكيز لتسجيل حركة المرور وتحديد الصفحات التي تم زيارتها، مما يساعدنا على تحليل البيانات حول حركة المرور على الويب وتحسين التطبيق  حسب إحتياجاتك . نحن فقط نستخدم هذه المعلومات لأغراض التحليل الإحصائي ومن ثم يتم إزالة البيانات من النظام. .',
      icon: Icons.code,
      color: Colors.redAccent),
  AboutUsData(
      title: 'روابط لمواقع أخرى',
      content:
          'قد يحتوي التطبيق على روابط لمواقع أخرى . نريد لفت إنتباهك بأننا غير مسؤولين عن حماية خصوصية بياناتك التي قد تقدمها أثناء زيارتك لتلك المواقع ، وهذه المواقع لا تخضع لبيان الخصوصية هذا.',
      icon: Icons.account_tree,
      color: Colors.purple),
  AboutUsData(
      title: 'مشاركة بياناتك مع أحد',
      content:
          'نحن لا نتاجر ببيع أو توزيع أو تأجير بياناتك الشخصية لأطراف ثالثة ما لم نحصل على موافقتك أو يقضي به القانون للقيام بذلك. نحن نستخدم بياناتك الشخصية لإرسال معلومات عن العروض والمستجدات داخل التطبيق .',
      icon: Icons.share,
      color: Colors.teal),
  AboutUsData(
      title: 'تعديل سياسة الخصوصية',
      content:
          'لنا الحق في تعديل بنود سياسة الخصوصية إذا لزم الأمر ومتى كان ذلك مهماً , وسيتم نشر هذه التعديلات هنا ونقوم بإخطارك بذلك ولك الحق في القبول أو رفض ذلك .',
      icon: Icons.edit,
      color: Colors.indigo),
  AboutUsData(
      title: 'أخيراً :-',
      content:
          'إن مخاوفك واهتمامك بشأن سرية وخصوصية البيانات تعتبر مسألة في غاية الأهمية بالنسبة لنا ونأمل في تحقيق ذلك من خلال هذه السياسة .',
      icon: Icons.fiber_manual_record,
      color: Colors.pink),
];