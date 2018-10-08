//
//  GameViewController.swift
//  mdonatoHW3
//
//  Created by Michael Donato on 5/19/18.
//  Copyright © 2018 Michael Donato. All rights reserved.
//
import UIKit
import SpriteKit

class GameViewController: UIViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let scene = GameScene(fileNamed:"GameScene")
        {
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .aspectFill
            skView.presentScene(scene)
        }
    }
    
    func shouldAutorotate() -> Bool {
        return true
    }
    
    func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prefersStatusBarHidden() -> Bool {
        return true
    }
}
