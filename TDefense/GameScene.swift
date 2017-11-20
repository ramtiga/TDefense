//
//  GameScene.swift
//  TDefense
//
//  Created by Dai Haneda on 2017/11/21.
//  Copyright © 2017年 Dai Haneda. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
      let fieldImageSize : CGFloat = 16
      
      for i in Int(-self.frame.width / 2)...Int(self.frame.width / 2) + 1{
        for j in Int(-self.frame.height / 2)...Int(self.frame.height / 2) + 1{
          let field = SKSpriteNode(imageNamed: "Field")
          field.position = CGPoint(x: CGFloat(i) * fieldImageSize, y: CGFloat(j) * fieldImageSize)
          field.zPosition = -1
          self.addChild(field)
        }
      }
        
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
