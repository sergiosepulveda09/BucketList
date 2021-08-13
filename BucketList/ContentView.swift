//
//  ContentView.swift
//  BucketList
//
//  Created by Sergio Sepulveda on 2021-08-08.
//
import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = ViewModel()
    
    var body: some View {
        if vm.isUnlocked {
            MainView()
                .environmentObject(vm)
        } else {
            //button here
            Button("Unlock places") {
                vm.authenticate()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .alert(isPresented: $vm.biometricsRejected) {
                Alert(title: Text("Can't use biometrics"), message: Text("Please allow us to use them"), dismissButton: .default(Text("Go to settings"), action: {
                    guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsURL) {
                        UIApplication.shared.open(settingsURL) { (success) in
                            print("Settings opened: \(success)")
                        }
                    }
                }))
            }
        }
    }

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

