sealed class AccountIdParameter {
  AccountIdParameter();
}

class SmsAccount implements AccountIdParameter {
  SmsAccount({required this.phoneNum});

  String phoneNum;
}

class EmailAccount implements AccountIdParameter {
  EmailAccount({
    required this.email,
    required this.password,
  });

  String email;
  String password;
}

sealed class AccountIdType {}

class Email implements AccountIdType {}
