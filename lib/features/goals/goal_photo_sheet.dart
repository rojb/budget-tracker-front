import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui/ui.dart';

import '../../core/api/api_failure.dart';
import '../common/feedback.dart';
import '../envelopes/envelopes_controller.dart';
import '../envelopes/envelopes_repository.dart';

/// What the user picked in 50 Foto de la meta.
sealed class PhotoChoice {
  const PhotoChoice();
}

/// One of the suggested photos.
class SuggestedChoice extends PhotoChoice {
  const SuggestedChoice(this.suggestion);

  final PhotoSuggestionData suggestion;
}

/// A picture from the gallery or the camera.
class PickedChoice extends PhotoChoice {
  const PickedChoice(this.bytes, this.filename);

  final Uint8List bytes;
  final String filename;
}

/// "Quitar foto".
class NoPhotoChoice extends PhotoChoice {
  const NoPhotoChoice();
}

/// Largest photo the API accepts (5 MB); a bigger pick is refused here too.
const int photoMaxBytes = 5 * 1024 * 1024;
const String photoRejected = 'La foto debe ser JPEG, PNG o WebP de hasta 5 MB.';

/// Applies [choice] to the envelope through the API.
Future<void> applyPhotoChoice(
  EnvelopesController envelopes,
  String envelopeId,
  PhotoChoice choice,
) {
  return switch (choice) {
    SuggestedChoice(:final suggestion) => envelopes.applySuggestedPhoto(
      envelopeId,
      suggestion.id,
    ),
    PickedChoice(:final bytes, :final filename) => envelopes.uploadPhoto(
      envelopeId,
      bytes,
      filename,
    ),
    NoPhotoChoice() => envelopes.removePhoto(envelopeId),
  };
}

/// Screen 50 Foto de la meta: the current photo, "Elegir de la galería",
/// "Sacar una foto", the suggested photos, "Quitar foto" (confirmed in place)
/// and "Listo". Choosing only marks the choice; "Listo" applies it.
///
/// With an [envelopeId] it calls the API itself and returns the choice that
/// was applied (null when closed without one). Without one (opened from 31,
/// where the envelope does not exist yet) it only returns the choice, starting
/// from [draftChoice], and the caller applies it after creating the envelope.
Future<PhotoChoice?> showGoalPhotoSheet(
  BuildContext context, {
  required EnvelopesController envelopes,
  required IconData icon,
  String? envelopeId,
  PhotoChoice? draftChoice,
}) async {
  final choice = await showUiSheet<PhotoChoice>(
    context,
    builder: (sheetContext) => UiSheet(
      title: 'Foto de la meta',
      child: _PhotoSheet(
        envelopes: envelopes,
        icon: icon,
        envelopeId: envelopeId,
        draftChoice: draftChoice,
      ),
    ),
  );
  if (choice != null && envelopeId != null && context.mounted) {
    showSaved(context, 'Guardado');
  }
  return choice;
}

class _PhotoSheet extends StatefulWidget {
  const _PhotoSheet({
    required this.envelopes,
    required this.icon,
    required this.envelopeId,
    required this.draftChoice,
  });

  final EnvelopesController envelopes;
  final IconData icon;
  final String? envelopeId;
  final PhotoChoice? draftChoice;

  @override
  State<_PhotoSheet> createState() => _PhotoSheetState();
}

class _PhotoSheetState extends State<_PhotoSheet> {
  late PhotoChoice? _pending = widget.draftChoice;
  List<PhotoSuggestionData>? _suggestions;
  bool _suggestionsFailed = false;
  bool _confirmRemove = false;
  bool _busy = false;
  String? _message;

  @override
  void initState() {
    super.initState();
    _loadSuggestions();
  }

  Future<void> _loadSuggestions() async {
    setState(() => _suggestionsFailed = false);
    try {
      final list = await widget.envelopes.photoSuggestions();
      if (mounted) setState(() => _suggestions = list);
    } on ApiFailure {
      if (mounted) setState(() => _suggestionsFailed = true);
    }
  }

  /// The photo the envelope has now (null in draft mode or without one).
  String? get _currentPath => widget.envelopeId == null
      ? null
      : widget.envelopes.lineById(widget.envelopeId!)?.envelope.photoUrl;

  ImageProvider? get _preview {
    final pending = _pending;
    return switch (pending) {
      SuggestedChoice(:final suggestion) => widget.envelopes.imageFor(
        suggestion.imageUrl,
      ),
      PickedChoice(:final bytes) => MemoryImage(bytes),
      NoPhotoChoice() => null,
      null => widget.envelopes.imageFor(_currentPath),
    };
  }

  bool get _hasPhoto => _preview != null;

  Future<void> _pick(ImageSource source) async {
    try {
      final file = await ImagePicker().pickImage(source: source);
      if (file == null) return;
      final bytes = await file.readAsBytes();
      if (!mounted) return;
      if (bytes.length > photoMaxBytes) {
        setState(() => _message = photoRejected);
        return;
      }
      setState(() {
        _pending = PickedChoice(bytes, file.name);
        _message = null;
        _confirmRemove = false;
      });
    } catch (_) {
      if (mounted) {
        setState(
          () =>
              _message = 'No pudimos abrir tus fotos. Probá con una sugerida.',
        );
      }
    }
  }

