//
//  UserEntity.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import Foundation
import RealmSwift

class ProfileEntity: Object {
    @Persisted(primaryKey: true) var uid: String = ""
    @Persisted var name: String = ""
    @Persisted var email: String = ""
    @Persisted var photoUrl: String = ""
    
    convenience init(
        uid: String,
        name: String,
        email: String,
        photoUrl: String
    ) {
        self.init()
        self.uid = uid
        self.name = name
        self.email = email
        self.photoUrl = photoUrl
    }
}
