//
//  ViewController.swift
//  10.31 practice - custom camera
//
//  Created by Becker, Kathrine V on 10/31/16.
//  Copyright © 2016 Becker, Kathrine V. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var captureImageView: UIImageView!
   
    var session: AVCaptureSession?
    var stillImageOutput: AVCapturePhotoOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        func viewWillAppear(animated: Bool) {
            super.viewWillAppear(animated)
            session = AVCaptureSession()
            session!.sessionPreset = AVCaptureSessionPresetPhoto
            let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            var error: NSError?
            var input: AVCaptureDeviceInput!
            do {
                input = try AVCaptureDeviceInput(device: backCamera)
            } catch let error1 as NSError {
                error = error1
                input = nil
                print(error!.localizedDescription)
            }
            if error == nil && session!.canAddInput(input) {
                session!.addInput(input)
                //Step#10
                stillImageOutput = AVCapturePhotoOutput()
                stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
                if session!.canAddOutput(stillImageOutput) {
                    session!.addOutput(stillImageOutput)
                    //configure live preview here
                    videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
                    videoPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspect
                    videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                    previewView.layer.addSublayer(videoPreviewLayer!)
                    session!.startRunning()
                }
            }
        }
        func viewDidAppear(animated: Bool) {
            super.viewDidAppear(animated)
            videoPreviewLayer!.frame = previewView.bounds
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTakePhoto(_ sender: AnyObject) {
    }

}