  Future<void> _apply(PhotoChoice choice) async {
    final id = widget.envelopeId;
    if (id == null) {
      Navigator.of(context).pop(choice);
      return;
    }
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      await applyPhotoChoice(widget.envelopes, id, choice);
      if (mounted) Navigator.of(context).pop(choice);
    } on ApiFailure catch (failure) {
      if (!mounted) return;
      switch (failure.kind) {
        case ApiFailureKind.payloadTooLarge:
        case ApiFailureKind.unsupportedMedia:
          setState(() => _message = photoRejected);
        case ApiFailureKind.forbidden:
          showForbidden(context);
        default:
          showConnectionProblem(context);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Widget _preview140() {
    final image = _preview;
    return Align(
      alignment: Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(UiRadius.photo),
        child: SizedBox(
          width: 140,
          height: 90,
          child: image == null
              ? ColoredBox(
                  color: UiColors.lavender,
                  child: Icon(
                    widget.icon,
                    size: 40,
                    color: UiColors.ink.withAlpha(120),
                  ),
                )
              : Image(
                  image: image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const ColoredBox(color: UiColors.soft),
                ),
        ),
      ),
    );
  }

  Widget _thumbs() {
    final suggestions = _suggestions;
    if (_suggestionsFailed) {
      return Row(
        children: [
          Expanded(
            child: Text(
              'No pudimos cargar las fotos sugeridas.',
              style: UiTypography.custom(15, color: UiColors.inkMuted),
            ),
          ),
          _TextAction(label: 'Reintentar', onTap: _loadSuggestions),
        ],
      );
    }
    final selectedId = switch (_pending) {
      SuggestedChoice(:final suggestion) => suggestion.id,
      _ => null,
    };
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 110 / 76,
      children: [
        if (suggestions == null)
          for (var i = 0; i < 4; i++)
            DecoratedBox(
              decoration: BoxDecoration(
                color: UiColors.soft,
                borderRadius: BorderRadius.circular(20),
              ),
            )
        else
          for (final suggestion in suggestions)
            UiPhotoThumb(
              image: widget.envelopes.imageFor(suggestion.imageUrl)!,
              semanticLabel: suggestion.name,
              selected: suggestion.id == selectedId,
              onTap: () => setState(() {
                _pending = SuggestedChoice(suggestion);
                _message = null;
                _confirmRemove = false;
              }),
            ),
        UiPhotoThumb.more(
          label: 'Más fotos',
          onTap: () => _pick(ImageSource.gallery),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.envelopes,
      builder: (context, _) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _preview140(),
            const SizedBox(height: 8),
            UiMenuRow(
              icon: UiIcons.images,
              label: 'Elegir de la galería',
              onTap: () => _pick(ImageSource.gallery),
            ),
            UiMenuRow(
              icon: UiIcons.camera,
              label: 'Sacar una foto',
              onTap: () => _pick(ImageSource.camera),
            ),
            const SizedBox(height: 10),
            Text(
              'Fotos sugeridas',
              style: UiTypography.custom(16, color: UiColors.inkMuted),
            ),
            const SizedBox(height: 10),
            _thumbs(),
            if (_message != null) ...[
              const SizedBox(height: 12),
              UiFormMessage(message: _message!),
            ],
            if (_hasPhoto) ...[
              const SizedBox(height: 14),
              if (_confirmRemove)
                Row(
                  children: [
                    Expanded(
                      child: UiButton(
                        label: 'Cancelar',
                        variant: UiButtonVariant.white,
                        onPressed: () => setState(() => _confirmRemove = false),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: UiButton(
                        label: 'Quitar',
                        variant: UiButtonVariant.danger,
                        onPressed: _busy
                            ? null
                            : () => _apply(const NoPhotoChoice()),
                      ),
                    ),
                  ],
                )
              else
                Center(
                  child: Column(
                    children: [
                      _TextAction(
                        label: 'Quitar foto',
                        destructive: true,
                        onTap: () => setState(() => _confirmRemove = true),
                      ),
                      Text(
                        'La tarjeta usa un color en su lugar.',
                        style: UiTypography.custom(
                          15,
                          color: UiColors.inkMuted,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
            const SizedBox(height: 16),
            UiButton(
              label: 'Listo',
              loading: _busy,
              onPressed: _busy
                  ? null
                  : () {
                      final pending = _pending;
                      if (pending == null || pending is NoPhotoChoice) {
                        Navigator.of(context)
                            .pop(pending is NoPhotoChoice ? pending : null);
                      } else {
                        _apply(pending);
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}

/// Text-only action ("Quitar foto", "Reintentar") with a 48 dp hit area; the
/// destructive one is red (`danger`) text, as in the design of 50.
class _TextAction extends StatelessWidget {
  const _TextAction({
    required this.label,
    required this.onTap,
    this.destructive = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: ExcludeSemantics(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
            child: Center(
              widthFactor: 1,
              child: Text(
                label,
                style: UiTypography.custom(
                  18,
                  weight: 500,
                  color: destructive ? UiColors.danger : UiColors.ink,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
