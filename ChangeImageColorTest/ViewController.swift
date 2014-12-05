//
//  ViewController.swift
//  ChangeImageColorTest
//
//  Created by TakanoriMatsumoto on 2014/12/05.
//  Copyright (c) 2014年 TakanoriMatsumoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var imageView = UIImageView()
    private let originalImage = UIImage(named: "CIFilter.gif")!
    private var bgImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imageView = UIImageView(frame: self.view.frame)
        imageView.image = bgImage
        self.view.addSubview(imageView)
        
        setImageWithColor(1)
        
        // color controller
        let slider = UISlider(frame: CGRectMake(0, 0, 100, 100))
        slider.addTarget(self, action: "colorChanged:", forControlEvents: UIControlEvents.ValueChanged)
        slider.center.x = view.frame.width / 2
        slider.center.y = 100
        self.view.addSubview(slider)
        
    }
    
    private var currentValue: Float?
    func colorChanged(slider: UISlider) {
        var newVal = Float(Int(slider.value * 10)) / 10
        let multiplier: Float = 4
        newVal = newVal * multiplier

        if currentValue != newVal {
            currentValue = newVal
            setImageWithColor(currentValue!)
        }
    }
    
    func setImageWithColor(value: Float) {
        var ciImage = CIImage(image: originalImage)
        var ciFilter = CIFilter(name: "CIHueAdjust")!
        let transform = CGAffineTransformIdentity
        let val = NSValue(CGAffineTransform: transform)!
        
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(value, forKey: "inputAngle")

        let ciContext = CIContext(options: nil)
        let cgimg = ciContext.createCGImage(ciFilter.outputImage, fromRect: ciFilter.outputImage.extent())
        let newImage = UIImage(CGImage: cgimg, scale: 1.0, orientation: UIImageOrientation.Up)
        
        imageView.image = newImage
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

