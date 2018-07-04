//
//  SecondViewController.swift
//  Primy
//
//  Created by Firda Rinoa Sahidi on 7/4/18.
//  Copyright © 2018 Firda Rinoa Sahidi. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {
    @IBOutlet weak var cameraView: UIView!
    var session: AVCaptureSession?
    var input: AVCaptureDeviceInput?
    var output: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        session = AVCaptureSession()
        output = AVCaptureStillImageOutput()
        
        //Deteksi kamera depan atau belakang
        func getDevice(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
            let devices: NSArray = AVCaptureDevice.devices() as NSArray;
            for de in devices {
                let deviceConverted = de as! AVCaptureDevice
                if(deviceConverted.position == position){
                    return deviceConverted
                }
            }
            return nil
        }
        
        //Buka kamera
        let camera = getDevice(position: .back)
        do {
            input = try AVCaptureDeviceInput(device: camera!)
        } catch let error as NSError {
            print(error)
            input = nil
        }
        if(session?.canAddInput(input!) == true){
            session?.addInput(input!)
            output?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
            if(session?.canAddOutput(output!) == true){
                session?.addOutput(output!)
                previewLayer = AVCaptureVideoPreviewLayer(session: session!)
                previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                previewLayer?.frame = cameraView.bounds
                cameraView.layer.addSublayer(previewLayer!)
                session?.startRunning()
            
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

