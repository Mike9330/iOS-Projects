//
//  ViewController.swift
//  mdonatoHW4
//
//  Created by Michael Donato on 5/24/18.
//  Copyright © 2018 Michael Donato. All rights reserved.
//
import UIKit
import CoreLocation
import MapKit
struct Train: Decodable
{
    let tmst: String
    let errCd: String
    let errNum: String
    let route: String
    
}
var fetchedTrainInfo = [Train]()

class ViewController: UIViewController, CLLocationManagerDelegate
{
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!

    var StringArray = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        let status = CLLocationManager.authorizationStatus()
        if status == .denied || status == .restricted
        {
            message.text = "Location service not authorized"
        }
        else
        {
            //get placement data from JSON api
            getJSON();
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 1 // meter
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            
            //shows users location
            mapView.showsUserLocation = true
            
            getDirections(enterdLocations: StringArray)
        }
    }
    
    func getJSON()
    {
        fetchedTrainInfo = []
        let urlString = "http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=9d2aba3659764559a4708c52dc3c1e95&max=1&mapid=40560&outputType=JSON"
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
        typealias JSONDictionary = [String:Any]
        
        let task = session.dataTask(with: request){ (data, response, error) in
            if error != nil
            {
                print ("Somethings wrong with the dataTask")
            }
            else
            {
                
                do
                {
                    //return needed JSON info
                    let dataFetched = try JSONSerialization.jsonObject(with: data!) as? JSONDictionary
                    let ctatt = dataFetched!["ctatt"] as? JSONDictionary
                    let eta = ctatt!["eta"] as? [JSONDictionary]
                    let zero = eta![0] as? JSONDictionary
                    
                    //arrival time
                    let arrT = zero!["arrT"] as? String
                    
                    //lat and lon of train
                    let lat = zero!["lat"] as! String
                    let lon = zero!["lon"] as! String
                    
                    self.StringArray.insert(lat, at: 0)
                    self.StringArray.insert(lon, at: 1)
                    
                    self.arrivalLabel.text = "\(arrT!)"
                    
                    
                }
                catch
                {
                    print("Somethings wrong with JSONSerialization")
                }
            }
        }
        task.resume()
    }

    
    override func viewWillAppear(_ animated: Bool)
    {
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    

    
    var annotation: MKAnnotation?
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
      
    }
    
    func getDirections(enterdLocations:[String])  {
        // array has the address strings
        var locations = [MKPointAnnotation]()
        for item in enterdLocations {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(item, completionHandler: {(placemarks, error) -> Void in
                if((error) != nil){
                    print("Error", error!)
                }
                if let placemark = placemarks?.first {
                    
                    let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                    
                    let dropPin = MKPointAnnotation()
                    dropPin.coordinate = coordinates
                    dropPin.title = item
                    self.mapView.addAnnotation(dropPin)
                    self.mapView.selectAnnotation( dropPin, animated: true)
                    
                    locations.append(dropPin)
                    //add this if you want to show them all
                    self.mapView.showAnnotations(locations, animated: true)
                }
            })
        }
    }
    
}

class Place : NSObject, MKAnnotation
{
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(_ coordinate: CLLocationCoordinate2D,
         _ title: String? = nil,
         _ subtitle: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
