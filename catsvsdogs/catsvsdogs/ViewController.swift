//
//  ViewController.swift
//  catsvsdogs
//
//  Created by Justin Bengtson on 2/8/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit
import CoreML
import Vision 

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    @IBOutlet weak var thePic: UIImageView!
    @IBOutlet weak var theResults: UILabel!
    
    // Dog and cat model
    let dogsandcat = dogandcats()
    
    // Runs main program
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        detectImage()
        }

    
    // Allows user to select a photo from their devices
    @IBAction func uploadImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true) {
            // after it is complete
        }
        
    }
    
    // Sets the picture variable to the image chosen
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            thePic.image = image
        }
        
        else{
            print("Got an error") 
        }
        
        
        self.dismiss(animated: true, completion: nil)
        detectImage()
    }
    
    // Checks if the image is a cat or dog
    func detectImage() {
        theResults.text = "Thinking"
        
        guard let catdog = try? VNCoreMLModel(for: dogandcats().model) else {
            fatalError("Failed to load the model")
        }
        
        let request = VNCoreMLRequest(model: catdog) {[weak self] request, error in
            guard let results = request.results  as? [VNClassificationObservation],
                let topResult = results.first
                else
            {
                fatalError("Unexpected Results")
            }
            
            // Update main UI Thread with result
            DispatchQueue.main.async { [weak self] in
                self?.theResults.text = "\(topResult.identifier) with \(Int(topResult.confidence * 100))% confidence"
            }
            
            
        }
        
        guard let ciImage = CIImage(image: self.thePic.image!)
            else {fatalError("Can't create CIImage from UImage")}
        
        // Run the dogandcats classifier
        let handler = VNImageRequestHandler(ciImage: ciImage)
        DispatchQueue.global().async {
            do {
                try handler.perform([request])
            }
            catch {
                print(error)
            }
        }
    }
    }

