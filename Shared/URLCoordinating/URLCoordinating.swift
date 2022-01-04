//
//  Deeplinks.swift
//  NavigationDemo
//
//  Created by Артем Швецов on 03.01.2022.
//

import SwiftUI

// MARK: - Public

public enum TransitionType: String {
    
    case push
    case sheet
    case fullScreenCover
    // TODO: case alert()
}

public protocol URLCoordinating: AnyObject {

    // MARK: - Mandatory
    func destination(for url: String) -> AnyView?
    func transition(for url: String) -> TransitionType?

    // MARK: - Child coordinators
    var parentCoordinator: URLCoordinating? { get }
    var childCoordinators: [ObjectIdentifier: URLCoordinating]? { get }
    func addChild<T: URLCoordinating>(_ coordinator: T)
    func removeChild<T: URLCoordinating>(_ coordinator: T)
}

public extension URLCoordinating {

    var parentCoordinator: URLCoordinating? {
        _parentCoordinator
    }

    var childCoordinators: [ObjectIdentifier: URLCoordinating]? {
        _childCoordinators
    }
}

public extension URLCoordinating {

    func addChild<T: URLCoordinating>(_ coordinator: T) {
        let id = ObjectIdentifier(coordinator)
        _childCoordinators?[id] = coordinator
        coordinator._parentCoordinator = self
    }

    func removeChild<T: URLCoordinating>(_ coordinator: T) {
        let id = ObjectIdentifier(coordinator)
        guard nil != _childCoordinators?[id] else {
            return
        }
        _childCoordinators?[id] = nil
        coordinator._parentCoordinator = nil
    }
}

// MARK: - Private

// TODO: find better way to save relations
private var ParentCoordinatorAssociatedObjectHandle: UInt8 = 0
private var ChildCoordinatorAssociatedObjectHandle: UInt8 = 0
private extension URLCoordinating {

    var _parentCoordinator: URLCoordinating? {
        get {
            objc_getAssociatedObject(self, &ParentCoordinatorAssociatedObjectHandle) as? URLCoordinating
        }
        set {
            objc_setAssociatedObject(self, &ParentCoordinatorAssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }

    var _childCoordinators: [ObjectIdentifier: URLCoordinating]? {
        get {
            objc_getAssociatedObject(self, &ChildCoordinatorAssociatedObjectHandle) as? [ObjectIdentifier: URLCoordinating] ?? [:]
        }
        set {
            objc_setAssociatedObject(self, &ChildCoordinatorAssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
}
