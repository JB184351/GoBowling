//
//  ViewController.swift
//  GoBowling
//
//  Created by Justin Bengtson on 3/27/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    var matchingItems: [MKMapItem] = [MKMapItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        getBowlingLocations()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
        
    }
    
    // Checking if Location Services are availiable on the users device
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
            showLocationDisabledPopUp()
        }
    }
    
    // What kind of permissions did the user give the app?
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            // Blue Dote on the map
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert instructing them how to turn on permissions
            showLocationDisabledPopUp()
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        @unknown default:
            fatalError()
        }
    }
    
    // Gets location of Bowling Locations around the User's current area and displays each location result on the map
    func getBowlingLocations() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Bowling"
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response, error) in
            if response == nil {
                print("ERROR")
            }
            else {
                // Removing annotations
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                // Shows all bowling location results based on query made when launching the app
                for item in response!.mapItems {
                    print("Name = \(String(describing: item.name))")
                    print("Phone = \(String(describing: item.phoneNumber))")
                    self.matchingItems.append(item as MKMapItem)
                    print("Matching items = \(self.matchingItems.count)")
                    let annotation = MKPointAnnotation()
                    annotation.title = item.name
                    annotation.coordinate = item.placemark.coordinate
                    self.mapView.addAnnotation(annotation)
                }
                
            }
            
        
    })
}
    
 
    // Whenever a user taps on an annotation this function will execute
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if let annotationTitle = view.annotation?.title {
            print("User has tapped on the annotation with the title: \(annotationTitle!)")
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        // Resizing the image for annotations
        let annotationImage = UIImage(named: "bowlingannotation")
        let size = CGSize(width: 50, height: 50)
        UIGraphicsBeginImageContext(size)
        annotationImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = resizedImage
        }
        
        return annotationView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // If users disables location they will get this pop up when the app tries to access location services again
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Background Location Access Disabled", message: "In order to find a place to go bowling we need your location", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
        // Once we get the users location we use this method to stop updating the user's location
        locationManager.stopUpdatingLocation()
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
