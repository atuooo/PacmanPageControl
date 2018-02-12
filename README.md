# PacmanPageControl 

### Let's play Pac-Man:

<p align="left" >
  <img src="demo.gif" alt="demo" title="demo">
</p>

## Install

### [CocoaPods](https://cocoapods.org/)

To integrate PacmanPageControl into your Xcode project using CocoaPods, specify it to a target in your Podfile:

```ruby
pod 'PacmanPageControl'
```

### [Carthage](https://github.com/Carthage/Carthage)

```ogdl
github "atuooo/PacmanPageControl"
```

### Manually

Clone this repo and throw the source files under `Sources` folder into your project to use it.

## Example

```swift
// init 
let pacman = PacmanPageControl(frame: pacmanFrame)
pacman.scrollView = scrollView
// pacman.dotColorStyle = .random(hue: .orange, luminosity: .light)
// pacman.pacmanColorStyle = .changeWithEatenDot

view.addSubview(pacman)
```

**You can also set it in Interface Builder.**

## Acknowledgements

Thanks for onevcat's [RandomColorSwift](https://github.com/onevcat/RandomColorSwift).

## License

PacmanPageControl is released under the terms of the MIT license. See [LICENSE](LICENSE) for details.
