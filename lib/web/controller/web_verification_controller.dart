import 'package:get/get.dart';
import 'package:skill_chain/web/utils/ui_element.dart';

import '../../api/api_manager.dart';
import '../../api/service.dart';
import '../models/bc_user_model.dart';
import '../models/skills_model.dart';

class WebVerificationController extends GetxController {
  RxList<SkillsModel> selectedSkills = RxList<SkillsModel>();

  RxList<BcUser> selectedUsers = RxList([]);

  Future getUserFromPublicId(List<String> data, Function() onTap) async {
    var res = await APIManager.shared.response(
      APIRequest(EAPIRequest.getUserFromPublicIds, param: {
        "public_ids": data,
      }),
      isNeedLoading: true,
      isNeedErrorAlert: true,
    );

    if (res is Error) return null;
    try {
      BcUserModel data = BcUserModel.fromJson(res.data);
      if (data.status ?? false) {
        selectedUsers.value = data.data ?? [];
        onTap();
      }
    } catch (e) {
      print(e);
      webToast(e.toString());
    }
  }

  Future<List<bool>> addSkill(String skillId, String instituteId) async {
    var body = {
      "skill_id": skillId,
      "users": selectedUsers
          .map(
            (element) => {
              "public_id": element.publicId,
              "skill_doc_url": element.selectedDocUrl.value,
              "institute_id": instituteId,
            },
          )
          .toList(),
    };
    var res = await APIManager.shared.response(
      APIRequest(EAPIRequest.addSkill, param: body),
      isNeedLoading: true,
      isNeedErrorAlert: true,
    );

    if (res is Error) return [];
    List<bool> resStatus = List<bool>.from(res.data["data"]);
    return resStatus;
  }
}
