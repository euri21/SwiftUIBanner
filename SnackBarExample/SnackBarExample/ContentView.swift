//
//  ContentView.swift
//  SnackBarExample
//
//  Created by solution888 on 4/25/22.
//

import SwiftUI

struct ContentView: View {
    @State var bannerData = BannerData(title: "Title", detail: "This is banner content", type: .info)
    @State var showBanner = false
    
    var body: some View {
        Button {
            showBanner.toggle()
        } label: {
            Text("Show Banner")
        }
        .banner(data: $bannerData, show: $showBanner)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
