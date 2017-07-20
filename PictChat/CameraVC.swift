//
//  CameraVC.swift
//  PictChat
//
//  Created by Francisco on 7/19/17.
//
//

import UIKit

class CameraVC: AAPLCameraViewController {

    @IBOutlet weak var previewView: AAPLPreviewView!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var photoButton: UIButton!
    
    @IBOutlet weak var livePhotoButton: UIButton!
    
    @IBOutlet weak var captureModeControl: UISegmentedControl!
    
    @IBOutlet weak var resumeButton: UIButton!
    
    @IBOutlet weak var capturingLivePhotoLabel: UILabel!
    
    @IBOutlet weak var cameraUnavailableLabel: UILabel!
    
    override func viewDidLoad() {
        
        // match up buttons and controls to superview counterparts
        _previewView = previewView
        _cameraButton = cameraButton
        _recordButton = recordButton
        _photoButton = photoButton
//        _livePhotoModeButton = livePhotoButton
//        _captureModeControl = captureModeControl
        _resumeButton = resumeButton
        _cameraUnavailableLabel = cameraUnavailableLabel
        _capturingLivePhotoLabel = capturingLivePhotoLabel
        
        
        super.viewDidLoad()
        toggleCaptureMode(captureMode: .movie)
    }

    @IBAction func recordButtonPressed(_ sender: UIButton) {
        toggleMovieRecording()
    }
    
    @IBAction func changeCameraButtonPressed(_ sender: UIButton) {
        changeCamera()
    }
    
    @IBAction func captureControlValueChanged(_ sender: UISegmentedControl) {
//        toggleCaptureMode()
    }
    
    @IBAction func resumeButtonPressed(_ sender: UIButton) {
        resumeInterruptedSession()
    }
    
    @IBAction func photoButtonPressed(_ sender: UIButton) {
        capturePhoto()
    }
    
    @IBAction func livePhotoToggleButtonPressed(_ sender: UIButton) {
//        toggleLivePhotoMode()
    }
}

