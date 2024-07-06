//
//  ProfileRepository.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import Foundation

class ProfileRepository {
    private let localDataSource: CineBrowseLocalDataSource = .shared
    
    func saveProfile(
        for profile: ProfileVO,
        onSuccess: @escaping () -> (),
        onFailure: @escaping (String) -> ()
    )
    {
        do {
            try localDataSource.saveProfile(for: profile)
            onSuccess()
        }
        catch {
            onFailure(error.localizedDescription)
        }
    }
    
    func deleteProfile(
        for profileId: ProfileVO,
        onSuccess: @escaping () -> (),
        onFailure: @escaping (String) -> ()
    )
    {
        do {
            try localDataSource.deleteProfile(for: profileId)
            onSuccess()
        }
        catch {
            onFailure(error.localizedDescription)
        }
    }
}
