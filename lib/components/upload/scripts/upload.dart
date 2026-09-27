import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../types/status.dart';
import '../../../theme/scripts/shadows.dart';
import '../../button/scripts/button.dart';
import '../../text/scripts/text.dart';

class ClayUploadFile {
  ClayUploadFile({
    required this.name,
    required this.size,
    this.extension,
    this.bytes,
    this.path,
    this.progress = 0,
    this.status = ClayUploadStatus.queued,
    this.error,
  });
  final String name;
  final int size;
  final String? extension;
  final Uint8List? bytes;
  final String? path;
  double progress;
  ClayUploadStatus status;
  String? error;
  String get formattedSize {
    if (size < 1024) return '$size B';
    if (size < 1024 * 1024) return '${(size / 1024).toStringAsFixed(1)} KB';
    return '${(size / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

typedef ClayUploadHandler = Future<void> Function(
  ClayUploadFile file,
  ValueChanged<double> onProgress,
);

class ClayUpload extends StatefulWidget {
  const ClayUpload({
    super.key,
    this.multiple = true,
    this.maxFiles,
    this.maxFileSize,
    this.allowedExtensions,
    this.reorderable = true,
    this.enabled = true,
    this.showDropZone = true,
    this.showUploadButton = true,
    this.uploadOnSelect = false,
    this.title = 'Add files',
    this.subtitle = 'Select files to upload',
    this.backgroundColor,
    this.accentColor,
    this.onAccentColor,
    this.borderRadius = 20,
    this.onFilesChanged,
    this.onReorder,
    this.onUpload,
    this.onError,
  });

  final bool multiple,
      reorderable,
      enabled,
      showDropZone,
      showUploadButton,
      uploadOnSelect;
  final int? maxFiles, maxFileSize;
  final List<String>? allowedExtensions;
  final String title, subtitle;
  final Color? backgroundColor, accentColor, onAccentColor;
  final double borderRadius;
  final ValueChanged<List<ClayUploadFile>>? onFilesChanged;
  final ValueChanged<List<ClayUploadFile>>? onReorder;
  final ClayUploadHandler? onUpload;
  final ValueChanged<String>? onError;

  @override
  State<ClayUpload> createState() => _ClayUploadState();
}

class _ClayUploadState extends State<ClayUpload> {
  final List<ClayUploadFile> _files = [];
  bool _picking = false;
  bool _uploading = false;

  void _notify() {
    widget.onFilesChanged?.call(List.unmodifiable(_files));
  }

  Future<void> _pick() async {
    if (!widget.enabled || _picking) return;

    setState(() => _picking = true);

    try {
      final type = widget.allowedExtensions == null
          ? FileType.any
          : FileType.custom;

      final allowedExtensions = widget.allowedExtensions;

      final List<PlatformFile> pickedFiles;

      if (widget.multiple) {
        pickedFiles = await FilePicker.pickFiles(
          type: type,
          allowedExtensions: allowedExtensions,
        );
      } else {
        final picked = await FilePicker.pickFile(
          type: type,
          allowedExtensions: allowedExtensions,
        );

        pickedFiles = picked == null ? [] : [picked];
      }

      if (!mounted) return;

      var accepted = 0;

      for (final picked in pickedFiles) {
        if (widget.maxFiles != null && _files.length >= widget.maxFiles!) {
          widget.onError?.call(
            'The limit of ${widget.maxFiles} files has been reached.',
          );
          break;
        }

        final size = (await picked.length()) ?? 0;

        if (!mounted) return;

        if (widget.maxFileSize != null && size > widget.maxFileSize!) {
          widget.onError?.call(
            '${picked.name}: file larger than the permitted limit.',
          );
          continue;
        }

        final alreadyExists = _files.any(
          (file) => file.name == picked.name && file.size == size,
        );

        if (alreadyExists) continue;

        final bytes = await picked.readAsBytes();

        if (!mounted) return;

        _files.add(
          ClayUploadFile(
            name: picked.name,
            size: size,
            extension: picked.extension?.toLowerCase(),
            bytes: bytes,
            path: picked.path,
          ),
        );

        accepted++;
      }

      if (accepted > 0) {
        setState(() {});
        _notify();
      }

      if (widget.uploadOnSelect && accepted > 0) {
        await _uploadAll();
      }
    } catch (e) {
      widget.onError?.call('Unable to select the files: $e');
    } finally {
      if (mounted) {
        setState(() => _picking = false);
      }
    }
  }

  void _remove(int index) {
    if (_files[index].status == ClayUploadStatus.uploading) return;
    setState(() => _files.removeAt(index));
    _notify();
  }

  void _reorder(int oldIndex, int newIndex) {
    if (!widget.reorderable || oldIndex == newIndex) return;

    setState(() {
      final item = _files.removeAt(oldIndex);
      _files.insert(newIndex, item);
    });

    _notify();
    widget.onReorder?.call(List.unmodifiable(_files));
  }

  Future<void> _uploadAll() async {
    if (_uploading || widget.onUpload == null) return;
    setState(() => _uploading = true);
    try {
      for (final file in _files) {
        if (file.status == ClayUploadStatus.success ||
            file.status == ClayUploadStatus.uploading) {
          continue;
        }
        setState(() {
          file.status = ClayUploadStatus.uploading;
          file.progress = 0;
          file.error = null;
        });
        try {
          await widget.onUpload!(file, (value) {
            if (!mounted) return;
            setState(() => file.progress = value.clamp(0, 1).toDouble());
          });
          if (!mounted) return;
          setState(() {
            file.status = ClayUploadStatus.success;
            file.progress = 1;
          });
        } catch (e) {
          if (!mounted) return;
          setState(() {
            file.status = ClayUploadStatus.error;
            file.error = e.toString();
          });
          widget.onError?.call('Failed to send ${file.name}: $e');
        }
        _notify();
      }
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  IconData _fileIcon(ClayUploadFile file) {
    final ext = file.extension ?? '';
    if (['png', 'jpg', 'jpeg', 'gif', 'webp', 'bmp', 'heic'].contains(ext)) {
      return Icons.image_rounded;
    }
    if (ext == 'pdf') return Icons.picture_as_pdf_rounded;
    if (['doc', 'docx', 'txt', 'rtf', 'odt'].contains(ext)) {
      return Icons.description_rounded;
    }
    if (['zip', 'rar', '7z', 'tar', 'gz'].contains(ext)) {
      return Icons.folder_zip_rounded;
    }
    if (['mp4', 'mov', 'avi', 'mkv'].contains(ext)) return Icons.movie_rounded;
    if (['mp3', 'wav', 'ogg', 'm4a'].contains(ext)) {
      return Icons.audio_file_rounded;
    }
    return Icons.insert_drive_file_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;
    final bg = widget.backgroundColor ?? theme.container;
    final accent = widget.accentColor ?? theme.primary;
    final accentText = widget.onAccentColor ?? theme.onPrimary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: CustomPaint(
        foregroundPainter: ClayInnerShadowPainter(
          shadowColor: theme.shadow,
          lightColor: theme.light,
          borderRadius: widget.borderRadius,
          shadowSize: 2.5,
          blurRadius: 7.0,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: ClayShadows.external(theme: theme, offset: 1, blur: 4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.showDropZone)
                InkWell(
                  onTap: widget.enabled ? _pick : null,
                  borderRadius: BorderRadius.circular(widget.borderRadius - 4),
                  child: CustomPaint(
                    foregroundPainter: ClayInnerShadowPainter(
                      shadowColor: theme.shadow,
                      lightColor: theme.light,
                      borderRadius: widget.borderRadius - 4,
                      shadowSize: 2.5,
                      blurRadius: 7.0,
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 24,
                      ),
                      decoration: BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.circular(
                          widget.borderRadius - 4,
                        ),
                        border: Border.all(
                          color: accent.withValues(alpha: .55),
                          width: 1.2,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                        boxShadow: ClayShadows.external(
                          theme: theme,
                          offset: 1,
                          blur: 4,
                        ),
                      ),
                      child: Column(
                        children: [
                          CustomPaint(
                            foregroundPainter: ClayInnerShadowPainter(
                              shadowColor: theme.shadow,
                              lightColor: theme.light,
                              borderRadius: 100,
                              shadowSize: 2.5,
                              blurRadius: 7.0,
                            ),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              width: 54,
                              height: 54,
                              decoration: BoxDecoration(
                                color: bg,
                                shape: BoxShape.circle,
                                boxShadow: ClayShadows.external(
                                  theme: theme,
                                  offset: 1,
                                  blur: 4,
                                ),
                              ),
                              child: Center(
                                child: _picking
                                    ? SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.4,
                                          color: accent,
                                        ),
                                      )
                                    : Icon(
                                        Icons.cloud_upload_outlined,
                                        color: accent,
                                        size: 27,
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ClayText.label(
                            widget.title,
                            color: theme.onBackground,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                          const SizedBox(height: 4),
                          ClayText.label(
                            widget.subtitle,
                            textAlign: TextAlign.center,
                            color: theme.onBackgroundVariant,
                            fontSize: 12,
                          ),
                          if (widget.allowedExtensions != null) ...[
                            const SizedBox(height: 8),
                            ClayText.label(
                              widget.allowedExtensions!
                                  .map((e) => '.$e')
                                  .join(' · '),
                              color: theme.onBackgroundVariant,
                              fontSize: 11,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              if (_files.isNotEmpty) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ClayText.label(
                        'Archives (${_files.length}${widget.maxFiles == null ? '' : '/${widget.maxFiles}'})',
                        color: theme.onBackground,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (widget.reorderable)
                      ClayText.label(
                        'Drag to reorder',
                        color: theme.onBackgroundVariant,
                        fontSize: 11,
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                ReorderableListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  buildDefaultDragHandles: false,
                  itemCount: _files.length,
                  onReorderItem: widget.reorderable ? _reorder : null,
                  itemBuilder: (context, index) {
                    final file = _files[index];
                    final isBusy = file.status == ClayUploadStatus.uploading;
                    return Padding(
                      key: ValueKey('${file.name}:${file.size}'),
                      padding: const EdgeInsets.only(bottom: 8),
                      child: CustomPaint(
                        foregroundPainter: ClayInnerShadowPainter(
                          shadowColor: theme.shadow,
                          lightColor: theme.light,
                          borderRadius: 14,
                          shadowSize: 2.5,
                          blurRadius: 7.0,
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(11),
                          decoration: BoxDecoration(
                            color: bg,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: theme.border.withValues(alpha: .7),
                            ),
                            boxShadow: ClayShadows.external(
                              theme: theme,
                              offset: 1,
                              blur: 4,
                            ),
                          ),
                          child: Row(
                            children: [
                              CustomPaint(
                                foregroundPainter: ClayInnerShadowPainter(
                                  shadowColor: theme.shadow,
                                  lightColor: theme.light,
                                  borderRadius: 12,
                                  shadowSize: 2.5,
                                  blurRadius: 7.0,
                                ),
                                child: Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    color: accent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    _fileIcon(file),
                                    color: accentText,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClayText.label(
                                      file.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      color: theme.onBackground,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                    const SizedBox(height: 3),
                                    ClayText.label(
                                      '${file.formattedSize} · ${file.status == ClayUploadStatus.uploading
                                          ? 'Sending ${(file.progress * 100).round()}%'
                                          : file.status == ClayUploadStatus.success
                                          ? 'Sent'
                                          : file.status == ClayUploadStatus.error
                                          ? 'Sending failed'
                                          : 'Ready to send'}',
                                      color:
                                          file.status == ClayUploadStatus.error
                                          ? theme.error
                                          : theme.onBackgroundVariant,
                                      fontSize: 11,
                                    ),
                                    if (isBusy ||
                                        file.status ==
                                            ClayUploadStatus.error) ...[
                                      const SizedBox(height: 7),
                                      if (isBusy)
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            99,
                                          ),
                                          child: LinearProgressIndicator(
                                            value: file.progress,
                                            minHeight: 4,
                                            backgroundColor: theme.border,
                                            color: accent,
                                          ),
                                        )
                                      else
                                        ClayText.label(
                                          file.error ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          color: theme.error,
                                          fontSize: 10,
                                        ),
                                    ],
                                  ],
                                ),
                              ),
                              if (file.status == ClayUploadStatus.success)
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: theme.success,
                                  size: 20,
                                )
                              else if (widget.reorderable)
                                ReorderableDragStartListener(
                                  index: index,
                                  child: Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: Icon(
                                      Icons.drag_indicator_rounded,
                                      color: theme.onBackgroundVariant,
                                    ),
                                  ),
                                )
                              else
                                const SizedBox.shrink(),
                              if (!isBusy &&
                                  file.status != ClayUploadStatus.success)
                                IconButton(
                                  tooltip: 'Remover arquivo',
                                  visualDensity: VisualDensity.compact,
                                  onPressed: () => _remove(index),
                                  icon: Icon(
                                    Icons.close_rounded,
                                    color: theme.onBackgroundVariant,
                                    size: 19,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
              if (widget.showUploadButton &&
                  widget.onUpload != null &&
                  _files.isNotEmpty) ...[
                const SizedBox(height: 10),
                ClayButton.primary(
                  _uploading ? 'Sending files…' : 'Send files',
                  onPressed: _uploading || !widget.enabled ? null : _uploadAll,
                  isLoading: _uploading,
                  iconLeft: _uploading
                      ? const SizedBox(
                          width: 17,
                          height: 17,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.cloud_upload_rounded),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
