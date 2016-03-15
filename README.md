# UIWheelGestureRecognizer

Subclass of UIGestureRecognizer for wheel touch

![Screenshot](doc/screenshot.png)

## Usage

ViewController.swift
```swift
let winder = UIWheelGestureRecognizer()
winder.minDistance = 50
winder.maxDistance = 100
winder.setHandler { (recognizer) -> (Void) in
  if recognizer.state == .Changed {
    print("\(recognizer.direction.rawValue), \(recognizer.angle)")
  }
}
tracker.addGestureRecognizer(winder)
```

## Parameters

**minDistance**  < Touch Recognizing Area < **maxDistance**

![Distance](doc/distance.png)

## License

Under MIT License.
