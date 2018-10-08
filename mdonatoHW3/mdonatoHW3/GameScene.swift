//
//  GameScene.swift
//  mdonatoHW3
//
//  Created by Michael Donato on 5/19/18.
//  Copyright © 2018 Michael Donato. All rights reserved.
//

import SpriteKit
import CoreMotion
let manager = CMMotionManager()
enum CollisionTypes: UInt32
{
    case ball = 1
    case red = 16
}


class GameScene: SKScene
{
    let manager = CMMotionManager()
    var lastPosition: CGPoint?
    var scoreBoard: SKLabelNode!
    var lives: SKLabelNode!
    var over = false
    
    var ball = SKSpriteNode()
    var trap = SKSpriteNode()
    var finish = SKSpriteNode()
    var playerLives = 5
    {
        didSet
        {
            lives.text = "Lives Remaining: \(playerLives)"
        }
    }
    var score = 0 {
        didSet {
            scoreBoard.text = "Score: \(score)"
            
        }
    }
    override func didMove(to view: SKView)
    {
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main)
        {
            (data, error) in
            self.physicsWorld.gravity = CGVector(dx: (data?.acceleration.x)! * 20, dy: (data?.acceleration.y)! * 20)
            
        }
        createBall();
        createTrap();
        
    }
    func createBall()
    {
        ball = SKSpriteNode(imageNamed: "ball")
        ball.position = CGPoint(x: -867.94, y: 322.929)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width)
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.linearDamping = 0.5
        ball.physicsBody?.categoryBitMask = CollisionTypes.ball.rawValue
        ball.physicsBody?.contactTestBitMask = CollisionTypes.red.rawValue
        addChild(ball)
    }
    
    
    func createTrap() {
        let trap = SKSpriteNode(imageNamed: "trap")
        trap.name = "trap"
        trap.position = CGPoint(x: Rand(min: -850, max: 850), y: Rand(min: -400, max: 400))
        trap.physicsBody = SKPhysicsBody(circleOfRadius: trap.size.width)
        trap.physicsBody?.isDynamic = false
        
        trap.physicsBody?.categoryBitMask = CollisionTypes.red.rawValue
        trap.physicsBody?.contactTestBitMask = CollisionTypes.ball.rawValue
        trap.physicsBody?.collisionBitMask = 0
        addChild(trap)
    }
    
    func collidedWith(with node: SKNode)
    {
        if node.name == "trap"
        {
            ball.physicsBody?.isDynamic = false
            playerLives -= 1
            if playerLives == 0
            {
                self.over = true
                let gameOver = SKSpriteNode(imageNamed: "gameOver")
                gameOver.position = CGPoint(x: 512, y: 384)
                addChild(gameOver)
                return
            }
            let move = SKAction.move(to: node.position, duration: 0.25)
            let scale = SKAction.scale(to: 0.0001, duration: 0.25)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move, scale, remove])
            
            ball.run(sequence) { [unowned self] in
                self.createBall()
                self.over = false
            }
            
        }
    }
    func Rand(min: Double, max: Double) -> Double
    {
        return (Double(arc4random()) / Double(UInt32.max)) * (max - min) + min
    }
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
