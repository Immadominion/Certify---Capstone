import 'dart:convert';
import 'dart:ui';

import 'package:certify/data/controllers/all_manufacturer_projects_controller.dart';
import 'package:certify/presentation/views/nft_details/components/build_image_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ViewNFT extends ConsumerStatefulWidget {
  const ViewNFT({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ViewNFTState();
}

class _ViewNFTState extends ConsumerState<ViewNFT> {
  Uint8List? _decodedBytes;

  @override
  void initState() {
    super.initState();
    _decodeImage();
  }

  Future<void> _decodeImage() async {
    try {
      final base64String = ref.read(certifyProjectsController).imageUrl;
      final trimmedString = base64String.trim();
      if (!trimmedString.startsWith('data:image/')) {
        debugPrint('Invalid base64 image format: $trimmedString');
        _decodedBytes = null;
        setState(() {});
        return;
      }
      _decodedBytes = await compute(_base64Decode, trimmedString.split(',')[1]);
      if (mounted) {
        setState(() {});
      }
    } catch (error) {
      debugPrint('Error decoding image: $error');
      _decodedBytes = null;
      setState(() {});
    }
  }

  static Uint8List _base64Decode(String base64String) =>
      const Base64Decoder().convert(base64String);

  @override
  Widget build(BuildContext context) {
    return _decodedBytes != null
        ? Center(
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width / 1.3,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: buildImageContainer(context, _decodedBytes),
              ),
            ),
          )
        : _buildPlaceholderOrError();
  }

  Widget _buildPlaceholderOrError() {
    if (_decodedBytes == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return const Center(
        child: Text('Try Again, Later'),
      );
    }
  }
}
