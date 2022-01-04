//
//  AbstractCoordinator.swift
//  NavigationDemo
//
//  Created by Артем Швецов on 03.01.2022.
//

import SwiftUI

// MARK: - Public

public protocol Coordinatable {
    
    associatedtype CoordinatorType: URLCoordinating

    var coordinator: CoordinatorType { get set }
}

public extension View {

    func coordinatable<T: URLCoordinating>(to url: String,
                                           by coordinator: T) -> some View {
        modifier(
            NavigationRoute(url: url,
                            coordinator: coordinator)
        )
    }
}

// MARK: - Private

private struct NavigationRoute<CoordinatorType: URLCoordinating>: ViewModifier  {

    private let url: String
    private weak var coordinator: CoordinatorType?
        
    init(url: String,
         coordinator: CoordinatorType) {
        self.url = url
        self.coordinator = coordinator
    }
    
    func body(content: Content) -> some View {
        if  let coordinator = coordinator,
            let destination = coordinator.destination(for: url),
            let navigation = coordinator.navigationAction(for: url){
            switch navigation {
            case .push:
                content.pushable(to: destination,
                                 at: url,
                                 coordinatedBy: coordinator)
            case .sheet:
                content.presentable(with: destination,
                                    at: url,
                                    coordinatedBy: coordinator)
            case .fullScreenCover:
                content.fullScreenCoverable(with: destination,
                                            at: url,
                                            coordinatedBy: coordinator)
            }
        }
        else {
            content
        }
    }
}

private struct PushViewModifier<CoordinatorType: URLCoordinating>: ViewModifier {

    private let destination: AnyView
    private let url: String
    private weak var coordinator: CoordinatorType?

    init(with destination: AnyView,
         at url: String,
         coordinatedBy coordinator: CoordinatorType) {
        self.destination = destination
        self.url = url
        self.coordinator = coordinator
    }

    // TODO: onLoad(of link:)
    // TODO: onDismiss(of link:)
    func body(content: Content) -> some View {
        NavigationLink(destination:
            destination
                .onAppear {
                    coordinator?.onAppear(of: url)
                }
                .onDisappear {
                    coordinator?.onDissappear(of: url)
                }
        ) {
            content
        }
    }
}

private struct PresentViewModifier<CoordinatorType: URLCoordinating>: ViewModifier {

    private let destination: AnyView
    private let url: String
    private weak var coordinator: CoordinatorType?
    @State private var isPresented = false

    init(with destination: AnyView,
         at url: String,
         coordinatedBy coordinator: CoordinatorType) {
        self.destination = destination
        self.url = url
        self.coordinator = coordinator
    }

    // TODO: onLoad(of link:)
    // TODO: onDismiss(of link:)
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                destination
                    .onAppear {
                        coordinator?.onAppear(of: url)
                    }
                    .onDisappear {
                        coordinator?.onDissappear(of: url)
                    }
            }
            .onTapGesture {
                isPresented.toggle()
            }
    }
}

private struct FullScreenCoverViewModifier<CoordinatorType: URLCoordinating>: ViewModifier {

    private let destination: AnyView
    private let url: String
    private weak var coordinator: CoordinatorType?
    @State private var isPresented = false

    init(with destination: AnyView,
         at url: String,
         coordinatedBy coordinator: CoordinatorType) {
        self.destination = destination
        self.url = url
        self.coordinator = coordinator
    }

    // TODO: onLoad(of link:)
    // TODO: onDismiss(of link:)
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                destination
                    .onAppear {
                        coordinator?.onAppear(of: url)
                    }
                    .onDisappear {
                        coordinator?.onDissappear(of: url)
                    }
            }
            .onTapGesture {
                isPresented.toggle()
            }
    }
}

private extension View {
    
    func pushable<T: URLCoordinating>(to destination: AnyView,
                                          at url: String,
                                          coordinatedBy coordinator: T) -> some View {
        modifier(PushViewModifier(with: destination,
                                  at: url,
                                  coordinatedBy: coordinator))
    }

    func presentable<T: URLCoordinating>(with destination: AnyView,
                                             at url: String,
                                             coordinatedBy coordinator: T) -> some View {
        modifier(PresentViewModifier(with: destination,
                                     at: url,
                                     coordinatedBy: coordinator))
    }

    func fullScreenCoverable<T: URLCoordinating>(with destination: AnyView,
                                                     at url: String,
                                                     coordinatedBy coordinator: T) -> some View {
        modifier(FullScreenCoverViewModifier(with: destination,
                                             at: url,
                                             coordinatedBy: coordinator))
    }
}
