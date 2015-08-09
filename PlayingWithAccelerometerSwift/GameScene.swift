//
//  GameScene.swift
//  PlayingWithAccelerometerSwift
//
//  Created by Michael Vilabrera on 8/8/15.
//  Copyright (c) 2015 Giving Tree. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
    
    var airplane = SKSpriteNode()
    var motionManager = CMMotionManager()
    var destX: CGFloat = 0.0
    var destY: CGFloat = 0.0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // 1
        airplane = SKSpriteNode(imageNamed: "Airplane")
        airplane.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        self.addChild(airplane)
        
        if (motionManager.accelerometerAvailable) {
            // 2
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: { (data, error) -> Void in
                var currentX = self.airplane.position.x
                var currentY = self.airplane.position.y
                
                // 3
                if data.acceleration.x < 0 {
                    self.destX = currentX + CGFloat(data.acceleration.x * 100)
                }
                
                else if data.acceleration.x > 0 {
                    self.destX = currentX + CGFloat(data.acceleration.x * 100)
                }
                
                // 4
                if data.acceleration.y < 0 {
                    self.destY = currentY + CGFloat(data.acceleration.y * 100)
                }
                
                else if data.acceleration.y > 0 {
                    self.destY = currentY + CGFloat(data.acceleration.y * 100)
                }
            })
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
//        for touch in (touches as! Set<UITouch>) {
//            let location = touch.locationInNode(self)
//            
//            let sprite = SKSpriteNode(imageNamed:"Airplane")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
//        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        var action = SKAction.sequence([SKAction.moveToX(destX, duration: 1)
, SKAction.moveToY(destY, duration: 1)])
        self.airplane.runAction(action)
    }
}
