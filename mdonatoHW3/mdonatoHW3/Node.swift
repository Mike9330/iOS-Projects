//
//  Node.swift
//  mdonatoHW3
//
//  Created by Michael Donato on 5/19/18.
//  Copyright © 2018 Michael Donato. All rights reserved.
//

import UIKit
import SpriteKit

class NodeObject: SKSpriteNode {
    var node: SKSpriteNode!
    
    var visible = false
    var touched = false
    
    func configure(at position: CGPoint) {
        self.position = position
        
        
    }
    
}
