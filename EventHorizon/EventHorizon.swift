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

class EventHorizon {
    
    private let DefaultDistanceCoeff = CGFloat(4)
    private let screenRect: CGRect
    private let distortionDegree: CGFloat = 2
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
        
        let width = screenRect.width
        let halfWidth = width / 2
        
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
            return 1 - cos(asin(x/width))
        }

        distortionNormDerivative = { (x) in
            return 1 / width
        }

        distortionFunct = { (x) in
            return self.distortionNormFunct(x) * distanceCoeff * width
        }
        
        distortionDerivative = { (x) in
            return self.distortionNormDerivative(x) * distanceCoeff * width
        }
    }
    
    func scaleFor(xCoord: CGFloat) -> CGFloat {
        let dist = distortionNormFunct(xCoord)
        let coef = (scaleCoeff - 1) / scaleCoeff
        return max(1 / scaleCoeff, 1 - dist * coef)
    }
    
    func xScaleFor(xCoord: CGFloat) -> CGFloat {
        let scale = scaleFor(xCoord: xCoord)
        let derivative = distortionNormDerivative(xCoord)
        let coeff = 1 / sqrt(pow(derivative , 2) + 1)
        return scale * coeff
    }
    
    func nextXCoordFor(xCoord: CGFloat, speed: CGFloat, dt: TimeInterval) -> CGFloat {
        let derivative = Float(distortionDerivative(xCoord))
        let vx = speed * CGFloat( cos(atan(pow(derivative, 4))) )
        let nextXCoord = xCoord - vx * CGFloat(dt)
        return nextXCoord
    }
    
    func randomPoint() -> CGPoint {
        let x = CGFloat.random(min: screenRect.minX, max: screenRect.maxX)
        let y = CGFloat.random(min: screenRect.minY, max: screenRect.maxY)
        return CGPoint(x: x, y: y)
    }
    
}
