//
//  DVRViewController.swift
//  mdonatoHW4
//
//  Created by Michael Donato on 2/26/18.
//  Copyright © 2018 Michael Donato. All rights reserved.
//

import UIKit

class DVRViewController: UIViewController {
    @IBOutlet weak var powerStat: UILabel!
    @IBOutlet weak var DVRState: UILabel!
    @IBOutlet weak var power: UISwitch!
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var stop: UIButton!
    @IBOutlet weak var pause: UIButton!
    @IBOutlet weak var fastforward: UIButton!
    @IBOutlet weak var rewind: UIButton!
    @IBOutlet weak var record: UIButton!
    
    
    
    @IBAction func changeState(_ sender: UIButton) {
        
        //if DVR not playing
        let alert = UIAlertController(title: "You can only preform this action while the DVR is playing", message: "Would you like the DVR to start playing?", preferredStyle: UIAlertControllerStyle.alert)
        let yes = (UIAlertAction(title: "Yes", style: .default, handler: playWindow))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(yes)
    
        
        
        //if DVR not stopped
        let recordAlert = UIAlertController(title: "You cannot preform this action unless DVR is stopped", message: "Would you like to stop the DVR?", preferredStyle: UIAlertControllerStyle.alert )
        let recordYes = (UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: recordWindow))
        let recordCancel = (UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        recordAlert.addAction(recordYes)
        recordAlert.addAction(recordCancel)
        
        //playingAlert.addAction((UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)))
        
        //buttons and conditions
        
        if(power.isOn){
            if(sender == play){
                DVRState.text = "Play"
            }
            if(sender == stop){
                DVRState.text = "Stopped"
            }
            if(sender == pause){
                if(DVRState.text == "Play"){
                    DVRState.text = "Pause"
                }
                else{
                    self.present(alert, animated: true, completion: nil)
                }
            }
            if(sender == fastforward){
                if(DVRState.text == "Play"){
                    DVRState.text = "FF"
                }
                else{
                    self.present(alert, animated: true, completion: nil)
                }
            }
            if(sender == rewind){
                if(DVRState.text == "Play"){
                    DVRState.text = "Rewind"
                }
                else{
                    self.present(alert ,animated: true, completion:nil)
                }
            }
            if(sender == record){
                if(DVRState.text == "Stopped"){
                    DVRState.text = "Record"
                }
                else{
                    self.present(recordAlert, animated: true, completion: nil)
                }
            }
            
        }
    }
    
    func playWindow(alertAction: UIAlertAction){
        let playingAlert = UIAlertController(title: "Playing Resumed", message: "Playing has resumed on your DVR", preferredStyle: UIAlertControllerStyle.alert)
        playingAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(playingAlert, animated: true, completion: nil)
        DVRState.text = "Play"
    }
    
    func recordWindow(alertAction: UIAlertAction){
        let stoppedAlert = UIAlertController(title: "DVR Stopped", message: "You may now click record", preferredStyle: UIAlertControllerStyle.alert)
        stoppedAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(stoppedAlert, animated: true, completion: nil)
        DVRState.text = "Stopped"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
