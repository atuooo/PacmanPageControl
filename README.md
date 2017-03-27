# PacmanPageControl (Swift)

Inspired by Bilibili:

<p align="left" >
  <img src="bilibili.png" alt="bilibili" title="bilibili">
</p>

Demo:

<p align="left" >
  <img src="demo.gif" alt="demo" title="demo">
</p>

## Install

### CocoaPods

The easiest way to use `PacmanPageControl` is installing it by [CocoaPods](http://cocoapods.org). Add these lines to your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'PacmanPageControl', '~> 0.1.1'
```

### Manually

Clone this repo and throw the source files under `Classes` folder into your project to use it.

## Example

```swift
import PacmanPageControl

let pacman = PacmanPageControl(frame: pacmanFrame, pageCount: pageCount)

func scrollViewDidScroll(_ scrollView: UIScrollView) {
    pacman.scroll(with: scrollView)
}

func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    pacman.lastContentOffsetX = scrollView.contentOffset.x
}

```

## Acknowledgements

Thanks for onevcat's [RandomColorSwift](https://github.com/onevcat/RandomColorSwift), It's wonderful.

## License

This project is licensed under the terms of the MIT license.
