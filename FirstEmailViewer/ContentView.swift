//
//  ContentView.swift
//  FirstEmailViewer
//
//  Created by Mohitkumar Gupta on 07/06/24.
//

import SwiftUI
import EmailPackage


struct ContentView: View {
    @State private var resultText: String = "First email will be shown here"
    @State private var showPackageView = false
    private let emailPackage: EmailPackageProtocol = EmailPackage()
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                showPackageView = true
            }) {
                Text("Show Email List")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Spacer()
            Text(resultText)
                .padding()
                .foregroundColor(.black)
            Spacer()
        }
        .onAppear {
            emailPackage.fetchFirstEmailClosure { email in
                DispatchQueue.main.async {
                    self.resultText = email
                    self.showPackageView = false
                }
            }
        }
        .sheet(isPresented: $showPackageView) {
            emailPackage.getEmailPackageView()
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
