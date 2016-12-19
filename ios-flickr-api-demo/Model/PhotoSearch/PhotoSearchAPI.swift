//
//  PhotoSearchAPI.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import Foundation
import ObjectMapper

final class PhotoSearchAPI {

    var loadable: PhotoSearchLoadable?
    fileprivate var isLoading = false

    func waiting() -> Bool {
        return isLoading
    }

    func load(tags: String, page: Int) {

        guard NetworkManager.isAvailable() else {
            self.loadable?.setStatus(status: .offline, result: nil)
            return
        }
        
        isLoading = true

        APIClient().request(
            params: PhotoSearchParamsBuilder.create(tags: tags, page: page)
        ) { [weak self](response) -> () in

            switch response {
            case .Success(let result):
                                
                 if let searchResult = Mapper<PhotoSearchResult>().map(JSONObject: result) {                    
                    let status = self?.hasPhotoList(result: searchResult) ?? .none
                    self?.loadable?.setStatus(status: status, result: searchResult)
                 }

            case .Failure( _):
                self?.loadable?.setStatus(status: .error, result: nil)
            }
            self?.isLoading = false
        }
    }

    fileprivate func hasPhotoList(result: PhotoSearchResult) -> PhotoSearchStatus{

        return (result.photos?.photo.count == 0) ?
            PhotoSearchStatus.noData : PhotoSearchStatus.normal
    }
}
