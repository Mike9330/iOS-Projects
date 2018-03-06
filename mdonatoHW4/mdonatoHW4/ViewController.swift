//
//  ViewController.swift
//  mdonatoHW4
//
//  Created by Michael Donato on 2/11/18.
//  Copyright © 2018 Michael Donato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var volume: UISlider!
    @IBOutlet weak var powerStat: UILabel!
    @IBOutlet weak var volumeStat: UILabel!
    @IBOutlet weak var channelStat: UILabel!
    @IBOutlet weak var zero: UIButton!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!
    @IBOutlet weak var power: UISwitch!
    @IBOutlet weak var channUp: UIButton!
    @IBOutlet weak var channDown: UIButton!
    @IBOutlet weak var favChannels: UISegmentedControl!

    var currentChannel = ""
    
    var message: String = "TVViewController"
    
    //Numbered channel buttons
    @IBAction func changeChannel(_ sender: UIButton) {
        if(power.isOn){
            let digitCount = currentChannel.count
            if (digitCount < 2){
                currentChannel = currentChannel + String(sender.tag)
            }
            if (digitCount == 2){
                currentChannel = String(sender.tag)
            }
                channelStat.text = "\(currentChannel)"
        }
    }
    
    //On/Off Switch
    @IBAction func powerPressed(_ sender: UISwitch) {
        var onOff = " "
        if(powerStat.text == "On"){
            onOff = "Off"
        }
        if(powerStat.text == "Off"){
            onOff = "On"
        }
        powerStat.text = "\(onOff)"
    }
    //Ch+ and Ch- buttons
    @IBAction func incrementChannel(_ sender: UIButton) {
        if(power.isOn){
            var intChannel = (Int(currentChannel))!
            if(sender == channUp){
                intChannel = intChannel + 1
            }
            if(sender == channDown){
                intChannel = intChannel - 1
            }
        currentChannel = (String(intChannel))
        channelStat.text = "\(currentChannel)"
        }
    }
    //Automatically switches between ABC (7), NBC (5), CBS(2), and FOX(12)
    @IBAction func favSwitcher(_ sender: UISegmentedControl) {
        if(power.isOn){
            if(sender.selectedSegmentIndex == 0){
                channelStat.text = "7"
            }
            if(sender.selectedSegmentIndex == 1){
                channelStat.text = "5"
            }
            if(sender.selectedSegmentIndex == 2){
                channelStat.text = "2"
            }
            if(sender.selectedSegmentIndex == 3){
                channelStat.text = "12"
            }
        }
    }
    //Volume slider
    @IBAction func changeVolume(_ sender: UISlider) {
        if(power.isOn){
            volumeStat.text = "\(Int(sender.value))"
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

    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        
    }

}

