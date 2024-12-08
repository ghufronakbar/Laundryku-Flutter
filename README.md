# Prompt 1

Untuk proyek Flutter Anda yang berfungsi sebagai aplikasi untuk sistem reservasi mesin laundry dengan berbagai kebutuhan yang cukup lengkap, berikut adalah rekomendasi mengenai *library* yang perlu dipertimbangkan dan cara *penataan direktori* yang rapi. Mengingat Anda sudah berpengalaman dengan React Native dan TypeScript, transisi ke Flutter akan sedikit berbeda, tetapi prinsip dasar pengorganisasian kode tetap serupa.

### *1. Library yang Perlu Digunakan*

Berikut adalah daftar library yang bisa digunakan untuk kebutuhan yang Anda sebutkan:

#### a. *Local Storage untuk Access Token*
- **shared_preferences**: Library ini adalah pilihan terbaik untuk menyimpan data lokal seperti access token.
  - Install: 
    yaml
    dependencies:
      shared_preferences: ^2.0.15
    

#### b. *HTTP Request untuk JSON dan Multipart/Form-Data*
- **http**: Library ini memungkinkan Anda untuk melakukan HTTP request standar (GET, POST, dll.) dalam format JSON atau multipart.
  - Install:
    yaml
    dependencies:
      http: ^0.15.0
    

  - Jika Anda ingin menggunakan fitur seperti interceptors, retry logic, dan sebagainya, Anda juga bisa menggunakan **dio**:
    yaml
    dependencies:
      dio: ^5.0.1
    

#### c. *Bottom Navigation*
- **bottom_navy_bar**: Sebuah widget yang mudah digunakan untuk bottom navigation bar yang stylish.
  - Install:
    yaml
    dependencies:
      bottom_navy_bar: ^5.0.0
    

#### d. *Card Grid Layout*
- **flutter_staggered_grid_view**: Untuk membuat grid yang fleksibel, terutama jika Anda ingin menyusun item dalam grid dengan ukuran yang berbeda.
  - Install:
    yaml
    dependencies:
      flutter_staggered_grid_view: ^0.6.1
    

#### e. *Dropdown*
- **flutter_dropdown** atau **dropdown_button2**: Untuk implementasi dropdown yang mudah digunakan.
  - Install:
    yaml
    dependencies:
      dropdown_button2: ^1.8.0
    

#### f. *Icons*
- **flutter_icons**: Library untuk menambahkan ikon dari berbagai koleksi.
  - Install:
    yaml
    dependencies:
      flutter_icons: ^2.0.0
    

#### g. *MidTrans Snap Token (Payment Gateway)*
- Untuk integrasi dengan *MidTrans*, Anda bisa menggunakan **midtrans_flutter** (jika tersedia) atau menggunakan **flutter_webview_plugin** untuk menampilkan webview untuk transaksi pembayaran. Anda bisa mengintegrasikan MidTrans Snap API backend untuk mendapatkan token dan mengarahkan pengguna untuk menyelesaikan pembayaran.
  - Install: 
    yaml
    dependencies:
      flutter_webview_plugin: ^0.4.0
    

#### h. *Pick Image (Dari Galeri atau Kamera)*
- **image_picker**: Untuk mengambil gambar dari galeri atau kamera perangkat.
  - Install:
    yaml
    dependencies:
      image_picker: ^0.8.6+1
    

#### i. *Menampilkan Gambar dengan Fallback*
- **cached_network_image**: Library ini memungkinkan Anda menampilkan gambar dari URL dengan fallback atau placeholder sebelum gambar dimuat.
  - Install:
    yaml
    dependencies:
      cached_network_image: ^3.2.0
    

#### j. *Tab Navigation (Filter berdasarkan Status)*
- **flutter_slidable** atau **tabbar**: Library ini bisa digunakan untuk navigasi tab dan filter berdasarkan status.
  - Install:
    yaml
    dependencies:
      flutter_slidable: ^0.6.0
    

#### k. *Models untuk Response API*
- **json_serializable**: Untuk serialisasi dan deserialisasi JSON otomatis ke objek model Dart.
  - Install:
    yaml
    dependencies:
      json_serializable: ^6.0.0
    dev_dependencies:
      build_runner: ^2.1.0
    

