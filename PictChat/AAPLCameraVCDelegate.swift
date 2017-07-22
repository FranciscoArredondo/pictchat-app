//
//  AAPLCameraVCDelegate.swift
//  PictChat
//
//  Created by Francisco on 7/21/17.
//
//

import Foundation

protocol AAPLCaeraVCDelegate: class {
    
    func videoRecordingComplete(videoUrl: NSURL)
    func videoRecordingFailed()
    func snapshotTaken(snapshotData: NSData)
    func snapShotFailed()
    
}
