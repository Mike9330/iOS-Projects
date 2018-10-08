//
//  ArrayView.swift
//  mdonatoHW1
//
//  Created by Michael Donato on 4/16/18.
//  Copyright © 2018 Michael Donato. All rights reserved.
//

import UIKit
//Arrayview for first graph

class ArrayView: UIView {
    @IBInspectable var color: UIColor = UIColor.green
    
    var data = [ 1, 2, 3, 4, 5, 6, 7, 8 ] //[Int]()
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        if data.count > 0{
            let gap = 2
            let w = Int(bounds.width) / data.count - gap
            let h = Int(bounds.height) / data.count
            context.setFillColor(color.cgColor)
            for i in 0 ..< data.count {
                context.fill(CGRect(x: i * (w + gap), y: Int(bounds.height), width: w , height: -data[i] * h))
            }
        }
    }
}
