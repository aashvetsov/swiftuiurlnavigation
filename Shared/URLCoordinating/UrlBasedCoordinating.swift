//UrlBasedCoordinating//  Deeplinks.swift
//  NavigationDemo
//
//  Created by Артем Швецов on 03.01.2022.
//

import SwiftUI

public enum NavigationType {
    case push
    case sheet
    case fullScreenCover
}

public struct AppLink {
    let url: String
    let navigationType: NavigationType
    
    init(url: String,
         navigationType: NavigationType = .push) {
        self.url = url
        self.navigationType = navigationType
    }
}

public protocol AppLinkCoordinating {

    // MARK: - Mandatory
    func destination(for link: AppLink) -> AnyView?

    // MARK: - Optional
    func onAppear(of link: AppLink)
    func onDissappear(of link: AppLink)
}

public extension AppLinkCoordinating {

    func onAppear(of link: AppLink) {}
    func onDissappear(of link: AppLink) {}
}