#### l. *Feedback dari Response OK (2xx) dan Error (4xx atau 5xx)*
- Anda bisa menangani response HTTP menggunakan status code, misalnya dengan **http** atau **dio** untuk memeriksa status response dan menampilkan feedback kepada pengguna.

---

### *2. Penataan Direktori yang Rapi*

Untuk menjaga proyek tetap terorganisir dan mudah dikelola, penting untuk membagi struktur direktori dengan baik. Berikut adalah contoh struktur proyek yang disarankan:


lib/
│
├── main.dart               # Entry point aplikasi
│
├── src/
│   ├── api/                # Folder untuk service API dan models
│   │   ├── api_service.dart  # File untuk meng-handle semua HTTP request
│   │   └── models/          # Folder untuk menyimpan models API
│   │       └── user.dart    # Contoh model data user
│   │       └── response.dart # Contoh model untuk response API
│   ├── screens/            # Folder untuk screens/UI
│   │   ├── home_screen.dart
│   │   ├── history_screen.dart
│   │   └── payment_screen.dart
│   ├── components/         # Komponen reusable (card, dropdown, etc.)
│   │   ├── custom_card.dart
│   │   ├── bottom_nav.dart
│   │   └── image_picker.dart
│   ├── services/           # Service untuk API dan business logic
│   │   └── auth_service.dart # Contoh file untuk authentication service
│   └── utils/              # Folder untuk utilitas, helpers, constants, dll.
│       ├── constants.dart   # Contoh file untuk menyimpan constant seperti URL API
│       └── helpers.dart     # Fungsi bantuan lainnya
└── pubspec.yaml            # File konfigurasi dependensi


