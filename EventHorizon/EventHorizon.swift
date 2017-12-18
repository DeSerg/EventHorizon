//
//  EventHorizon.swift
//  EventHorizon
//
//  Created by deserg on 05.10.2017.
//  Copyright © 2017 deserg. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class EventHorizonHelper {
    
    private let DefaultDistanceCoeff = CGFloat(4)
    private let screenRect: CGRect
    private let distortionDegree: CGFloat = 2
    private let minSpeed: CGFloat = 5
    private let ln1000: CGFloat = log2(1000.0)
    
    private var distanceCoeff: CGFloat
    private var scaleCoeff: CGFloat
    private var distortionFunct: (CGFloat) -> CGFloat = {$0}
    private var distortionDerivative: (CGFloat) -> CGFloat = {$0}
    private var distortionNormFunct: (CGFloat) -> CGFloat = {$0}
    private var distortionNormDerivative: (CGFloat) -> CGFloat = {$0}
    
    init(screenRect: CGRect, distanceCoeff: CGFloat, scaleCoeff: CGFloat) {
        self.screenRect = screenRect
        self.distanceCoeff = distanceCoeff
        self.scaleCoeff = scaleCoeff
        if distanceCoeff < 1 {
            self.distanceCoeff = DefaultDistanceCoeff
        }
        
        let height = screenRect.height
//        let halfWidth = width / 2
        
//        distortionFunct = { (x) in
//            if x <= screenRect.width / 2 {
//                return 0
//            }
//            return distanceCoeff * halfWidth * pow((x - halfWidth) / halfWidth, self.distortionDegree)
//        }
//
//        distortionDerivative = { (x) in
//            if x <= screenRect.width / 2 {
//                return 0
//            }
//            return distanceCoeff * self.distortionDegree
//                * pow((x - halfWidth) / halfWidth, self.distortionDegree - 1)
//        }
//
//        distortionNormFunct = { (x) in
//            if x <= screenRect.width / 2 {
//                return 0
//            }
//            return pow((x - halfWidth) / halfWidth, self.distortionDegree)
//        }
        
//        distortionFunct = { (x) in
//            if x <= screenRect.width / 2 {
//                return 0
//            }
//            return distanceCoeff * halfWidth * pow((x - halfWidth) / halfWidth, self.distortionDegree)
//        }
//
//        distortionDerivative = { (x) in
//            if x <= screenRect.width / 2 {
//                return 0
//            }
//            return distanceCoeff * self.distortionDegree
//                * pow((x - halfWidth) / halfWidth, self.distortionDegree - 1)
//        }
//
//        distortionNormFunct = { (x) in
//            if x <= screenRect.width / 2 {
//                return 0
//            }
//            return pow((x - halfWidth) / halfWidth, self.distortionDegree - 1)
//        }
//
//        distortionNormDerivative = { (x) in
//            if x <= screenRect.width / 2 {
//                return 0
//            }
//            return self.distortionDegree * pow((x - halfWidth) / halfWidth, self.distortionDegree) / halfWidth
//        }
//
//        distortionNormFunct = { (x) in
//            return pow(x * 0.7 / width, self.distortionDegree) //  pow(0.7, self.distortionDegree)
//        }
//
//        distortionNormDerivative = { (x) in
//            return self.distortionDegree * pow(x * 0.7, self.distortionDegree - 1) / pow(width, self.distortionDegree) // pow(0.7, self.distortionDegree)
//
//        }

        distortionNormFunct = { (x) in
            return 1 - cos(asin(0.95 * x / height))
        }

        let heightSquare = height * height
        
        distortionNormDerivative = { (x) in
            let temp = sqrt(1 - 0.9025 * x * x / (heightSquare))
            return 0.9025 * x / (heightSquare * temp)
        }

        distortionFunct = { (x) in
            return self.distortionNormFunct(x) * distanceCoeff * height
        }
        
        distortionDerivative = { (x) in
            return self.distortionNormDerivative(x) * distanceCoeff * height
        }
    }
    
    func scaleFor(yCoord: CGFloat) -> CGFloat {
        let dist = distortionNormFunct(yCoord)
        let coef = (scaleCoeff - 1) / scaleCoeff
        return max(1 / scaleCoeff, 1 - dist * coef)
    }
    
    func yScaleFor(xCoord: CGFloat) -> CGFloat {
        let scale = scaleFor(yCoord: xCoord)
        let derivative = distortionNormDerivative(xCoord)
        let coeff = 1 / sqrt(pow(derivative , 2) + 1)
        return scale * coeff
    }
    
    func nextYCoordFor(yCoord: CGFloat, speed: CGFloat, dt: TimeInterval) -> CGFloat {
        let derivative = Float(distortionDerivative(yCoord))
        let vy = max(minSpeed, speed * CGFloat( cos(atan(pow(derivative, 4))) ))
        let nextYCoord = yCoord - vy * CGFloat(dt)
        return nextYCoord
    }
    
    func randomPoint() -> CGPoint {
        let x = CGFloat.random(min: screenRect.minX, max: screenRect.maxX)
        let y = CGFloat.random(min: screenRect.minY, max: screenRect.maxY)
        return CGPoint(x: x, y: y)
    }

    
}

