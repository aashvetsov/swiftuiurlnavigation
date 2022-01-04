//UrlBasedCoordinating//  Deeplinks.swift
//  NavigationDemo
//
//  Created by Артем Швецов on 03.01.2022.
//

import SwiftUI

// MARK: - Public

public enum NavigationAction: String {
    
    case push
    case sheet
    case fullScreenCover
}

public protocol URLCoordinating: AnyObject {

    // MARK: - Mandatory
    func destination(for url: String) -> AnyView?
    func navigationAction(for url: String) -> NavigationAction?

    // MARK: - Child coordinators
    var parentCoordinator: URLCoordinating? { get }
    var childCoordinators: [String: URLCoordinating]? { get }
    func addChild<T: URLCoordinating>(_ coordinator: T)
    func removeChild<T: URLCoordinating>(_ coordinator: T)

    // MARK: - Lifecycle
    func onAppear(of link: String)
    func onDissappear(of link: String)
}

public extension URLCoordinating {

    var parentCoordinator: URLCoordinating? {
        _parentCoordinator
    }

    var childCoordinators: [String: URLCoordinating]? {
        _childCoordinators
    }
}

public extension URLCoordinating {

    func addChild<T: URLCoordinating>(_ coordinator: T) {
        coordinator._parentCoordinator = self
        _childCoordinators?[String(describing: coordinator)] = coordinator
    }
    func removeChild<T: URLCoordinating>(_ coordinator: T) {
        guard let _ = _childCoordinators else {
            return
        }
        _childCoordinators?[String(describing: coordinator)] = nil
    }
    func onAppear(of link: String) {}
    func onDissappear(of link: String) {}
}

// MARK: - Private

private var ParentCoordinatorAssociatedObjectHandle: UInt8 = 0
private var ChildCoordinatorAssociatedObjectHandle: UInt8 = 0
private extension URLCoordinating {

    var _parentCoordinator: URLCoordinating? {
        get {
            return objc_getAssociatedObject(self, &ParentCoordinatorAssociatedObjectHandle) as? URLCoordinating
        }
        set {
            objc_setAssociatedObject(self, &ParentCoordinatorAssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var _childCoordinators: [String: URLCoordinating]? {
        get {
            return objc_getAssociatedObject(self, &ChildCoordinatorAssociatedObjectHandle) as? [String: URLCoordinating] ?? [:]
        }
        set {
            objc_setAssociatedObject(self, &ChildCoordinatorAssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
