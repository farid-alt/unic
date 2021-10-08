String TOKEN =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC91bmlrLm5lb3N0ZXAuYXpcL2FwaVwvdmVyaWZpY2F0aW9uLWNvbmZpcm0iLCJpYXQiOjE2MjU3MzEzMTAsImV4cCI6MTYyNTczNDkxMCwibmJmIjoxNjI1NzMxMzEwLCJqdGkiOiJRNXgxTDVrT2FrT1Y3WldVIiwic3ViIjo1LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.r6mrWZuXksUoCooL40lxhj2xaeDpieUVMk5C8dbind4';
String LANGUAGE = 'az';
String ID = '2';
String DRIVERID;
const String HOST = 'https://unikeco.az';
const String LOGIN = 'https://unikeco.az/api/login';
const String CODE_CONFIRM = 'https://unikeco.az/api/verification-confirm';
const String ADD_FULLNAME = 'https://unikeco.az/api/add-full-name';
const String GET_FAQ = 'https://unikeco.az/api/faq?locale=az';
const String GET_TERMS = 'https://unikeco.az/api/terms-of-conditions';
const String CONTACT_US = 'https://unikeco.az/api/contact-us';
const String ADD_CREDIT_CARD =
    'https://unikeco.az/api/customer/add-credit-card';
const String ACTIVE_CARD = 'https://unikeco.az/api/customer/change-credit-card';
const String SEND_SUPPORT_MESSAGE =
    'https://unikeco.az/api/send-support-message';
const String GET_USER = 'https://unikeco.az/api/user';
const String CALCULATE_ORDER = 'https://unikeco.az/api/order/calculate-order';
const String CREATE_ORDER = 'https://unikeco.az/api/order/create-edit-order';
const String ACCEPT_ORDER = 'https://unikeco.az/api/order/accept-driver-order';
const String PICK_UP = 'https://unikeco.az/api/order/pick-up-driver-order';
const String COMPLETE_ORDER =
    'https://unikeco.az/api/order/complete-driver-order';
// const String CANCEL_ORDER =
//     'https://unikeco.az/api/order/cancel-driver-order';
const String SEND_PROMO = 'https://unikeco.az/api/customer/add-promo-code';
const String SEND_USER_DATA =
    'https://unikeco.az/api/customer/change-customer-data';
const String SEND_DRIVER_DATA =
    'https://unikeco.az/api/driver/change-driver-data';

//ORDER CUSTOMER
const String CANCEL_ORDER_CUSTOMER =
    'https://unikeco.az/api/order/cancel-customer-order';
const String SEND_REVIEW_CUSTOMER =
    'https://unikeco.az/api/order/add-rating-tip-driver-order';

//ORDER DRIVER
const String CANCEL_ORDER_DRIVER =
    'https://unikeco.az/api/order/cancel-driver-order';
const String CHANGE_ONLINE = 'https://unikeco.az/api/driver/change-online';
const String DRIVER_POSITION = 'https://unikeco.az/api/driver/location-driver';
