// lib/login_page.dart

import 'package:find_get_it_mobile/appConfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'global.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();

  // 실제 로그인 API 호출
  Future<bool> _attemptLogin(String email, String password) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('로그인 중')),
    );
    final url = Uri.parse(appConfig.url+'/Member/Login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        // 응답 본문을 확인하고 JSON으로 파싱 가능한지 확인
        try {
          final data = json.decode(response.body);
          if (data is Map<String, dynamic> && data.containsKey('success')) {
            return data['success'] == true;
          } else {
            print('Unexpected response format: ${response.body}');
            return false;
          }
        } catch (e) {
          print('Error parsing response as JSON: ${response.body}');
          return false;
        }
      } else {
        print('Server returned an error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Login request error: $e');
      return false;
    }
  }

  void _onLoginButtonPressed() async {
    final email = _emailCtrl.text.trim();
    final pw = _pwCtrl.text.trim();
    if (email.isEmpty || pw.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이메일과 비밀번호를 모두 입력해주세요.')),
      );
      return;
    }

    final success = await _attemptLogin(email, pw);
    if (!mounted) return;

    if (success) {
      setState(() {
        GlobalState.isLoggedIn = true;
        GlobalState.loginEmail = email;
      });
      Navigator.pushReplacementNamed(context, '/main');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그인 성공')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그인 실패: 아이디/비밀번호를 확인하세요.')),
      );
    }
  }

  void _onGotoJoin() {
    Navigator.pushNamed(context, '/join');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("로그인"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 로고
          Image.asset(
            "assets/logo/logo_open_orange.png",
            width: 120,
            height: 120,
          ),
          const SizedBox(height: 16),

          // 이메일
          TextField(
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: '이메일',
              hintText: '이메일을 입력하세요',
            ),
          ),
          const SizedBox(height: 16),

          // 비밀번호
          TextField(
            controller: _pwCtrl,
            decoration: const InputDecoration(
              labelText: '비밀번호',
              hintText: '비밀번호를 입력하세요',
            ),
            obscureText: true,
          ),
          const SizedBox(height: 24),

          // 로그인 버튼
          ElevatedButton(
            onPressed: _onLoginButtonPressed,
            child: const Text('로그인'),
          ),
          const SizedBox(height: 12),

          // 회원가입으로 이동
          TextButton(
            onPressed: _onGotoJoin,
            child: const Text('회원가입 페이지로 이동'),
          ),
        ],
      ),
    );
  }
}