# Guttler Page Control (Swift)

Inspired by Bilibili:

<p align="left" >
  <img src="Demo/bilibili.png" alt="bilibili" title="bilibili">
</p>

Demo:

<p align="left" >
  <img src="Demo/demo.gif" alt="demo" title="demo">
</p>

## Install

### CocoaPods

The easiest way to use `GuttlerPageControl` is installing it by [CocoaPods](http://cocoapods.org). Add these lines to your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'GuttlerPageControl'
```

### Manually

Clone this repo and throw the source files under `Classes` folder into your project to use it.

## Example

```swift
import GuttlerPageControl

// Just init with position and numOfpage
let guttlerPageControl = GuttlerPageControl(center: view.center, pages: numOfpage)

// Must bind pageControl with the scrollView 
guttlerPageControl.bindScrollView = scrollView

// Just invoke scrollWithScrollView(_:) in scrollViewDidScroll(_:)
func scrollViewDidScroll(scrollView: UIScrollView) {
    guttlerPageControl.scrollWithScrollView(scrollView)
}

```

## Acknowledgements

Thanks for onevcat's [RandomColorSwift](https://github.com/onevcat/RandomColorSwift), It's wonderful.

## License

This project is licensed under the terms of the MIT license.
