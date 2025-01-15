// lib/join_page.dart

import 'package:find_get_it_mobile/appConfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JoinPage extends StatefulWidget {
  const JoinPage({Key? key}) : super(key: key);

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  // 입력 컨트롤러
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPwdCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _nicknameCtrl = TextEditingController();
  final _birthCtrl = TextEditingController();   // yyyy-MM-dd 가정
  final _phoneCtrl = TextEditingController();
  final _postNumCtrl = TextEditingController();
  final _addr1Ctrl = TextEditingController();
  final _addr2Ctrl = TextEditingController();

  /// 서버에 회원가입 요청 (예: http://192.168.0.100:9090/Member/Join)
  Future<bool> _attemptJoin({
    required String email,
    required String password,
    required String username,
    required String nickname,
    required String birth,
    required String phone,
    required String postnumber,
    required String address1,
    required String address2,
  }) async {
    final url = Uri.parse(appConfig.url+'/Member/Join');
    // ↑ IP/포트/URL은 실제 환경에 맞춰 수정

    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
        'username': username,
        'nickname': nickname,
        'birth': birth,
        'phone': phone,
        'postnumber': postnumber,
        'address1': address1,
        'address2': address2,
      }),
    );

    print("==================");
    print(resp.statusCode);
    print(resp.body);
    if (resp.statusCode == 200) {
      var response = json.decode(resp.body);
      if(response['success'] == true){
        return true;
      }
      else{
        return false;
      }
    }
    return false;
  }

  /// 회원가입 버튼 클릭
  void _onJoinPressed() async {
    final email = _emailCtrl.text.trim();
    final pw = _passwordCtrl.text.trim();
    final confirm = _confirmPwdCtrl.text.trim();
    final username = _usernameCtrl.text.trim();
    final nickname = _nicknameCtrl.text.trim();
    final birth = _birthCtrl.text.trim();
    final phone = _phoneCtrl.text.trim();
    final post = _postNumCtrl.text.trim();
    final addr1 = _addr1Ctrl.text.trim();
    final addr2 = _addr2Ctrl.text.trim();

    if (email.isEmpty ||
        pw.isEmpty ||
        confirm.isEmpty ||
        username.isEmpty ||
        nickname.isEmpty ||
        birth.isEmpty ||
        phone.isEmpty ||
        post.isEmpty ||
        addr1.isEmpty ||
        addr2.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('모든 항목을 입력해주세요.')),
      );
      return;
    }

    if (pw != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('비밀번호가 일치하지 않습니다.')),
      );
      return;
    }

    final success = await _attemptJoin(
      email: email,
      password: pw,
      username: username,
      nickname: nickname,
      birth: birth,
      phone: phone,
      postnumber: post,
      address1: addr1,
      address2: addr2,
    );
    print(success);

    if (!mounted) return;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('회원가입 성공')),
      );
      Navigator.pop(context); // 이전 화면으로
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('회원가입 실패: 중복 등 오류')),
      );
    }
  }

  /// 주소검색 페이지 열기 (daum_postcode_view 활용)
  Future<void> _openPostalSearch() async {
    final result = await Navigator.pushNamed(context, '/postalSearch');
    if (result != null && mounted) {
      // 예: { 'postCode': '12345', 'address': '서울특별시 ...' }
      final map = result as Map<String, String>;
      setState(() {
        _postNumCtrl.text = map['postCode'] ?? '';
        _addr1Ctrl.text = map['address'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 이메일
          TextField(
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: '이메일',
              hintText: 'ex) example@test.com',
            ),
          ),
          const SizedBox(height: 16),

          // 비밀번호
          TextField(
            controller: _passwordCtrl,
            decoration: const InputDecoration(
              labelText: '비밀번호',
            ),
            obscureText: true,
          ),
          const SizedBox(height: 16),

          // 비밀번호 확인
          TextField(
            controller: _confirmPwdCtrl,
            decoration: const InputDecoration(
              labelText: '비밀번호 확인',
            ),
            obscureText: true,
          ),
          const SizedBox(height: 16),

          // 이름
          TextField(
            controller: _usernameCtrl,
            decoration: const InputDecoration(
              labelText: '이름',
            ),
          ),
          const SizedBox(height: 16),

          // 닉네임
          TextField(
            controller: _nicknameCtrl,
            decoration: const InputDecoration(
              labelText: '닉네임',
            ),
          ),
          const SizedBox(height: 16),

          // 생년월일
          TextField(
            controller: _birthCtrl,
            decoration: const InputDecoration(
              labelText: '생년월일 (YYYY-MM-DD)',
            ),
          ),
          const SizedBox(height: 16),

          // 휴대전화
          TextField(
            controller: _phoneCtrl,
            decoration: const InputDecoration(
              labelText: '휴대전화',
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),

          // 우편번호 (누르면 주소검색 열림)
          InkWell(
            //onTap: _openPostalSearch,
            //child: IgnorePointer(
              child: TextField(
                controller: _postNumCtrl,
                decoration: const InputDecoration(
                  labelText: '우편번호',
                  hintText: '탭하여 우편번호 찾기',
                ),
              ),
            ),
        //  ),
          const SizedBox(height: 16),

          // 기본 주소
          InkWell(
           // onTap: _openPostalSearch,
            //child: IgnorePointer(
              child: TextField(
                controller: _addr1Ctrl,
                decoration: const InputDecoration(
                  labelText: '주소',
                  hintText: '탭하여 주소 찾기',
                ),
              ),
            ),
         // ),
          const SizedBox(height: 16),

          // 상세주소
          TextField(
            controller: _addr2Ctrl,
            decoration: const InputDecoration(
              labelText: '상세주소',
            ),
          ),
          const SizedBox(height: 24),

          // 가입 버튼
          ElevatedButton(
            onPressed: _onJoinPressed,
            child: const Text('가입하기'),
          ),
          const SizedBox(height: 8),

          // 뒤로가기
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
        ],
      ),
    );
  }
}