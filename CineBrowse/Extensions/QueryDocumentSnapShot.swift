//
//  QueryDocumentSnapShot.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/12/24.
//

import Foundation
import FirebaseFirestore

extension QueryDocumentSnapshot {
    func fromDicToObject<T: Decodable>() -> T? {
        return self.data().toObject()
    }
}
