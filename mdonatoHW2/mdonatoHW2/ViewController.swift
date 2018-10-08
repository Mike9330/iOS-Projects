//
//  ViewController.swift
//  mdonatoHW2
//
//  Created by Michael Donato on 5/13/18.
//  Copyright © 2018 Michael Donato. All rights reserved.
//

import UIKit


struct Train: Decodable
{
    let tmst: String
    let errCd: String
    let errNum: String
    let route: String
    
}

var fetchedTrainInfo = [Train]()
class ViewController: UIViewController
{
    
    var trains = [Train]()
    @IBOutlet weak var jacksonInfo: UILabel!
    @IBOutlet weak var routeView: UIImageView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       getJSON()
    }
    
    func getJSON()
    {
        fetchedTrainInfo = []
        let urlString = "http://lapi.transitchicago.com/api/1.0/ttpositions.aspx?key=9d2aba3659764559a4708c52dc3c1e95&rt=red&outputType=JSON"
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request){ (data, response, error) in
            if error != nil
            {
                print ("Somethings wrong with the dataTask")
            }
            else{
                do{
                    let dataFetched = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSDictionary
                    //var ctaDict = [String: String]
                    if let ctaDict = (dataFetched as NSDictionary).value(forKey: "ctatt")
                    {
                        if let routeArray = (ctaDict as! NSDictionary).value(forKey: "route")
                        {
                            if let train = (routeArray as! NSObject).value(forKey: "train")
                            {
                                if let arrT = (train as! NSObject).value(forKey: "arrT")
                                {
                                    print(arrT)
                                    self.jacksonInfo.text = "\(arrT)"
                                }
                                
                            }
                            
                        }
                        
                    }
                }
                catch
                {
                    print("Somethings wrong with JSONSerialization")
                }
            }
        }
        task.resume()
    }
}

