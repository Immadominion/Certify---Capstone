  import 'package:certify/data/controllers/all_manufacturer_projects_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void updateListProjects(WidgetRef ref,  project) {
    
    final img = ref.read(certifyProjectsController.notifier);
    img.imageUrl = project.image ?? '';
    img.projectName = project.name ?? '';
    img.projectId = project.id?.toString() ?? '';
    img.symbol = project.symbol ?? '';
    img.description = project.description ?? '';
    img.mintAddress = project.mintAddress ?? '';
    img.sellerFreeBasisPoints = project.sellerFeeBasisPoints?.toString() ?? '';
  }