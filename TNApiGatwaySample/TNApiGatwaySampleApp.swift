//
//  TNMapSDKSampleApp.swift
//  TNMapSDKSample
//
//  Created by Kazi Md. Saidul on 30/4/25.
//

import SwiftUI
import UIKit

@main
struct TNMapSDKSampleApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .navigationTitle("API Gatway SDK Demos")
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Title
                Text("Choose a Demo")
                    .font(.title)
                    .padding(.top)

                // NavigationLink buttons
                NavigationLink(destination: APIURIProtocalDemoWrapper()) { // fixed typo
                    Text("API Gatway SDK Demo")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                // Add more buttons here if needed
            }
            .padding(.bottom)
        }
    }
}


struct APIURIProtocalDemoWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> APIURIProtocalDemo {
        return APIURIProtocalDemo()
    }

    func updateUIViewController(_ uiViewController: APIURIProtocalDemo, context: Context) {}
}
