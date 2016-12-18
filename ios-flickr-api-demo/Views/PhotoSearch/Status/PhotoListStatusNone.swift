//
//  PhotoListStatusNone.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2016/12/18.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class PhotoListStatusNone: PhotoListStatusable {

    let commonStatusable = PhotoListStatusCommon()

    func numberOfItemsInSection(photos: [Photo]) -> Int {
        return commonStatusable.numberOfItemsInSection(photos: photos)
    }

    func create(collectionView: UICollectionView,
                indexPath: IndexPath,
                photo: Photo?) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoListIllegalCollectionViewCell.identifier,
            for: indexPath) as! PhotoListIllegalCollectionViewCell
        cell.message = NSLocalizedString("MSG_NONE", comment: "")
        return cell
    }

    func cellSize(topOf: PhotoListViewController) -> CGSize {
        return commonStatusable.cellSize(topOf: topOf)
    }

    func updateView(result: PhotoSearchResult?, topOf: PhotoListViewController) {
        commonStatusable.updateView(result: result, topOf: topOf)
    }
}
