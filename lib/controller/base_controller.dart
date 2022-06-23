import 'package:bt_match/services/app_exception.dart';
import 'package:bt_match/utils/dialog_helper.dart';

class BaseController {
  void handleError(error) {
    var message = error.message;
    if (error is BadRequestException) {
      DialogHelper.showErrorDialog(description: message);
    } else if (error is FetchDataException) {
      DialogHelper.showErrorDialog(description: message);
    } else if (error is ApiNotRespondingException) {
      DialogHelper.showErrorDialog(
          description: 'Oops! It took longer to respond.');
    } else if (error is UnAuthorizedException) {
      DialogHelper.showErrorDialog(description: message);
    }
  }
}
