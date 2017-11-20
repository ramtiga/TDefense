//
//  GameScene.swift
//  TDefense
//
//  Created by Dai Haneda on 2017/11/21.
//  Copyright © 2017年 Dai Haneda. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
  static let Char : UInt32 = 0x1 << 1
  static let Enemy : UInt32 = 0x1 << 2
}

class GameScene: SKScene, SKPhysicsContactDelegate {
  enum State {
    case Playing
    case GameClear
    case GameOver
  }
  var state = State.Playing
  
  let enemy = SKSpriteNode(imageNamed: "Enemy")
  let char = SKSpriteNode(imageNamed: "Char")

  override func didMove(to view: SKView) { let fieldImageSize : CGFloat = 32
    
    self.physicsWorld.contactDelegate = self
    self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    
    for i in Int(-self.frame.width / 2)...Int(self.frame.width / 2) + 1{
      for j in Int(-self.frame.height / 2)...Int(self.frame.height / 2) + 1{
        let field = SKSpriteNode(imageNamed: "Field")
        field.position = CGPoint(x: CGFloat(i) * fieldImageSize, y: CGFloat(j) * fieldImageSize)
        field.zPosition = -1
        self.addChild(field)
        
      }
    }
    //敵キャラ
    enemy.position = CGPoint(x: -100, y: 0)
    enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
    enemy.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
    enemy.physicsBody?.collisionBitMask = PhysicsCategory.Char
    enemy.physicsBody?.contactTestBitMask = PhysicsCategory.Char
    self.addChild(enemy)
    
    //味方キャラ
    char.position = CGPoint(x: 100, y: 0)
    char.physicsBody = SKPhysicsBody(rectangleOf: char.size)
    char.physicsBody?.categoryBitMask = PhysicsCategory.Char
    char.physicsBody?.collisionBitMask = PhysicsCategory.Enemy
    char.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
    self.addChild(char)
    
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
  }
  
  override func update(_ currentTime: TimeInterval) {
    // Called before each frame is rendered
    if state == .Playing {
      enemy.position.x += 10
      if enemy.position.x > self.frame.width / 2 {
        state = .GameOver
        let gameOverLbl = SKLabelNode()
        gameOverLbl.text = "Game　Over"
        gameOverLbl.fontName = "HiraginoSans-W6"
        gameOverLbl.position = CGPoint(x: 0, y: 0)
        gameOverLbl.fontSize = 45
        self.addChild(gameOverLbl)
      }
      
    }
  }
  
  func didBegin(_ contact: SKPhysicsContact) {
    if contact.bodyA.categoryBitMask == PhysicsCategory.Char && contact.bodyB.categoryBitMask == PhysicsCategory.Enemy ||
       contact.bodyB.categoryBitMask == PhysicsCategory.Char && contact.bodyA.categoryBitMask == PhysicsCategory.Enemy {
      
      state = .GameClear
      enemy.removeFromParent()
      
      let gameClearLbl = SKLabelNode(fontNamed: "HiraginoSans-W6")
      gameClearLbl.text = "Clear"
      gameClearLbl.position = CGPoint(x: 0, y: 0)
      gameClearLbl.fontSize = 45
      self.addChild(gameClearLbl)
    }
  }
}
