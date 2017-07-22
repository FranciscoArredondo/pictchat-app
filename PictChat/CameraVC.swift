//
//  CameraVC.swift
//  PictChat
//
//  Created by Francisco on 7/19/17.
//
//

import UIKit
import FirebaseAuth

class CameraVC: AAPLCameraViewController, AAPLCaeraVCDelegate {

    @IBOutlet weak var previewView: AAPLPreviewView!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var photoButton: UIButton!
    
    @IBOutlet weak var resumeButton: UIButton!
    
    @IBOutlet weak var cameraUnavailableLabel: UILabel!
    
    override func viewDidLoad() {
        
        // match up buttons and controls to superview counterparts
        _previewView = previewView
        _cameraButton = cameraButton
        _recordButton = recordButton
        _photoButton = photoButton
        _resumeButton = resumeButton
        _cameraUnavailableLabel = cameraUnavailableLabel
        
        delegate = self
        
        super.viewDidLoad()
        
        // start app in video recording mode
        toggleCaptureMode(captureMode: .movie)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard Auth.auth().currentUser != nil else {
            performSegue(withIdentifier: "LoginVC", sender: nil)
            return
        }
    }
    
    func videoRecordingFailed() {
        print("PF: Video recording failed")
    }
    
    func videoRecordingComplete(videoUrl: NSURL) {
        print("PF: videoRecordingComplete delegate func was called!")
        performSegue(withIdentifier: "UsersVC", sender: ["videoUrl":videoUrl])
    }
    
    func snapShotFailed() {
        print("PF: Snapshot failed")
    }
    
    func snapshotTaken(snapshotData: NSData) {
        performSegue(withIdentifier: "UsersVC", sender: ["snapshotData":snapshotData])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let usersVC = segue.destination as? UsersVC {
            if let videoDict = sender as? Dictionary<String, URL> {
                let url = videoDict["videoUrl"]
                usersVC.videoUrl = url! as NSURL
            } else if let snapDict = sender as? Dictionary<String, Data> {
                let snapData = snapDict["snapshotData"]
                usersVC.snapData = snapData
            }
        }
    }
    

    @IBAction func recordButtonPressed(_ sender: UIButton) {
        toggleMovieRecording()
    }
    
    @IBAction func changeCameraButtonPressed(_ sender: UIButton) {
        changeCamera()
    }
    
    @IBAction func resumeButtonPressed(_ sender: UIButton) {
        resumeInterruptedSession()
    }
    
    @IBAction func photoButtonPressed(_ sender: UIButton) {
        capturePhoto()
    }
    
    
    
}

