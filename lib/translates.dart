const kGeneralTranslates = {
  'done': {'az': 'Tamam', 'en': 'Done'},
  'get_started': {'az': 'Başla', 'en': 'Get started'},
  'next': {'az': 'Növbəti', 'en': 'Next'},
  'send_code': {'az': 'Kodu göndər', 'en': 'Send code'},
  'back': {'az': 'Geri', 'en': 'Back'},
  'set_name': {'az': 'Ad qeyd et', 'en': 'Set name'},
  'cancel': {'az': 'Ləğv et', 'en': 'Cancel'},
  'apply': {'az': 'Tətbiq et', 'en': 'Apply'},
  'details': {'az': 'Detallar', 'en': 'Details'},
  'close': {'az': 'Bağla', 'en': 'Close'}
};
const kMapPageTranslates = {
  'no_info': {
    'az': 'İnformasiya yoxdur',
    'en': 'No information',
    'ru': 'No iformation ru'
  },
  'where_to': {'az': 'Haraya?', 'en': 'Where to?'},
  'work': {'az': 'İş', 'en': 'Work'},
  'home': {'az': 'Ev', 'en': 'Home'},
  'last_adress': {'az': "Ən son", 'en': "Last"},
  'search_location': {'az': 'Adresi axtar', 'en': 'Search location'},
  'select_location': {'az': 'Adresi seç', 'en': 'Select location'},
  'choose_on_map': {'az': 'Xəritədən seç', 'en': 'Choose on map'}
};