### *3. Penjelasan Struktur Direktori*
- *api/*: Menyimpan semua yang terkait dengan komunikasi API, termasuk service untuk HTTP request dan models untuk response API.
- *screens/*: Menyimpan file-file untuk setiap halaman atau screen pada aplikasi.
- *components/*: Menyimpan komponen-komponen reusable seperti custom cards, navigasi, dropdown, dsb.
- *services/*: Folder ini dapat berisi file logika aplikasi, seperti autentikasi, payment gateway integration, dan lain-lain.
- *utils/*: Untuk helper functions, constants (seperti URL), dan utilities lain yang berguna.

### *4. Best Practices*
- *State Management: Menggunakan **Provider* atau *Riverpod* untuk manajemen state global, jika dibutuhkan. Anda juga bisa menggunakan *GetX* atau *Bloc* untuk solusi manajemen state yang lebih besar.
- *Responsiveness*: Pastikan desain aplikasi Anda responsif di berbagai ukuran layar (tablet, ponsel).
- *Error Handling*: Pastikan untuk menangani error dengan baik, baik itu di level API (status code 4xx, 5xx) maupun UI (misalnya koneksi internet terputus).

Dengan mengikuti struktur ini, Anda akan memiliki proyek Flutter yang lebih terorganisir dan mudah dikelola, serta bisa memanfaatkan berbagai library untuk mempercepat pengembangan aplikasi.



# Prompt 2

Di Flutter, dengan menggunakan dio, Anda dapat mengimplementasikan interceptor yang serupa dengan kode yang Anda berikan di Axios, yang memeriksa token dari penyimpanan lokal (misalnya menggunakan shared_preferences) dan menambahkannya ke header request.

Berikut adalah contoh implementasi interceptor di **dio** yang mirip dengan yang Anda buat menggunakan *AsyncStorage* atau *Cookies* pada React Native.

### Langkah-langkah Implementasi Interceptor dengan Dio di Flutter

1. *Install Paket Dio dan Shared Preferences*
   Anda akan membutuhkan dua paket utama: **dio** untuk melakukan request HTTP dan **shared_preferences** untuk menyimpan token secara lokal.

   Di pubspec.yaml, tambahkan dependensi berikut:

   yaml
   dependencies:
     dio: ^5.0.1
     shared_preferences: ^2.0.15
   

2. *Membuat Dio dengan Interceptor*
   Anda bisa menambahkan interceptor yang memeriksa apakah token ada di **shared_preferences** dan menambahkannya ke header request.

   Berikut adalah contoh implementasi yang mirip dengan Axios yang Anda tunjukkan:

### Contoh Implementasi Dio dengan Interceptor di Flutter

dart
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Fungsi untuk mengambil token dari SharedPreferences
Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('COOKIES_KEY'); // Gantilah 'COOKIES_KEY' dengan key yang sesuai
}

class DioClient {
  Dio dio;

  DioClient() : dio = Dio(BaseOptions(baseUrl: 'https://yourapi.com/api/admin')) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Ambil token dari SharedPreferences
        String? token = await getToken();
        if (token != null) {
          // Menambahkan token ke header Authorization
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options); // lanjutkan request
      },
      onResponse: (response, handler) {
        // Anda bisa menambahkan logika pada response di sini, jika diperlukan
        return handler.next(response);
      },
      onError: (DioError error, handler) {
        // Tangani error jika perlu
        return handler.next(error);
      },
    ));
  }

  // Fungsi untuk melakukan request API
  Future<Response> get(String endpoint) async {
    return await dio.get(endpoint);
  }

  Future<Response> post(String endpoint, dynamic data) async {
    return await dio.post(endpoint, data: data);
  }

  // Fungsi lainnya seperti PUT, DELETE, dll.
}



### Penjelasan Kode:
1. **getToken()**: Fungsi ini menggunakan shared_preferences untuk mengambil token yang disimpan di perangkat. Token ini digunakan untuk otentikasi setiap request.
   
2. **DioClient**: Sebuah class yang membungkus Dio. Di dalamnya terdapat konfigurasi untuk membuat instance Dio dengan BaseOptions, seperti baseUrl dan interceptor.

3. *Interceptor*:
   - *onRequest*: Sebelum request dikirim, interceptor ini akan mencoba mengambil token dari shared_preferences menggunakan getToken(). Jika token ada, token tersebut akan ditambahkan ke header request sebagai Authorization: Bearer <token>.
   - *onResponse*: Menangani response dari server, misalnya untuk logging atau manipulasi data response.
   - *onError*: Menangani error jika request gagal, seperti status code error atau masalah jaringan.

### Cara Penggunaan:
Setelah membuat DioClient, Anda dapat menggunakannya untuk melakukan request API. Berikut adalah contoh penggunaannya:

dart
void main() async {
  DioClient dioClient = DioClient();

  // Contoh GET request
  try {
    var response = await dioClient.get('/someEndpoint');
    print('Response: ${response.data}');
  } catch (e) {
    print('Error: $e');
  }

  // Contoh POST request
  try {
    var data = {'key': 'value'};
    var response = await dioClient.post('/someEndpoint', data);
    print('Response: ${response.data}');
  } catch (e) {
    print('Error: $e');
  }
}


### 4. *Menyimpan Token ke SharedPreferences*

Untuk menyimpan token ke shared_preferences, Anda dapat melakukannya seperti ini:

dart
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('COOKIES_KEY', token); // Gantilah 'COOKIES_KEY' sesuai key yang Anda gunakan
}


Dengan cara ini, Anda bisa mengelola autentikasi token menggunakan dio di Flutter dengan cara yang mirip dengan menggunakan interceptor di Axios di React Native. Ini akan memungkinkan Anda untuk menambahkan token ke semua request yang Anda kirim, dan memastikan bahwa aplikasi Anda tetap terhubung dengan server secara aman.


# Prompt 3

Tentu saja, di Flutter, Anda bisa membuat sebuah class untuk menangani otentikasi API (misalnya login dan register), yang sekaligus menangani penyimpanan *access token* ke *SharedPreferences* dan melakukan *navigasi* ke halaman lain (misalnya halaman *Home* setelah login berhasil). Konsep ini sangat mirip dengan yang ada di React Native, di mana Anda akan menangani API request, state management (untuk token), dan navigasi dalam satu alur.

Berikut adalah contoh cara membuat class AuthApi di Flutter menggunakan **Dio** untuk login dan register, menyimpan token ke **SharedPreferences*, dan melakukan **navigasi* ke halaman utama setelah berhasil login.

### Langkah-langkah

1. *Install Dependencies*
   Anda akan membutuhkan beberapa dependensi untuk API request, penyimpanan lokal, dan navigasi.

   Di pubspec.yaml, pastikan Anda sudah menambahkan dependensi berikut:

   yaml
   dependencies:
     dio: ^5.0.1
     shared_preferences: ^2.0.15
     flutter:
       sdk: flutter
     provider: ^6.0.5  # Jika menggunakan state management
   

2. **Membuat Class AuthApi**
   Class ini akan menangani semua request terkait otentikasi (login dan register) dan menyimpan token ke *SharedPreferences*.

### Contoh Implementasi AuthApi:

dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

// URL API Base
const String BASE_URL = 'https://yourapi.com/api/admin';

class AuthApi {
  final Dio dio;

  AuthApi(this.dio);

  // Fungsi untuk mengambil token dari SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // Fungsi untuk menyimpan token ke SharedPreferences
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  // Fungsi untuk login
  Future<bool> login(String username, String password, BuildContext context) async {
    try {
      var response = await dio.post(
        '$BASE_URL/login',
        data: jsonEncode({
          'username': username,
          'password': password,
        }),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        String token = response.data['access_token'];
        await saveToken(token); // Simpan token
        // Lakukan navigasi setelah login berhasil
        Navigator.pushReplacementNamed(context, '/home');
        return true;
      } else {
        // Tangani error jika ada
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  // Fungsi untuk register
  Future<bool> register(String username, String password, BuildContext context) async {
    try {
      var response = await dio.post(
        '$BASE_URL/register',
        data: jsonEncode({
          'username': username,
          'password': password,
        }),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201) {
        // Jika berhasil register, lakukan login atau navigasi
        return true;
      } else {
        // Tangani error jika ada
        return false;
      }
    } catch (e) {
      print('Register error: $e');
      return false;
    }
  }
}


### Penjelasan:

1. **login**:
   - Fungsi login mengirimkan request POST ke API untuk melakukan login.
   - Jika login berhasil (status code 200), fungsi ini menyimpan *access token* ke *SharedPreferences* dan melakukan navigasi ke halaman utama (/home) menggunakan Navigator.pushReplacementNamed.
   - Navigasi menggunakan Navigator.pushReplacementNamed akan menggantikan layar saat ini dengan halaman yang dituju, yang mirip dengan router.replace di React Native.

2. **register**:
   - Fungsi register mengirimkan request POST ke API untuk melakukan registrasi. Jika berhasil, Anda bisa melanjutkan ke layar login atau langsung login jika sudah terdaftar.

3. *Penyimpanan Token*:
   - **saveToken*: Menyimpan token yang diterima dari API ke **SharedPreferences*.
   - **getToken*: Mengambil token yang disimpan di **SharedPreferences*.

4. *Navigasi*:
   - Di dalam fungsi login, setelah menerima respons yang sukses dari server, token disimpan dan aplikasi akan otomatis melakukan navigasi ke halaman Home menggunakan Navigator.pushReplacementNamed.
   - Anda bisa mengganti /home dengan nama route yang sesuai dengan halaman utama di aplikasi Anda.

### 3. **Menggunakan AuthApi dalam Halaman Login**

Di halaman login, Anda bisa menggunakan class AuthApi untuk melakukan login ketika pengguna mengklik tombol login. Berikut adalah contoh penggunaan AuthApi di halaman login:

dart
import 'package:flutter/material.dart';
import 'auth_api.dart'; // Impor class AuthApi

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthApi authApi = AuthApi(Dio());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Panggil fungsi login dari AuthApi
                bool success = await authApi.login(
                  usernameController.text,
                  passwordController.text,
                  context,
                );
                if (!success) {
                  // Tampilkan error jika login gagal
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login failed')),
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}


### 4. *Routing dan Navigasi di Flutter*
Untuk melakukan navigasi, Anda perlu memastikan bahwa routing sudah terkonfigurasi dengan benar di aplikasi Flutter Anda. Misalnya, di main.dart, Anda bisa mengonfigurasi routing seperti ini:

dart
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart'; // Halaman Home yang akan dituju setelah login berhasil

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(), // Halaman home
      },
    );
  }
}


### 5. *Halaman Home (Sebagai contoh)*

dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(child: Text('Welcome to the Home Screen!')),
    );
  }
}


### Kesimpulan:
- Anda dapat mengimplementasikan class AuthApi untuk menangani otentikasi (login dan register) di Flutter, serta menyimpan token ke *SharedPreferences*.
- Setelah login berhasil, Anda bisa langsung melakukan navigasi ke halaman utama (Home) menggunakan **Navigator.pushReplacementNamed**.
- Class AuthApi dapat menangani proses login, penyimpanan token, dan navigasi dalam satu alur yang mirip dengan yang ada di React Native menggunakan *AsyncStorage* dan *router.replace*.

Dengan pendekatan ini, aplikasi Anda akan memiliki alur autentikasi yang lebih terstruktur dan mudah dikelola.


# Prompt 4

Pada *Dio, konsepnya sangat mirip dengan Axios. Ketika Anda melakukan request menggunakan **Dio, Anda mendapatkan objek **Response*, yang memiliki properti seperti data, headers, statusCode, dan lainnya. Selain itu, Dio juga mendukung penggunaan *generic types* seperti axios.get<ProductResponse>(), sehingga Anda dapat mendefinisikan tipe return response data.

Berikut adalah penjelasan rinci dan contoh penggunaannya:

---

### **1. Properti yang Ada di Response Dio**

Ketika Anda melakukan request dengan Dio, Dio akan mengembalikan objek *Response*, yang memiliki properti berikut:

- **data**: Data yang dikembalikan oleh server. Ini biasanya adalah body response dalam format JSON.
- **headers**: Header yang diterima dari server.
- **statusCode**: Status kode HTTP (misalnya 200, 404, dll.).
- **statusMessage**: Pesan status yang diberikan oleh server.
- **requestOptions**: Opsi request yang digunakan (misalnya URL, method, headers).
- **extra**: Informasi tambahan yang dapat Anda tambahkan ke request.

#### Contoh Penggunaan Dasar:

dart
import 'package:dio/dio.dart';

void main() async {
  var dio = Dio();
  
  try {
    Response response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');

    print('Status Code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Response Data: ${response.data}');
  } catch (e) {
    print('Error: $e');
  }
}


---

### *2. Mendefinisikan Tipe Data Response dengan Generic*

Sama seperti Axios, Dio juga mendukung *generic types* untuk response data. Ini berguna untuk memastikan bahwa data yang Anda terima memiliki tipe yang sesuai dengan model atau class Dart Anda.

#### Langkah-langkah:
1. Definisikan model atau class untuk response data.
2. Gunakan generic saat melakukan request untuk memastikan tipe data yang dikembalikan.

#### Contoh Implementasi:

Misalnya, Anda memiliki model ProductResponse:

dart
class ProductResponse {
  final int id;
  final String name;
  final double price;

  ProductResponse({
    required this.id,
    required this.name,
    required this.price,
  });

  // Factory method untuk parsing dari JSON
  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
    );
  }
}


Kemudian, Anda bisa menggunakan *generic types* saat melakukan request:

dart
import 'package:dio/dio.dart';

Future<ProductResponse> fetchProduct(int productId) async {
  var dio = Dio();

  try {
    // GET request dengan tipe generic ProductResponse
    Response<Map<String, dynamic>> response = await dio.get('https://api.example.com/products/$productId');

    // Parsing response data menjadi ProductResponse
    return ProductResponse.fromJson(response.data!);
  } catch (e) {
    throw Exception('Failed to fetch product: $e');
  }
}

void main() async {
  try {
    ProductResponse product = await fetchProduct(1);
    print('Product Name: ${product.name}');
    print('Product Price: ${product.price}');
  } catch (e) {
    print('Error: $e');
  }
}


---

### **3. Menggunakan ResponseType untuk Mengatur Tipe Data**
Dio memungkinkan Anda untuk menentukan tipe data response yang Anda harapkan dengan menggunakan **responseType**. Misalnya, jika Anda ingin menerima data sebagai JSON, string, atau byte array.

#### Contoh:

dart
import 'package:dio/dio.dart';

void main() async {
  var dio = Dio();

  // Menggunakan responseType JSON
  Response response = await dio.get(
    'https://jsonplaceholder.typicode.com/posts/1',
    options: Options(responseType: ResponseType.json),
  );

  print('Response Data: ${response.data}'); // Data dalam format JSON
}


---

### *4. Contoh Lain untuk Menggunakan List dengan Generic*
Jika response API Anda adalah sebuah array (list), Anda bisa memanfaatkan generic dengan cara berikut:

Misalkan response Anda berupa daftar produk:

json
[
  { "id": 1, "name": "Product A", "price": 100.0 },
  { "id": 2, "name": "Product B", "price": 200.0 }
]


Berikut implementasinya:

dart
Future<List<ProductResponse>> fetchProducts() async {
  var dio = Dio();

  try {
    // GET request dengan tipe generic List<ProductResponse>
    Response<List<dynamic>> response = await dio.get('https://api.example.com/products');

    // Parsing response data menjadi List<ProductResponse>
    return response.data!.map((json) => ProductResponse.fromJson(json)).toList();
  } catch (e) {
    throw Exception('Failed to fetch products: $e');
  }
}

void main() async {
  try {
    List<ProductResponse> products = await fetchProducts();
    products.forEach((product) {
      print('Product Name: ${product.name}');
      print('Product Price: ${product.price}');
    });
  } catch (e) {
    print('Error: $e');
  }
}


---

### *5. Error Handling dengan Dio*

Dio memiliki error handling yang lebih canggih dibandingkan beberapa library lain, termasuk Axios. Anda bisa menangkap exception yang terjadi selama request menggunakan try-catch dan memeriksa tipe error melalui *DioError*.

#### Contoh:

dart
try {
  var response = await dio.get('https://api.example.com/endpoint');
  print('Data: ${response.data}');
} on DioError catch (e) {
  if (e.response != null) {
    // Error dari server
    print('Server Error: ${e.response?.statusCode}');
    print('Response Data: ${e.response?.data}');
  } else {
    // Error dari jaringan atau request tidak sampai ke server
    print('Error Message: ${e.message}');
  }
}


---

### *Kesimpulan*
- *Dio* memiliki fitur mirip dengan *Axios* dalam hal properti response (data, headers, statusCode, dll.).
- Anda bisa menggunakan *generic types* untuk mendefinisikan tipe data yang diterima (Response<T>).
- *ResponseType* di Dio memungkinkan Anda menentukan format data yang diharapkan (JSON, plain text, byte array).
- Dio juga menawarkan error handling yang lebih baik dengan DioError untuk menangani berbagai jenis kesalahan (client-side, server-side, atau koneksi). 

Dio sangat fleksibel dan cocok untuk digunakan pada aplikasi Flutter yang membutuhkan manajemen request API yang canggih.

# Prompt 5

Ya, di *Dart* Anda bisa menggunakan *generic types* untuk membuat template response serupa dengan cara yang Anda lakukan di *TypeScript. Dart memungkinkan Anda untuk mendefinisikan tipe **generic* pada class, sehingga Anda dapat menggunakan tipe yang berbeda di seluruh aplikasi Anda, tergantung pada data yang diterima.

Berikut adalah contoh bagaimana Anda bisa mendefinisikan template ResponseApi yang fleksibel menggunakan generic type di Dart, yang memungkinkan Anda untuk menggunakannya untuk berbagai jenis data.

### 1. *Membuat Template Response dengan Generic Type*

Berikut adalah cara mendefinisikan template response seperti yang Anda lakukan di TypeScript, tetapi di Dart:

dart
class ResponseApi<T> {
  final int status;
  final String message;
  final T data;

  ResponseApi({
    required this.status,
    required this.message,
    required this.data,
  });

  // Factory method untuk parsing dari JSON
  factory ResponseApi.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) {
    return ResponseApi<T>(
      status: json['status'],
      message: json['message'],
      data: fromJsonT(json['data']),
    );
  }
}


### Penjelasan:
1. **ResponseApi<T>**: Ini adalah template generic yang menerima tipe T, yang berarti tipe data di bagian data bisa bervariasi.
2. **status**: Tipe int, berisi status dari response API.
3. **message**: Tipe String, berisi pesan dari API.
4. **data**: Tipe T, yaitu data yang diterima dari server yang bisa berupa tipe apa saja (misalnya Product, User, atau List<Product>).
5. **fromJson**: Ini adalah factory constructor untuk memparsing JSON dari response API dan mengonversi bagian data ke tipe T. Anda perlu memberikan fungsi fromJsonT yang dapat digunakan untuk parsing data.

### 2. *Menggunakan Template ResponseApi dengan Berbagai Tipe Data*

Setelah Anda membuat class ResponseApi<T>, Anda dapat menggunakannya untuk berbagai tipe data, seperti ProductResponse, UserResponse, atau List<ProductResponse>. Berikut adalah contoh penggunaan dengan tipe data yang berbeda.

#### Contoh Model ProductResponse:

dart
class ProductResponse {
  final int id;
  final String name;
  final double price;

  ProductResponse({
    required this.id,
    required this.name,
    required this.price,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
    );
  }
}


#### Penggunaan ResponseApi untuk ProductResponse:

dart
import 'dart:convert';

Future<ResponseApi<ProductResponse>> fetchProduct() async {
  var dio = Dio();
  
  try {
    Response response = await dio.get('https://api.example.com/product/1');

    // Parsing data menggunakan ResponseApi dan ProductResponse.fromJson
    return ResponseApi<ProductResponse>.fromJson(
      response.data,
      (data) => ProductResponse.fromJson(data),
    );
  } catch (e) {
    throw Exception('Failed to fetch product: $e');
  }
}

void main() async {
  try {
    ResponseApi<ProductResponse> productResponse = await fetchProduct();
    print('Product: ${productResponse.data.name}');
  } catch (e) {
    print('Error: $e');
  }
}


#### Penggunaan ResponseApi untuk List ProductResponse:

Jika data yang dikembalikan adalah sebuah daftar produk (misalnya List<ProductResponse>), Anda bisa menggunakan ResponseApi<List<ProductResponse>> sebagai berikut:

dart
Future<ResponseApi<List<ProductResponse>>> fetchProducts() async {
  var dio = Dio();
  
  try {
    Response response = await dio.get('https://api.example.com/products');

    // Parsing data menggunakan ResponseApi dan List<ProductResponse>.from
    return ResponseApi<List<ProductResponse>>.fromJson(
      response.data,
      (data) => (data as List).map((e) => ProductResponse.fromJson(e)).toList(),
    );
  } catch (e) {
    throw Exception('Failed to fetch products: $e');
  }
}

void main() async {
  try {
    ResponseApi<List<ProductResponse>> productsResponse = await fetchProducts();
    for (var product in productsResponse.data) {
      print('Product: ${product.name}');
    }
  } catch (e) {
    print('Error: $e');
  }
}


### 3. *Penjelasan Penggunaan*

1. **ResponseApi<T>**:
   - Ini adalah class generic yang bisa digunakan dengan berbagai jenis tipe data. Anda bisa menggunakannya untuk berbagai jenis response API.
   - Pada fungsi fromJson, kita menggunakan parameter T Function(Object?) fromJsonT untuk memungkinkan parsing data sesuai dengan tipe yang ditentukan.

2. **Fungsi fetchProduct dan fetchProducts**:
   - Fungsi fetchProduct dan fetchProducts mengirimkan request API menggunakan *Dio* dan memparsing response menjadi ResponseApi<T>, di mana T bisa berupa tipe yang berbeda.
   - Misalnya, pada contoh pertama kita mengonversi data menjadi ProductResponse, dan pada contoh kedua, kita mengonversi data menjadi List<ProductResponse>.

### 4. *Manfaat dan Keuntungan*

- *Reusable dan Type-Safe*: Dengan menggunakan generic seperti ini, Anda membuat template yang bisa digunakan berulang kali untuk berbagai tipe data response yang berbeda tanpa menulis kode berulang.
- *Type Safety*: Dart akan memastikan bahwa tipe data yang dikembalikan sesuai dengan tipe yang Anda definisikan dalam class ResponseApi<T>.
- *Flexible*: Anda dapat menggunakan model data yang berbeda-beda sesuai dengan kebutuhan aplikasi Anda, seperti UserResponse, ProductResponse, atau bahkan tipe data list seperti List<ProductResponse>.

### 5. **Alternatif dengan JsonSerializable**

Jika Anda lebih suka menggunakan package **json_serializable** untuk otomatis menghasilkan kode untuk serialisasi/deserialisasi, Anda bisa menggunakan pendekatan ini untuk menghindari penulisan kode konversi manual.

Namun, pendekatan dengan *generic* seperti di atas memberikan kontrol penuh kepada Anda dan lebih fleksibel, terutama ketika Anda bekerja dengan berbagai jenis response yang berbeda.