//
//  GameScene.swift
//  EventHorizon
//
//  Created by deserg on 17.09.17.
//  Copyright © 2017 deserg. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    let shipSpeed: CGFloat = 300
    let starSize: CGFloat = 20
    
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    
    var playableRect: CGRect
    var eventHorizon: EventHorizon
    
    var spacecraft: Ship
    
    var motionManager = CMMotionManager()
    var destY: CGFloat = 50
    
    func spawnStar(coef: CGFloat = 1, inOrigin: Bool = true) {
        
        let star = SKSpriteNode(imageNamed: "star")
        star.name = "star"
        star.size = CGSize(width: starSize * coef, height: starSize * coef)
//        star.zRotation = CGFloat.random(min: 0, max: CGFloat(Double.pi))
        if inOrigin {
            star.position.x = playableRect.width + star.size.width / 2
            let starMinY = playableRect.minY - star.size.height / 2
            let starMaxY = playableRect.maxY + star.size.height / 2
            star.position.y = CGFloat.random(min: starMinY, max: starMaxY)
        } else {
            star.position = eventHorizon.randomPoint()
        }
        let starScale = eventHorizon.scaleFor(xCoord: star.position.x)
        star.setScale(starScale)
        addChild(star)
    }
    
    func updateDt(_ currentTime: TimeInterval) {
        if (lastUpdateTime == 0) {
            lastUpdateTime = currentTime
        }
        
        dt = currentTime - self.lastUpdateTime
        lastUpdateTime = currentTime
    }
    
    override init(size: CGSize) {
        let maxAspectRatio:CGFloat = 16.0/9.0 // 1
        let playableHeight = size.width / maxAspectRatio // 2
        let playableMargin = (size.height-playableHeight)/2.0 // 3
        playableRect = CGRect(x: 0, y: playableMargin,
                              width: size.width,
                              height: playableHeight)
        
        print(playableRect.origin)
        print(playableRect.size)
        
        eventHorizon = EventHorizon(screenRect: playableRect, distanceCoeff: 1, scaleCoeff: 3)
        
        spacecraft = Ship()
        spacecraft.position.x = playableRect.minX + spacecraft.size.width / 2
        spacecraft.position.y = playableRect.minY + playableRect.size.height / 2
        spacecraft.zPosition = 50
        
        destY = spacecraft.position.y
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        anchorPoint = CGPoint(x: 0, y: 0)
        
        backgroundColor = SKColor.black
        
        addChild(spacecraft)
        
        for _ in (0...200) {
            spawnStar(inOrigin: false)
        }
        
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run {
            self.spawnStar()
        }, SKAction.wait(forDuration: 0.02)])))
        
//        run(SKAction.repeatForever(SKAction.sequence([SKAction.run {
//            self.spawnStar(coef: 10)
//            }, SKAction.wait(forDuration: 1)])))
//        if motionManager.isAccelerometerAvailable == true {
//            print("AVAILIABALE!")
//            // 2
//            motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler:{
//                data, error in
//
//                let currentY = self.spacecraft.position.y
//
//                guard let d = data else {
//                    return
//                }
//
//                // 3
//                print()
//                print("x: \(d.acceleration.x)")
////                print("y: \(d.acceleration.y)")
////                print("z: \(d.acceleration.z)")
//                let accVal = d.acceleration.x
//                let coef: Double = 1000
//                let border = 0.5
//                self.destY = currentY - CGFloat((accVal - border) * coef)
//            })
//
//        }
    }
    
    override func sceneDidLoad() {
        
    }
    
    
    // touching logics
    func sceneTouched(touchLocation:CGPoint) {
        destY = touchLocation.y
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLocation: touchLocation)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLocation: touchLocation)
    }
    
    func checkBordersSpacecraft() {
        let pos = spacecraft.position
        
        if pos.x < playableRect.minX {
            spacecraft.position.x = playableRect.minX
        } else if pos.x > playableRect.maxX {
            spacecraft.position.x = playableRect.maxX
        }
        
        if pos.y < playableRect.minY {
            spacecraft.position.y = playableRect.minY
        } else if pos.y > playableRect.maxY {
            spacecraft.position.y = playableRect.maxY
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        updateDt(currentTime)
        
        enumerateChildNodes(withName: "star") {  node, _ in
            guard let node = node as? SKSpriteNode else {
                return
            }
            
            if node.position.x < self.playableRect.minX {
                node.removeFromParent()
            }
            node.position.x = self.eventHorizon.nextXCoordFor(xCoord: node.position.x, speed: self.shipSpeed, dt: self.dt)
            let scale = self.eventHorizon.scaleFor(xCoord: node.position.x)
            node.xScale = scale * self.eventHorizon.xScaleFor(xCoord: node.position.x)
            node.yScale = scale
//            node.zRotation += 0.01
        }
        
//        spacecraft.
        spacecraft.run(SKAction.moveTo(y: destY, duration: 1))
//        spacecraft.position.y = destY
        checkBordersSpacecraft()

    }
}
