//
//  ViewController.swift
//  mdonatoHW5
//
//  Created by Michael Donato on 2/20/18.
//  Copyright © 2018 Michael Donato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var newlist: UIButton!
    @IBOutlet weak var newitem: UIButton!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var list: UILabel!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var quantity: UITextField!
    
    var shopList: String = ""
    
    let warning = UIAlertController(title: "Invalid", message: "Please Try again", preferredStyle: UIAlertControllerStyle.alert)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func newitem(_ sender: UIButton) {
        descriptionText.text = ""
        quantity.text = ""
    }
    
    @IBAction func newlist(_ sender: UIButton) {
        shopList = ""
        list.text = ""
    }
    @IBAction func add(_ sender: UIButton) {
        let qVal = String(String(quantity.text!))
        let dVal = (String(descriptionText.text!))
         let num = Int(qVal)
        if (num != nil) {
            if (qVal != "" && dVal != "")  {
                let single = qVal + "  " + dVal
                shopList = "\(String(shopList))\n  \(String(single))"
                list.text = shopList
                    }
        }
        else
            {
                warning.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(warning, animated: true, completion: nil)
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ended(_ sender: UITextField) {
        sender.resignFirstResponder();
    }
        
}

