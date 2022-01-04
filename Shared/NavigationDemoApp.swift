//
//  NavigationDemoApp.swift
//  Shared
//
//  Created by Артем Швецов on 03.01.2022.
//

import SwiftUI

@main
struct NavigationDemoApp: App {
    
    private let appCoordinator = AppCoordinator()
    private let detailsCoordinator = DetailsCoordinator()

    init() {
        DependencyContainer.register(appCoordinator)
        DependencyContainer.register(detailsCoordinator)
        appCoordinator.addChild(detailsCoordinator)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
