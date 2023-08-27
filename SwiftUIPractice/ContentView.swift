//
//  ContentView.swift
//  SwiftUIPractice
//
//  Created by Jain Ullas on 8/27/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: AsyncImageView()) {
                HStack(spacing: 8) {
                    Image(systemName: "photo.fill")
                    Text("AsyncImage")
                }
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.regular)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
