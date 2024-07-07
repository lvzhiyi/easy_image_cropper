# easy_avator_cropper

A simple image cropping component that easily allows cropping avatars and other images. It ensures a consistent cropping experience on both iOS and Android.

![ios](./ios.gif)
![android](./android.gif)

## Quick start 🚀

1. Install this package.
    ```bash
    flutter pub get easy_avator_cropper
    ```

## Usage
### Step 1: Create the Cropping UI
Use the `ImgCrop` widget to create the cropping UI. The size of the UI is determined by its parent container.

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
需要注意的是 `cropKey` 必须 `GlobalKey<ImgCropState>()`，否则后续裁剪组件无法正常工作。

### step2: Get the Cropped Image
```dart
final crop = cropKey.currentState;
final croppedFile = await crop.cropCompleted(File(img.path), pictureQuality: 900);
```
`pictureQuality` represents the Size of the cropped image.