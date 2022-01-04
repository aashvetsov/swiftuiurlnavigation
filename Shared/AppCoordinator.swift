//
//  AppCoordinator.swift
//  NavigationDemo
//
//  Created by Артем Швецов on 03.01.2022.
//

import SwiftUI

// TODO: implement without AnyView wrapper
class AppCoordinator: URLCoordinating {

    func destination(for url: String) -> AnyView? {
        var destination: AnyView?
        switch AppLinks.Root(rawValue: url) {
        case .link1:
            destination = AnyView(
                DetailsView()
            )
        case .link2:
            destination = AnyView(
                DetailsView()
            )
        case .link3:
            destination = AnyView(
                DetailsView()
            )
        default:
            break
        }
        
        return destination
    }

    func navigationAction(for url: String) -> NavigationAction? {
        var navigation: NavigationAction?
        switch AppLinks.Root(rawValue: url) {
        case .link1:
            navigation = .push
        case .link2:
            navigation = .sheet
        case .link3:
            navigation = .fullScreenCover
        default:
            break
        }

        return navigation
    }

    func onAppear(of url: String) {
        print("\(url) appeared")
    }

    func onDissappear(of url: String) {
        print("\(url) dissappeared")
    }
}
