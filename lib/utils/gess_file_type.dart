/// استخراج پسوند فایل
String getFileExtension(String filePath) {
  final normalizedPath = filePath.toLowerCase().trim();
  final dotIndex = normalizedPath.lastIndexOf('.');
  if (dotIndex == -1 || dotIndex == normalizedPath.length - 1) {
    return '';
  }
  return normalizedPath.substring(dotIndex + 1);
}

/// تشخیص Content-Type بر اساس پسوند فایل با switch
String guessContentType(String filePath) {
  final extension = getFileExtension(filePath);

  return switch (extension) {
    'jpg' => 'image/jpeg',
    'jpeg' => 'image/jpeg',
    'png' => 'image/png',
    'gif' => 'image/gif',
    'webp' => 'image/webp',
    'svg' => 'image/svg+xml',
    'pdf' => 'application/pdf',
    'txt' => 'text/plain',
    'json' => 'application/json',
    'xml' => 'application/xml',
    'csv' => 'text/csv',
    'html' => 'text/html',
    'htm' => 'text/html',
    'mp4' => 'video/mp4',
    'mpeg' => 'video/mpeg',
    'mpg' => 'video/mpeg',
    'mp3' => 'audio/mpeg',
    'wav' => 'audio/wav',
    'ogg' => 'audio/ogg',
    'zip' => 'application/zip',
    'rar' => 'application/vnd.rar',
    '7z' => 'application/x-7z-compressed',
    'doc' => 'application/msword',
    'docx' =>
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'xls' => 'application/vnd.ms-excel',
    'xlsx' =>
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    'ppt' => 'application/vnd.ms-powerpoint',
    'pptx' =>
      'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    _ => 'application/octet-stream',
  };
}
