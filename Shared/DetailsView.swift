//
//  DetailsView.swift
//  NavigationDemo
//
//  Created by Артем Швецов on 04.01.2022.
//

import SwiftUI

struct DetailsView: View, Coordinatable {

    @Injected var coordinator: DetailsCoordinator

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 40) {
                Text("Navigation Link #1")
                    .coordinatable(to: AppLinks.Details.link1.rawValue,
                                   by: coordinator)
                    .foregroundColor(.black)

                Text("Presentation Link #2")
                    .coordinatable(to: AppLinks.Details.link2.rawValue,
                                   by: coordinator)
                    .foregroundColor(.green)

                Text("FullScreenCover Link #3")
                    .coordinatable(to: AppLinks.Details.link3.rawValue,
                                   by: coordinator)
                    .foregroundColor(.blue)

                Text("Unknown Link #4")
                    .coordinatable(to: "nav://unknown",
                                   by: coordinator)
                    .foregroundColor(.red)
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}
