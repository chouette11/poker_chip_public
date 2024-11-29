enum MessageTypeEnum {
  sit('sit'),
  userSetting('userSetting'),
  history('history'),
  game('game'),
  action('action'),
  res('res'),
  reconnect('reconnect');

  const MessageTypeEnum(this.displayName);

  final String displayName;
}