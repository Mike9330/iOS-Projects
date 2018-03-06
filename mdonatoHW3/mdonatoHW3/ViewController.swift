//
//  ViewController.swift
//  mdonatoHW3
//
//  Created by Michael Donato on 1/30/18.
//  Copyright © 2018 Michael Donato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!
    @IBOutlet weak var zero: UIButton!
    @IBOutlet weak var equals: UIButton!
    @IBOutlet weak var plus: UIButton!
    
    var nums: [Int]=[]
    var answer = 0
    
    @IBOutlet weak var display: UILabel!
    @IBAction func pressed(_ sender: UIButton) {
        if let title = sender.currentTitle {
            display.text = "\(title)"
            nums.append(sender.tag)
        }
    }
}
    
func viewDidLoad() {
        viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

func didReceiveMemoryWarning() {
        didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