class EventHorizonSetupHelper {
    var playableRect: CGRect?
    var speed: CGFloat?
    var distanceCoeff: CGFloat?
    var scaleCoeff: CGFloat?
}

class EventHorizon {
    
    static let instance = EventHorizon()
    private static let setup = EventHorizonSetupHelper()
    
    let helper: EventHorizonHelper!
    let playableRect: CGRect!
    let speed: CGFloat!
    
    var spaceObjects: [SKSpriteNode] = []
    
//    var timer: Timer?
//    var interval: TimeInterval = 0.01 /*in seconds*/
    
    class func setup(playableRect: CGRect, speed: CGFloat, distanceCoeff: CGFloat, scaleCoeff: CGFloat) {
        EventHorizon.setup.playableRect = playableRect
        EventHorizon.setup.speed = speed
        EventHorizon.setup.distanceCoeff = distanceCoeff
        EventHorizon.setup.scaleCoeff = scaleCoeff
    }
    
    private init() {
        let setupPlayableRect = EventHorizon.setup.playableRect
        let setupSpeed = EventHorizon.setup.speed
        let setupDistanceCoeff = EventHorizon.setup.distanceCoeff
        let setupScaleCoeff = EventHorizon.setup.scaleCoeff
        guard setupPlayableRect != nil &&
                setupSpeed != nil &&
                setupDistanceCoeff != nil &&
                setupScaleCoeff != nil else {
            fatalError("EventHorizon: init: setup has not been called")
        }
        
        helper = EventHorizonHelper(screenRect: setupPlayableRect!,
                                                distanceCoeff: setupDistanceCoeff!,
                                                scaleCoeff: setupScaleCoeff!)
        speed = setupSpeed!
        playableRect = setupPlayableRect
    }
    
//    func start() {
//        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(update), userInfo: nil, repeats: true)
//    }
//
//    func stop() {
//        if(timer != nil) {
//            timer!.invalidate()
//        }
//    }
    
    func update(dt: TimeInterval) {
        for (index, spaceObject) in spaceObjects.enumerated().reversed() {
            if !spaceObject.frame.intersects(playableRect) && spaceObject.position.y < playableRect.height {
                spaceObject.removeFromParent()
                spaceObjects.remove(at: index)
            }
            
            spaceObject.position.y = helper.nextYCoordFor(yCoord: spaceObject.position.y, speed: speed, dt: dt)
            let scale = helper.scaleFor(yCoord: spaceObject.position.y)
            spaceObject.xScale = scale// * self.eventHorizon.xScaleFor(xCoord: node.position.x)
            spaceObject.yScale = scale
            
        }
    }
    
    func addObject(_ object: SKSpriteNode) {
        spaceObjects.append(object)
    }
    
    func removeObject(object: SKSpriteNode) {
        for (index, spaceObject) in spaceObjects.enumerated() {
            if spaceObject == object {
                spaceObjects.remove(at: index)
                return
            }
        }
    }
    
    
    
}