const kOrderTranslates = {
  'moped': {'az': 'Moped', 'en': 'Moped'},
  'motorcycle': {'az': 'Motosikl', 'en': 'Motorcycle'},
  'payment_method': {'az': 'Ödəniş metodu', 'en': 'Payment method'},
  'cancel_order_search': {
    'az': 'Sifariş axtarışını ləğv et',
    'en': 'Cancel order search'
  },
  'your_driver_is': {'az': 'Sürücünüz:', 'en': 'Your driver is'},
  'your_trip': {'az': 'Səyahətiniz', 'en': 'Your trip'},
  'pick_up': {'az': 'Götür', 'en': 'Pick up'},
  'drop_off': {'az': 'Qoy', 'en': 'Drop off'},
  'call': {'az': "Zəng et", 'en': 'Call'},
  'min_left': {'az': 'Dəqiqə qaldı', 'en': 'min left'},
  'change_destination': {
    'az': 'Adresi dəyiş',
    'en': 'Change destination'
  },
  'ride_completed': {'az': 'Səyahət başa çatdı', 'en': 'Ride completed'},
  'how_was_trip': {'az': 'Səyahətiniz necə idi?', 'en': 'How was your trip?'},
  'write_your_comment': {
    'az': "Şərh bildirin",
    'en': 'Write your comment'
  },
  'tip': {'az': 'Çay pulu', 'en': 'Tip'},
  'help_us': {
    'az':
        'Sizə servisimizi daha yaxşı etmək üçün bu səyahətə dərəcə bildirin',
    'en':
        'Help us improve our services and your experiences by rating this trip.'
  },
  'your_trip_will': {
    'az': 'Səyahətləriniz burada qeyd olunacaqdır',
    'en': 'Your trip will appear here'
  },
  'swipe_to_accept': {'az': 'Qəbul etmək üçün sürüşdürün', 'en': 'Swipe to accept'},
  'swipe_to_start': {
    'az': 'Başlamaq üçün sürüşdürün',
    'en': 'Swipe to start trip'
  },
  'swipe_to_end': {'az': 'Bitirmək üçün sürüşdürün', 'en': 'Swipe to end trip'},
  'your_trip_is_with': {
    'az': 'Sürücünüz:',
    'en': 'Your trip is with'
  },
  'end_of_trip': {'az': 'Səyahətin sonu', 'en': 'End of trip'},
  'payment_with_card': {
    'az': 'Ödəniş nəğdsizdir',
    'en': 'Payment is with card'
  },
  'payment_with_cash': {
    'az': 'Ödəniş nəğddir',
    'en': "Payment is with cash"
  },
  'your_trip_was': {'az': 'Səyahətiniz:', 'en': 'Your trip was'},
};
const kMenuTranslates = {
  'become_driver': {
    'az': 'Sürücü ol',
    'en': 'Become driver',
  },
  'become_customer': {
    'az': 'Müştəri ol',
    'en': 'Become customer',
  },
  'edit_profile': {'az': 'Profili redaktə et', 'en': 'Edit profile'},
  'payments': {
    'az': 'Ödənişlər',
    'en': 'Payments',
  },
  'promotions': {'az': 'Endirim kodları', 'en': 'Promotions'},
  'ride_history': {'az': 'Səyahət tarixçəsi', 'en': 'Ride history'},
  'support': {'az': 'Əlaqə', 'en': 'Support'},
  'terms_conditions': {
    'az': 'Şərtlər və Qaydalar',
    'en': 'Terms & Conditions'
  },
  'privacy_policy': {'az': 'Məxfilik qaydaları', 'en': 'Privacy & Policy'},
  'add_card': {'az': 'Kart əlavə et', 'en': 'Add card'},
  'card_number': {'az': 'Kart nömrəsi', 'en': 'Card number'},
  'expiry_date': {'az': 'Bitmə tarixi', 'en': 'Expiry date'},
  'secure_code': {'az': 'Təhlükəsiz kod', 'en': 'Secure code'},
  'new_card': {'az': 'Yeni kart', 'en': 'New card'},
  'get_free_rides': {'az': 'Pulsuz gediş qazan', 'en': "Get free rides"},
  'enter_promo_code': {'az': 'Promo kodunu daxil et', 'en': "Enter promo code"},
  'you_have1': {'az': 'Sizin', 'en': 'You have'},
  'you_have2': {'az': 'Pulsuz gedişiniz var', 'en': 'free rides'},
  'invite1': {'az': 'Dostunu dəvət et və', 'en': 'Invite a friend and get'},
  'invite2': {
    'az': 'AZN qazan!',
    'en': 'AZN off your next trip!'
  },
  'enter_code': {'az': 'Kodu daxil et', 'en': 'Enter code'},
  'invite_your_friend': {
    'az': "Dostunu dəvət et",
    'en': 'Invite your friend'
  },
  'promo_code': {'az': 'Promo kodu', 'en': 'Promo code'},
  'enter_code2': {
    'az': 'Növbəti gedişdə endirim qazanmaq üçün kodu daxil et',
    'en': 'Enter the code and it will be\napplied to your next ride.'
  },
  'ride_details': {'az': 'Səyahətin detalları', 'en': 'Ride details'},
  'from': {'az': 'Başlanğıc', 'en': 'From'},
  'to': {'az': 'Son', 'en': 'To en'},
  'payment_method': {'az': 'Ödəniş metodu', 'en': 'Payment method'},
  'payment': {'az': 'Ödəniş', 'en': '{Payment'},
  'report_a_problem': {'az': 'Problem bildir', 'en': 'Report a problem'},
  'select_your_ride': {'az': 'Select your ride az', 'en': 'Select your ride'},
  'contact_us': {'az': 'Bizimlə əlaqə', 'en': 'Contact us'},
  'faq': {'az': 'Tez-tez verilən suallar', 'en': 'FAQ'},
  'general_terms': {'az': 'Ümumi qaydalar', 'en': 'General terms'}
};
const kOnboardingScreen = {
  'welcome': {
    'az': 'Xoş gəldiniz!',
    'en': 'Welcome',
  },
  'our_community': {
    'az': 'Bizim Ortaqlıq',
    'en': 'Our Community',
  },
  'title1': {
    'az': 'Başlıq 1',
    'en': 'Title1 en',
  },
  'title2': {
    'az': 'Başlıq 2',
    'en': 'title2 en',
  },
  'description1': {
    'az': 'description 1 az',
    'en': 'description 1 en',
  },
  'description2': {
    'az': 'description 2 az',
    'en': 'description 2 en',
  },
  'enter_phone': {
    'az': 'Nömrəni qeyd et',
    'en': 'Enter your phone number'
  },
  'we_will_send_you': {
    'az': 'Sizə təhlükəsiz kodu göndəriləcək.',
    'en': 'We’ll send you a verification code to your phone.'
  },
  'enter_verification_code': {
    'az': 'Təhlükəsiz kodu qeyd et',
    'en': 'Enter verification code'
  },
  'code_has_been_sent': {
    'az': 'Təhlükəsiz kodu',
    'en': 'A code has been sent to'
  },
  'via_sms': {'az': 'SMS ilə göndərildi', 'en': 'via SMS'},
};
const kInputTranslates = {
  'fullname': {'az': 'Ad və Soyad', 'en': 'Fullname'},
};
