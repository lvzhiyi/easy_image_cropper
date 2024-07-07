# easy_avator_cropper

一个简单的图片裁剪组件。可以很方便的完成裁剪头像等功能，并且让 iOS、Android 端的裁剪体验表现一致。



## Quick start 🚀

1. Install this package.
    ```bash
    flutter pub get easy_avator_cropper
    ```

## Usage
### step1: 生成裁剪 UI
使用 `ImgCrop` 组件生成裁剪的 UI 界面，至于尺寸大小，由你的父容器决定。
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

### step2: 获取裁剪后的图片
```dart
final crop = cropKey.currentState;
final croppedFile = await crop.cropCompleted(File(img.path), pictureQuality: 900);
```
`pictureQuality` 代表你裁剪后图片的 `Size`.