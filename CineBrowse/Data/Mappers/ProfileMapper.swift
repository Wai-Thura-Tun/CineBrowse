//
//  ProfileMapper.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import Foundation

extension ProfileVO {
    func toEntity() -> ProfileEntity {
        return ProfileEntity.init(
            uid: self.uid,
            name: self.name,
            email: self.email,
            photoUrl: self.photoUrl
        )
    }
}

extension ProfileEntity {
    func toVO() -> ProfileVO {
        return ProfileVO.init(
            uid: self.uid,
            name: self.name,
            email: self.email,
            photoUrl: self.photoUrl
        )
    }
}
