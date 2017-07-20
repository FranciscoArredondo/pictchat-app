//
//  AAPLCameraVCDelegate.swift
//  PictChat
//
//  Created by Francisco on 7/20/17.
//
//

import Foundation

protocol AAPLCameraVCDelegate: class {
    func shouldEnableCameraButton(enabled: Bool)
    func shouldEnableRecordButton(enabled: Bool)
    func shouldEnablePhotoButton(enabled: Bool)
}
