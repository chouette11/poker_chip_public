enum ActionTypeEnum {
  call('call'),
  raise('raise'),
  fold('fold'),
  check('check'),
  bet('bet');

  const ActionTypeEnum(this.displayName);

  final String displayName;
}