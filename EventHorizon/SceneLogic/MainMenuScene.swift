//
//  MainMenu.swift
//  EventHorizon
//
//  Created by deserg on 17.09.17.
//  Copyright © 2017 deserg. All rights reserved.
//

import Foundation
import SpriteKit
import CoreGraphics

class MainMenuScene: SKScene {
    
    let buttonSize: CGSize
    var button: SKNode!
    
    override init(size: CGSize) {
        
        buttonSize = CGSize(width: GameSize.width * CGFloat(PercentageButtonWidth),
                            height: GameSize.height * CGFloat(PercentageButtonHeight))
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        createButton()
        
    }
    
    func createButton()
    {
        // Create a simple red rectangle that's 100x44
        button = SKSpriteNode(imageNamed: "button")
        // Put it in the center of the scene
        button.position = CGPoint(x:self.frame.midX, y:self.frame.midY);
        
        
        self.addChild(button)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        // Check if the location of the touch is within the button's bounds
        if button.contains(touchLocation) {
            print("tapped!")
        }
        
    }
}
