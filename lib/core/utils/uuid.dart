import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

var uuid = Uuid(options: {'grng': UuidUtil.cryptoRNG});
