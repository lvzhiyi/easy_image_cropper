# easy_image_cropper

A simple image cropping widget that easily allows cropping avatars and other images. It ensures a consistent cropping experience on both iOS and Android.

![ios](https://github.com/lvzhiyi/easy_avator_cropper/raw/develop/ios.gif)
![android](https://github.com/lvzhiyi/easy_avator_cropper/raw/develop/android.gif)

## Quick start 🚀
1. Install this package.
    ```bash
    flutter pub get easy_image_cropper
    ```

## Usage
Step 1: Create the Cropping UI
Use the ImgCrop component to create the cropping UI. The size of the UI is determined by its parent container.
```dart
///...
Center(
  child: ImgCrop(
    key: cropKey,
    chipShape: ChipShape.circle,
    maximumScale: 1,
    image: FileImage(File(img.path)),
  ),
)
```
Note that cropKey must be a GlobalKey<ImgCropState>(), otherwise the cropping component will not work properly.

### step2: Get the Cropped Image
```dart
final crop = cropKey.currentState;
final croppedFile = await crop.cropCompleted(File(img.path), pictureQuality: 900);
```
`pictureQuality` represents the Size of the cropped image.

## Future
1. support web platform