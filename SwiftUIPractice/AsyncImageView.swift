//
//  AsyncImageView.swift
//  SwiftUIPractice
//
//  Created by Jain Ullas on 8/27/23.
//

import SwiftUI

struct AsyncImageView: View {
    @State private var showSheet = false
    private let imageURL: String = "https://images.unsplash.com/photo-1692736475332-381292eaed25?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2564&q=80"
    
    var body: some View {
        NavigationView {
            VStack {
                // MARK: Basic
                //            AsyncImage(url: URL(string: imageURL))
                
                // MARK: With Scale
                //            AsyncImage(url: URL(string: imageURL), scale: 3.0)
                
                // MARK: Placeholder
                //            AsyncImage(url: URL(string: imageURL)) { image in
                //                image
                //                    .imageModifier()
                //            } placeholder: {
                //                Image(systemName: "photo.circle.fill")
                //                    .iconModifier()
                //            }
                //            .padding(40)
                
                // MARK: Error with Animation
                AsyncImage(
                    url: URL(string: imageURL),
                    transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .imageModifier()
                                .transition(.scale)
                        case .failure(_):
                            Image(systemName: "ant.circle.fill")
                                .iconModifier()
                        case .empty:
                            Image(systemName: "photo.circle.fill")
                                .iconModifier()
                        @unknown default:
                            ProgressView()
                        }
                    }
                    .padding(40)
            }
        }
        .navigationBarBackButtonHidden(false)
    }
}

private extension Image {
    func imageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func iconModifier() -> some View {
        self
            .imageModifier()
            .frame(maxWidth: 128)
            .foregroundColor(.purple)
            .opacity(0.5)
    }
}


private extension AsyncImageView {
    
    func present(_ text: String, _ view: @escaping () -> some View) -> some View {
        VStack {
            Button(text) {
                showSheet.toggle()
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $showSheet) {
                view()
                    .presentationDetents([.large])
            }

            Spacer()
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView()
    }
}
