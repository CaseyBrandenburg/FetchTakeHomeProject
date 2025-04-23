//
//  LoadState.swift
//  FetchTakeHomeProject
//
//  Created by Casey Brandenburg on 4/22/25.
//

import Foundation

/// Represents the loading state of a network query or API call
enum LoadState {
    case idle // No load operation has been attempted yet
    case loading // Load operation is currently underway
    case success // Load operation was successfully completed
    case failed // Load operation was attempted and failed
}

