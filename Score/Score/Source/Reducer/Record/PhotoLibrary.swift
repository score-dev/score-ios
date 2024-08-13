//
//  PhotoLibrary.swift
//  Score
//
//  Created by sole on 7/22/24.
//

import UIKit
import Photos
import os.log

actor PhotoLibrary {
    static let shared: PhotoLibrary = .init()
    
    private init() {}
    
    func requestAuthorization() async {
        switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
        case .authorized:
            break
        case .denied:
            // go to setting
            logger.debug("갤러리 접근 권한이 없습니다.")
            break
        case .limited:
            break
        case .notDetermined:
            await PHPhotoLibrary.requestAuthorization(for: .readWrite)
        case .restricted:
            break
        @unknown default:
            logger.debug("알 수 없는 갤러리 접근 권한")
            break
        }
    }
    
    func saveImage(imageData: Data) async throws {
        try await PHPhotoLibrary.shared().performChanges {
            let creationRequest = PHAssetCreationRequest.forAsset()
            guard let assetPlaceholder = creationRequest.placeholderForCreatedAsset
            else { return }
            creationRequest.addResource(with: .photo, data: imageData, options: nil)
            
            guard let assetCollection = PHAssetCollection.fetchAssetCollections(
                with: .album,
                subtype: .any,
                options: nil
            ).firstObject,
                  assetCollection.canPerform(.addContent),
                  let albumChangeRequest = PHAssetCollectionChangeRequest(for: assetCollection)
            else { return }
            
            albumChangeRequest.addAssets(NSArray(array: [assetPlaceholder]))
        }
    }
    
    func fetchAssets() {
        PHAssetCollection.fetchAssetCollections(
            with: .album,
            subtype: .any,
            options: nil
        )
    }
}

fileprivate let logger = Logger(subsystem: "com.sole.Score", category: "PhotoLibrary")
