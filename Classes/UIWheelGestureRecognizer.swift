//
//  UIWinderGestureRecognizer.swift
//  UIWinderGestureRecognizer
//
//  Created by iamchiwon on 2016. 3. 15..
//  Copyright © 2016년 iamchiwon. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class UIWheelGestureRecognizer: UIGestureRecognizer {
    
    typealias UIWheelGestureRecognizerDelegate = (recognizer:UIWheelGestureRecognizer) -> (Void)
    
    enum Direction: String {
        case None = "None"
        case Right = "Right"
        case Left = "Left"
    }
    
    var direction : Direction = .None
    var angle : Double = 0
    var minDistance : Double = 0
    var maxDistance : Double = 100
    
    
    
    private var eventHandler : UIWheelGestureRecognizerDelegate? = nil
    
    func setHandler(handler:UIWheelGestureRecognizerDelegate) {
        eventHandler = handler
    }
    
    func reportEvent() {
        if let delegate = eventHandler {
            delegate(recognizer: self)
        }
    }
    
    override func reset() {
        super.reset()
        state = .Possible
        direction = .None
        angle = 0
        reportEvent()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        guard checkValidate(touches) else {
            state = .Failed
            return
        }
        
        state = .Began
        lastAngle = calucateAngle(touches.first!)
        reportEvent()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        if state == .Failed {return }
        guard checkValidate(touches) else { return }
        state = .Changed
        trackingAngle( calucateAngle(touches.first!) )
        reportEvent()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        if state == .Failed {return }
        state = .Ended
        reportEvent()
    }
    
    override func touchesCancelled(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesCancelled(touches, withEvent: event)
        if state == .Failed {return }
        state = .Cancelled
        reportEvent()
    }
    
    private func checkValidate(touches: Set<UITouch>) -> Bool {
        if view == nil {
            return false
        }
        
        if touches.count != 1 {
            return false
        }
        
        let point = touches.first!.locationInView(view!)
        let distance = calculateDistance(point)
        
        if distance < minDistance || distance > maxDistance {
            return false
        }
        
        return true
    }
    
    private func calculateDistance(point:CGPoint) -> Double {
        let size = view!.frame.size
        let center = CGPointMake(size.width / 2, size.height / 2)
        let dx = center.x - point.x
        let dy = center.y - point.y
        let distance = Double(sqrt(dx*dx + dy*dy))
        return distance
    }
    
    private func calucateAngle(touch:UITouch) -> Double {
        let point = touch.locationInView(view)
        let size = view!.frame.size
        let center = CGPointMake(size.width / 2, size.height / 2)
        let dx = center.x - point.x
        let dy = center.y - point.y
        let angle = Double(atan2(dx, dy)).radiansToDegrees
        return angle
    }
    
    private var lastAngle:Double = 0
    
    func trackingAngle(currentAngle:Double) {
        let diff = abs(lastAngle - currentAngle)
        
        if lastAngle > 90 && currentAngle < -90 {
            //왼쪽으로 돌리다가 180도에서 -180도로 변경되는 부분
            direction = .Left
            //angle 계산 skip
        } else if lastAngle < -90 && currentAngle > 90 {
            //오른쪽으로 돌리다가 -180에서 180도로 변경되는 부분
            direction = .Right
            //angle 계산 skip
        } else if lastAngle > currentAngle {
            direction = .Right
            angle += diff
        } else {
            direction = .Left
            angle -= diff
        }
        
        lastAngle = currentAngle
    }
}

extension Double {
    var degreesToRadians: Double {
        return self * M_PI / 180
    }
    var radiansToDegrees: Double {
        return self * 180 / M_PI
    }
}