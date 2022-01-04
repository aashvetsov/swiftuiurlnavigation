//
//  ContentView.swift
//  Shared
//
//  Created by Артем Швецов on 03.01.2022.
//

import SwiftUI

struct ContentView: View, Coordinatable {
    
    @Injected var coordinator: AppCoordinator
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 40) {

                    Text("Navigation Link #1")
                        .coordinatable(to: AppLinks.Root.link1.rawValue,
                                       by: coordinator)
                        .foregroundColor(.black)

                    Text("Presentation Link #2")
                        .coordinatable(to: AppLinks.Root.link2.rawValue,
                                       by: coordinator)
                        .foregroundColor(.green)

                    Text("FullScreenCover Link #3")
                        .coordinatable(to: AppLinks.Root.link3.rawValue,
                                       by: coordinator)
                        .foregroundColor(.blue)

                    Text("Unknown Link #4")
                        .coordinatable(to: "nav://unknown",
                                       by: coordinator)
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Navigation Demo")
        }
    }
}

private 

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
