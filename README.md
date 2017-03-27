# PacmanPageControl 

Let's play Pac-Man:

<p align="left" >
  <img src="demo.gif" alt="demo" title="demo">
</p>

## Requirements

* iOS 8.0+
* Xcode 8+
* Swift 3

## Install

### CocoaPods

To integrate PacmanPageControl into your Xcode project using CocoaPods, specify it to a target in your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
  pod 'PacmanPageControl', '~> 0.2.0'
end

```

### Manually

Clone this repo and throw the source files under `Sources` folder into your project to use it.

## Example

```swift
// init 
let pacman = PacmanPageControl(frame: pacmanFrame, pageCount: pageCount)
pacman.dotColorStyle = .random(hue: .orange, luminosity: .light)
pacman.pacmanColorStyle = .changeWithDot

// update in UIScrollView Delegate
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

PacmanPageControl is licensed under the terms of the MIT license. See LICENSE for details
