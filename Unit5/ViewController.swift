//
//  ViewController.swift
//  Unit5
//
//  Created by Sanjay on 1/31/15.
//  Copyright (c) 2015 sanjay. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!;
    let context = CIContext(options:nil);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func chooseExistingPhoto(){
        let picker = UIImagePickerController();
        
        picker.delegate = self;
        picker.sourceType = .PhotoLibrary;
        self.presentViewController(picker, animated: true, completion: nil);
    }
    
    @IBAction func takeNewPicture(sender: UIButton) {
        let picker = UIImagePickerController();
        picker.delegate = self;
        picker.sourceType = .Camera;
        self.presentViewController(picker, animated: true, completion: nil);
    }
    
    @IBAction func applyFiler(sender: AnyObject) {
        // Create an image to filter
        let inputImage = CIImage(image: imageView.image)
        
        // Create a random color to pass to a filter
        let randomColor = [kCIInputAngleKey: (Double(arc4random_uniform(314)) / 100)]
        
        // Apply a filter to the image
        let filteredImage = inputImage.imageByApplyingFilter("CIHueAdjust", withInputParameters: randomColor)
        
        // Render the filtered image
        let renderedImage = context.createCGImage(filteredImage, fromRect: filteredImage.extent());
        
        // Reflect the change back in the interface
        imageView.image = UIImage(CGImage: renderedImage)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imageView.image = image;
        dismissViewControllerAnimated(true, completion: nil)
    }
}
