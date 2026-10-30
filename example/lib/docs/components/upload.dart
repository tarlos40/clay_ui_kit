import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc uploadDocumentation = ComponentDoc(
  title: 'Upload',
  subtitle: 'Components',
  description: 'A file picker and upload queue with extension and size limits, reordering, progress updates, and per-file status.',
  legends: [
    DocumentationLegend(label: 'Queued', color: ClayColors.slate.s500),
    DocumentationLegend(label: 'Uploading', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Success', color: ClayColors.forest.s500),
    DocumentationLegend(label: 'Error', color: ClayColors.ruby.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Select and Upload Files',
      description: 'Provide onUpload to process each selected file and report progress through its callback. Configure allowed extensions, limits, and whether uploads start immediately.',
      code: '''
ClayUpload(
  multiple: true,
  allowedExtensions: const ['pdf', 'png'],
  maxFiles: 5,
  onFilesChanged: (files) {},
  onUpload: (file, onProgress) async {
    await uploadFile(file, onProgress);
  },
  onError: (message) {},
)
''',
      preview: ClayUpload(
        allowedExtensions: const ['pdf', 'png'],
        onFilesChanged: (_) {},
        onUpload: (file, onProgress) async {
          onProgress(1);
        },
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'multiple / maxFiles / maxFileSize',
      type: 'bool / int? / int?',
      description: 'Configure multi-selection and file limits.',
    ),
    ClayProp(
      name: 'allowedExtensions',
      type: 'List<String>?',
      description: 'Restrict selectable file extensions.',
    ),
    ClayProp(
      name: 'reorderable / enabled',
      type: 'bool',
      description: 'Control queue ordering and user interaction.',
      defaultValue: 'true',
    ),
    ClayProp(
      name: 'showDropZone / showUploadButton / uploadOnSelect',
      type: 'bool',
      description: 'Configure drop area, button, and automatic upload.',
    ),
    ClayProp(
      name: 'onFilesChanged / onReorder',
      type: 'ValueChanged<List<ClayUploadFile>>?',
      description: 'Observe queue changes and reordering.',
    ),
    ClayProp(
      name: 'onUpload',
      type: 'ClayUploadHandler?',
      description:
          'Async file handler receiving the file and a progress callback.',
    ),
    ClayProp(
      name: 'onError',
      type: 'ValueChanged<String>?',
      description: 'Receive picker, size, and upload errors.',
    ),
  ],
);
