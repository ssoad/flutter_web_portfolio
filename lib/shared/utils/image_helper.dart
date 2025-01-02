class ImageHelper {
  static bool isNetworkImage(String path) {
    return path.startsWith('http://') || 
           path.startsWith('https://') || 
           path.startsWith('data:image');
  }

  static bool isAssetImage(String path) {
    return path.startsWith('assets/');
  }

  static bool isValidImagePath(String path) {
    final validExtensions = ['.png', '.jpg', '.jpeg', '.gif', '.webp', '.svg'];
    return validExtensions.any((ext) => path.toLowerCase().endsWith(ext));
  }
}