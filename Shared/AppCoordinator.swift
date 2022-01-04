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

    func transition(for url: String) -> TransitionType? {
        var transition: TransitionType?
        switch AppLinks.Root(rawValue: url) {
        case .link1:
            transition = .push
        case .link2:
            transition = .sheet
        case .link3:
            transition = .fullScreenCover
        default:
            break
        }

        return transition
    }

    func onAppear(of url: String) {
        print("\(url) appeared")
    }

    func onDissappear(of url: String) {
        print("\(url) dissappeared")
    }
}
